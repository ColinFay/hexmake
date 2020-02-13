# Module UI

#' @title   mod_url_ui and mod_url_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_url
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_url_ui <- function(id){
  ns <- NS(id)
  tagList(
    tags$details(
      tags$summary("Manage URL"),
      tags$div(
        class = "innerrounded rounded",
        fluidRow(
          col_6(
            textInput(
              ns("url"), 
              "url at lower border", 
              value = ""
            )
          ),
          col_6(
            numericInput(
              ns("u_x"), 
              "x position for url", 
              value = 1, 
              step = 0.1
            )
          ),
          col_6(
            numericInput(
              ns("u_y"), 
              "y position for url", 
              value = 0.08, 
              step = 0.1
            )
          ), 
          col_6(
            tags$label(
              `for` = "u_color", 
              "Color for url"
            ),
            tags$br(),
            tags$input(
              tags$br(),
              type = "color", 
              id = ns("u_color"), 
              value = "#000000", 
              name = "u_color"
              
            ) %>%
              tagAppendAttributes(
                onInput = sprintf(
                  "Shiny.setInputValue('%s', event.target.value)", 
                  ns("u_color")
                )
              )
          ),
          col_6(
            selectInput(
              ns("u_family"), 
              "Font family for url",
              selected = sysfonts::font_families()[1], 
              choices = sysfonts::font_families()
            )
          ),
          col_6(
            numericInput(
              ns("u_size"), 
              "Text size for url", 
              value = 1.5, 
              step = 0.1
            )
          ),
          col_6(
            numericInput(
              ns("u_angle"), 
              "Angle for url", 
              value = 30, 
              step = 1
            )
          )
        )
      )
    )
  )
}

# Module Server

#' @rdname mod_url
#' @export
#' @keywords internal

mod_url_server <- function(
  input, 
  output, 
  session, 
  img, 
  r
){
  ns <- session$ns
  
  lapply(
    c(
      "url", 
      "u_x", 
      "u_y", 
      "u_color", 
      "u_family",
      "u_size", 
      "u_angle"
    ), function(x){
      observeEvent( input[[x]] , {
        img[[x]] <- input[[x]]
        if (r$live) trigger("render")
      })
    }
  )
  
}

## To be copied in the UI
#

## To be copied in the server
# 

