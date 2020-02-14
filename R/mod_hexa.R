# Module UI

#' @title   mod_hexa_ui and mod_hexa_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_hexa
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_hexa_ui <- function(id){
  ns <- NS(id)
  tagList(
    tags$details(
      tags$summary("Manage Hexagon"),
      tags$div(
        class = "innerrounded rounded",
        fluidRow(
          col_6(
            numericInput(
              ns("h_size"), 
              "Size for hexagon border", 
              value = 1.2, 
              step = 0.1
            )
          ),
          col_6(
            tags$label(
              `for` = "p_color", 
              "Color to fill hexagon"
            ),
            tags$br(),
            tags$input(
              tags$br(),
              type = "color", 
              id = ns("h_fill"), 
              value = "#1881C2", 
              name = "p_color"
              
            ) %>%
              tagAppendAttributes(
                onInput = sprintf(
                  "Shiny.setInputValue('%s', event.target.value)", 
                  ns("h_fill")
                )
              )
          ),
          col_6(
            tags$label(
              `for` = "h_color", 
              "Color for hexagon border"
            ),
            tags$br(),
            tags$input(
              tags$br(),
              type = "color", 
              id = ns("h_color"), 
              value = "#87B13F", 
              name = "p_color"
              
            ) %>%
              tagAppendAttributes(
                onInput = sprintf(
                  "Shiny.setInputValue('%s', event.target.value)", 
                  ns("h_color")
                )
              )
          )
        )
      )
    )
  )
}

#' # Module Server
#' 
#' #' @rdname mod_hexa
#' #' @export
#' #' @keywords internal
#' 
#' mod_hexa_server <- function(
#'   input, 
#'   output, 
#'   session, 
#'   img, 
#'   r
#' ){
#'   ns <- session$ns
#'   
#' }


