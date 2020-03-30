# Module UI

#' @title   mod_dl_ui and mod_dl_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_dl
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_dl_ui <- function(id){
  ns <- NS(id)
  tagList(
    tags$details(
      tags$summary("Download the hex"),
      tags$div(
        class = "innerrounded rounded",
        align = "center",
        fluidRow(
          col_12(
            downloadButton(
              ns("dl"), 
              "Download the Hex"
            )
          ) 
        )
      )
    )
  )
}

# Module Server

#' @rdname mod_dl
#' @export
#' @keywords internal

mod_dl_server <- function(
  input, 
  output, 
  session, 
  img
){
  ns <- session$ns
  
  output$dl <- downloadHandler(
    filename = function() {
      paste('hex-', img$package, '.png', sep='')
    },
    content = function(con) {
      whereami::cat_where(whereami::whereami())
      img$render(con)
    }
  )
  
}

