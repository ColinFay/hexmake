# Module UI
  
#' @title   mod_main_ui and mod_main_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_main
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_main_ui <- function(id){
  ns <- NS(id)
  tagList(
    tags$div(
      class="container", 
      tags$div(
        class="row", 
        tags$div(
          class="col left split", 
          mod_left_ui(ns("left_ui_1"))
        ), 
        tags$div(
          class = "col right split", 
          mod_right_ui(ns("right_ui_1"))
        ) 
      )
    ), 
    tags$div(
      class = "realmiddle", 
      tags$i(
        class="arrow rightarrow"
      )
    )
  )
}
    
# Module Server
    
#' @rdname mod_main
#' @export
#' @keywords internal
    
mod_main_server <- function(input, output, session){
  ns <- session$ns
  img <- Hex$new()
  init("render")
  callModule(mod_left_server, "left_ui_1", img)
  callModule(mod_right_server, "right_ui_1", img)
}
    
