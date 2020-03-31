# Module UI

#' @title   mod_rendering_ui and mod_rendering_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_rendering
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList tags fluidRow checkboxInput actionButton icon
mod_rendering_ui <- function(id){
  ns <- NS(id)
  tagList(
    tags$details(
      summary("Rendering mode"), 
      tags$div(
        class = "innerrounded rounded",
        align = "center",
        fluidRow(
          tags$div(
            align = "center",
            col_4(
              checkboxInput(
                ns("live"), 
                "Live preview", 
                value = TRUE
              )
            )
          ),
          tags$div(
            align = "right",
            col_4(
              actionButton(
                ns("render"), 
                "Manual render", 
                icon = icon("arrow-right"), 
                `disabled` = "disable"
              )
            )
          )
        )
      )
    )
  )
}

# Module Server

#' @rdname mod_rendering
#' @export
#' @keywords internal
#' @importFrom golem invoke_js
#' @importFrom shiny observeEvent
#' @importFrom whereami cat_where whereami
mod_rendering_server <- function(
  input,
  output, 
  session, 
  r
){
  ns <- session$ns
  
  observeEvent( input$render , {
    cat_where(whereami())
    trigger("render")
  })
  
  observeEvent( input$live , {
    cat_where(whereami())
    if (input$live){
      invoke_js("disable", sprintf("#%s", ns("render")))
    } else {
      invoke_js("reable", sprintf("#%s", ns("render")))
    }
    r$live <- input$live
  })
  
}

