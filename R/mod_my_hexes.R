# Module UI

#' @title   mod_my_hexes_ui and mod_my_hexes_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_my_hexes
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList  tags  fluidRow actionButton
mod_my_hexes_ui <- function(id){
  ns <- NS(id)
  tagList(
    tags$details(
      summary("Open Hex DataBase"), 
      tags$div(
        class = "innerrounded rounded",
        align = "center",
        fluidRow(
          col_12(
            h4("Browse the open db of hexes, save yours in it")
          ),
          col_6(
            actionButton(
              ns("save"), 
              "Save Current Hex to the DB"
            )
          ),
          col_6(
            actionButton(
              ns("restore"), 
              "Search Available Hexes"
            )
          )
        )
      )
    )
    
  )
}

# Module Server

#' @rdname mod_my_hexes
#' @export
#' @keywords internal
#' @importFrom whereami cat_where whereami
#' @importFrom digest digest
#' @importFrom knitr image_uri
#' @importFrom base64enc base64encode base64decode
#' @importFrom purrr pmap
#' @importFrom shiny removeModal modalDialog textInput tagList observeEvent modalDialog observeEvent showModal modalDialog tagList tags fluidRow tagAppendAttributes modalButton 
#' @importFrom fs file_temp file_copy file_delete file_temp
mod_my_hexes_server <- function(
  input, 
  output, 
  session,
  img
){
  ns <- session$ns
  
  savemodal <- function(failed = FALSE) {
    modalDialog(
      h4("Enter hex details"), 
      textInput(ns("name"), "Name"),
      textInput(ns("desc"), "Hex Description"),
      textInput(ns("author"), "Author")
      ,
      footer = tagList(
        modalButton("Nop, I changed my mind"),
        actionButton(ns("savehex"), "OK")
      )
    )
  }
  
  observeEvent( input$save , {
    cat_where(whereami())
    showModal(savemodal())
  })
  
  observeEvent( input$savehex , {
    cat_where(whereami())
    removeModal()  
    showModal(
      modalDialog(
        title = "This will save to the open db, sure?",
        footer = tagList(
          modalButton("Nop, I changed my mind"),
          actionButton(ns("oksave"), "Yes!")
        )
      )
    )
  })
  
  observeEvent( input$oksave , {
    cat_where(whereami())
    removeModal()  
    id <- digest(
      img$self_()
    )
    
    get_mongo()$insert(
      data.frame(
        hex = input$name,
        auth = input$author, 
        desc = input$desc,
        date = as.character(Sys.Date()), 
        id = id,
        base64 = image_uri(
          img$render()
        )
      )
    )
    
    temp_lc <- file_temp(ext = ".RDS")
    list(
      self = img$self_(), 
      img = base64encode(img$subplot)
    ) %>% saveRDS(temp_lc)
    
    get_gridfs()$write(
      temp_lc, 
      id
    )
  })
  
  observeEvent( input$restore , {
    cat_where(whereami())
    #golem::invoke_js("spinner_show", TRUE)
    shiny::withProgress(
      message = "Loading the hex from the DB", expr = {
        all<- get_mongo()$find()
        incProgress(0.5)
        showModal(
          modalDialog(
            easyClose = TRUE,
            title = "Available hexes",
            tagList(
              h4("Click on the image to restore it"), 
              tags$div(
                class = "gridimg", 
                pmap(
                  all, 
                  ~ {
                    tags$div(
                      tags$h3(..1), 
                      h4(
                        sprintf(
                          "Made by %s on %s", 
                          ..2, ..4
                        )
                      ),
                      tags$blockquote(
                        ..3
                      ),
                      tags$div(
                        class = "innersearch",
                        fluidRow(
                          col_6(
                            tags$img(
                              src = ..6, 
                              width = '100%'
                            )
                          ) %>%
                            tagAppendAttributes(
                              onclick = sprintf(
                                "Shiny.setInputValue('%s', $(this).attr('val'), {priority: 'event'})", 
                                ns("selected_image")
                              ), 
                              val = ..5
                            )
                          , 
                        )
                      )
                    )
                    
                  }
                )
              )
            ),
            footer = tagList(
              modalButton("Cancel")
            )
          )
        )
      }
    )
    
    #golem::invoke_js("spinner_hide", TRUE)
  })
  
  observeEvent( input$selected_image , {
    removeModal()
    cat_where(whereami())
    
    temp_rds <- file_temp(ext = ".RDS")
    get_gridfs()$read( input$selected_image , con = temp_rds )
    hxs <- readRDS(temp_rds)
    bin <- file_temp(
      ext = 'bin'
    )
    conn <- file(bin,"wb")
    writeBin(hxs$img, conn)
    close(conn)
    
    png <- file_temp(
      ext = 'png'
    )
    inconn <- file(bin,"rb")
    outconn <- file(png,"wb")
    base64decode(what=inconn, output=outconn)
    close(inconn)
    close(outconn)
    file_copy(
      png, 
      img$subplot, 
      TRUE
    )
    file_delete(bin)
    img$restore(hxs$self, png)
    img$new_original_image(png)
    img$saved_path <- png
    trigger("restore")
    trigger("render")
  })
  
  
  
}
