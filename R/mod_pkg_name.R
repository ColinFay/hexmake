# Module UI
  
#' @title   mod_pkg_name_ui and mod_pkg_name_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_pkg_name
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_pkg_name_ui <- function(id){
  ns <- NS(id)
  tagList(
    tags$details(
      tags$summary("Manage name"),
      tags$div(
        class = "innerrounded rounded",
        fluidRow(
          col_12(
            textInput(
              ns("package"), 
              "Name", 
              value = "hexmake"
            )
          ), 
          tags$div(
            id = ns("xy"),
            col_6(
              numericInput(
                ns("p_x"),
                "x position for package name", 
                value = 1, 
                step = 0.1
              )
            ),
            col_6(
              numericInput(
                ns("p_y"), 
                "y position for package name", 
                value = 1.4, 
                step = 0.1
              )
            )
          )
          , 
          col_6(
            tags$label(
              `for` = "p_color", 
              "Font color for package name"
            ),
            tags$br(),
            tags$input(
              tags$br(),
              type = "color", 
              id = ns("p_color"), 
              value = "#FFFFFF", 
              name = "p_color"
              
            ) %>%
              tagAppendAttributes(
                onInput = sprintf(
                  "Shiny.setInputValue('%s', event.target.value)", 
                  ns("p_color")
                )
              )
          ),
          col_6(
            selectInput(
              ns("p_family"), 
              "Font family for package name", 
              selected = sysfonts::font_families()[1], 
              choices = sysfonts::font_families()
            ) %>%
              tagAppendAttributes(
                id = ns("fonfam")
              )
          ),
          col_6(
            numericInput(
              ns("p_size"), 
              "Font size for package name", 
              value = 8, 
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
#' #' @rdname mod_pkg_name
#' #' @export
#' #' @keywords internal
#'     
#' mod_pkg_name_server <- function(
#'   input, 
#'   output, 
#'   session, 
#'   img, 
#'   r
#' ){
#'   ns <- session$ns
#'   
#' }
    
