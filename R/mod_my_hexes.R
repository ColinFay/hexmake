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
#' @importFrom shiny NS tagList 
mod_my_hexes_ui <- function(id){
  ns <- NS(id)
  tagList(
    tags$details(
      tags$summary("Open Hex DataBase"), 
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
    whereami::cat_where(whereami::whereami())
    showModal(savemodal())
  })
  
  observeEvent( input$savehex , {
    whereami::cat_where(whereami::whereami())
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
    whereami::cat_where(whereami::whereami())
    removeModal()  
    id <- digest::digest(
      img$self_()
    )
    
    browser()
    
    get_mongo()$insert(
      data.frame(
        hex = input$name,
        auth = input$author, 
        desc = input$desc,
        date = as.character(Sys.Date()), 
        id = id,
        base64 = knitr::image_uri(
          img$render()
        )
      )
    )
    
    temp_lc <- tempfile(fileext = ".RDS")
    list(
      self = img$self_(), 
      img = base64enc::base64encode(img$subplot)
    ) %>% saveRDS(temp_lc)
    
    get_gridfs()$write(
      temp_lc, 
      id
    )
  })
  
  observeEvent( input$restore , {
    whereami::cat_where(whereami::whereami())
    all<- get_mongo()$find()
    
    showModal(
      modalDialog(
        easyClose = TRUE,
        title = "Available hexes",
        tagList(
          h4("Click on the image to restore it"), 
          tags$div(
            class = "gridimg", 
            purrr::pmap(
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
  })
  
  observeEvent( input$selected_image , {
    shiny::removeModal()
    whereami::cat_where(whereami::whereami())
    temp_rds <- fs::file_temp(ext = ".RDS")
    get_gridfs()$read( input$selected_image , con = temp_rds )
    hxs <- readRDS(temp_rds)
    bin <- fs::file_temp(
      ext = 'bin'
    )
    conn <- file(bin,"wb")
    writeBin(hxs$img, conn)
    close(conn)
    
    png <- fs::file_temp(
      ext = 'png'
    )
    inconn <- file(bin,"rb")
    outconn <- file(png,"wb")
    base64enc::base64decode(what=inconn, output=outconn)
    close(inconn)
    close(outconn)
    fs::file_copy(
      png, 
      img$subplot, 
      TRUE
    )
    fs::file_delete(bin)
    img$restore(hxs$self, png)
    trigger("render")
  })
  
  
  
}
