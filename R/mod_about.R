# Module UI

#' @title   mod_about_ui and mod_about_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_about
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_about_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidRow(
      col_6(
        actionButton(
          ns("showhowto"), 
          "How to use this app", 
          class = "modbutton"
        )
      ), 
      col_6(
        actionButton(
          ns("showmod"), 
          "About this app", 
          class = "modbutton"
        )
      )
    )
  )
}

# Module Server

#' @rdname mod_about
#' @export
#' @keywords internal

mod_about_server <- function(input, output, session){
  ns <- session$ns
  
  howtomodal <- function(failed = FALSE) {
    modalDialog(
      includeMarkdown(
        system.file(
          "app/howto.md", 
          package = "hexmake" 
        )
      )
      ,footer = tagList(
        actionButton(ns("ok"), "OK")
      )
    )
  }
  
  observeEvent(input$showhowto, {
    showModal(howtomodal())
  })
  
  aboutmodal <- function(failed = FALSE) {
    modalDialog(
      includeMarkdown(
        system.file(
          "app/about.md", 
          package = "hexmake" 
        )
      )
      ,footer = tagList(
        actionButton(ns("ok"), "OK")
      )
    )
  }
  
  observeEvent(input$showmod, {
    showModal(aboutmodal())
  })
  
  observeEvent( input$ok , {
    removeModal()
  })
  
}

## To be copied in the UI
# 

## To be copied in the server
# 

