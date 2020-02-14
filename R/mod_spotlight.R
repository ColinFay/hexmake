# Module UI

#' @title   mod_spotlight_ui and mod_spotlight_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_spotlight
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_spotlight_ui <- function(id){
  ns <- NS(id)
  tagList(
    tags$details(
      tags$summary("Manage Spotlight"),
      tags$div(
        class = "innerrounded rounded",
        fluidRow(
          col_6(
            checkboxInput(
              ns("spotlight"), 
              "Add spotlight", 
              value = FALSE
            )
          ),
          col_6(
            numericInput(
              ns("l_x"), 
              "x position for spotlight", 
              value = 1, 
              step = 0.1
            )
          ),
          col_6(
            numericInput(
              ns("l_y"), 
              "y position for spotlight", 
              value = 0.5, 
              step = 0.1
            )
          ),
          col_6(
            numericInput(
              ns("l_width"), 
              "width for spotlight", 
              value = 3, 
              step = 0.1
            )
          ),
          col_6(
            numericInput(
              ns("l_height"), 
              "height for spotlight", 
              value = 3, 
              step = 0.1
            )
          ),
          col_6(
            numericInput(
              ns("l_alpha"), 
              "maximum alpha for spotlight", 
              value = 0.4, 
              step = 0.1
            )
          )
        )
      )
    )
  )
}

#' # Module Server
#' 
#' #' @rdname mod_spotlight
#' #' @export
#' #' @keywords internal
#' 
#' mod_spotlight_server <- function(
#'   input, 
#'   output, 
#'   session, 
#'   img, 
#'   r
#' ){
#'   ns <- session$ns
#'   
#' }

