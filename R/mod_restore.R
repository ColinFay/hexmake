# Module UI
  
#' @title   mod_restore_ui and mod_restore_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_restore
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList tags fluidRow actionButton tagAppendAttributes downloadButton
mod_restore_ui <- function(id){
  ns <- NS(id)
  tagList(
    tagList(
      tags$details(
        h4("Manage hex config"),
        tags$div(
          class = "innerrounded rounded",
          align = "center",
          fluidRow(
            col_4(
              actionButton(
                ns("restore"), 
                "Restore to default"
              ) %>% tagAppendAttributes(
                class = "padded"
              )
            ), 
            col_4(
              downloadButton(
                ns("dl"), 
                "Download config"
              ) %>% tagAppendAttributes(
                class = "padded"
              )
            ), 
            col_4(
              fileInput(
                ns("file"), 
                "Upload a config"
                )
            ) 
          )
        )
      )
    )
  )
}
    
# Module Server
    
#' @rdname mod_restore
#' @export
#' @keywords internal
    
#' @importFrom shiny observeEvent downloadHandler
#' @importFrom whereami cat_where whereami
mod_restore_server <- function(
  input, 
  output, 
  session, 
  img, 
  r
){
  ns <- session$ns
  
  observeEvent( input$restore , {
    cat_where(whereami())
    img$restore()
    trigger("render")
  }, ignoreInit = TRUE)
  
  output$dl <- downloadHandler(
    filename = function() {
      paste('hex-', img$package, '.hex', sep='')
    },
    content = function(con) {
      cat_where(whereami())
      img$export(con)
    }
  )
  
  observeEvent( input$file , {
    cat_where(whereami())
    hxs <- readRDS(input$file$datapath)
    img$restore(hxs$self, hxs$img)
    if (r$live) trigger("render")
  })
  
}
