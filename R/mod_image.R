# Module UI
  
#' @title   mod_image_ui and mod_image_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_image
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_image_ui <- function(id){
  ns <- NS(id)
  tagList(
    tags$details(
      tags$summary("Manage image"),
      tags$div(
        class = "innerrounded rounded",
        fluidRow(
          col_6(
            fileInput(ns("file"), "Upload a file")
          ), 
          col_6(
            HTML("&nbsp;")
          )
        ), 
        fluidRow(
          col_6(
            numericInput(
              ns("s_x"), 
              "x position for image", 
              value = 1, 
              step = 0.1
            )
          ),
          col_6(
            numericInput(
              ns("s_y"), 
              "y position for image", 
              value = 0.7, 
              step = 0.1
            )
          ),
          col_6(
            numericInput(
              ns("s_width"), 
              "Width for image", 
              value = 0.4, 
              step = 0.1
            )
          ),
          col_6(
            numericInput(
              ns("s_height"), 
              "Height for image", 
              value = 1, 
              step = 0.1
            )
          ), 
          col_6(
            numericInput(
              ns("asp"), 
              "Aspect ratio", 
              value = 1, 
              step = 0.1
            )
          ),
          col_6(
            numericInput(
              ns("dpi"), 
              "Resolution", 
              value = 600, 
              step = 1
            )
          )
        )
      )
    )
  )
}
    
# Module Server
    
#' @rdname mod_image
#' @export
#' @keywords internal
    
mod_image_server <- function(
  input, 
  output, 
  session, 
  img, 
  r
){
  ns <- session$ns
  
  lapply(
    c(
      "s_x", 
      "s_y", 
      "s_width", 
      "s_height", 
      "asp", 
      "dpi"
    ), function(x){
      observeEvent( input[[x]] , {
        img[[x]] <- input[[x]]
        if (r$live) trigger("render")
      })
    }
  )
  
  observeEvent( input$file , {
    
    image <- magick::image_read(
      input$file$datapath
    )
    size <- ifelse(
      magick::image_info(image)$width > magick::image_info(image)$height, 
      magick::image_info(image)$width, 
      magick::image_info(image)$height
    )
    
    image <- magick::image_extent(
      image, 
      sprintf("%sx%s", size, size)
    )
    x <- tempfile(fileext = "png")
    magick::image_write(
      image, 
      x
    )
    img$subplot <- x
    if (r$live) trigger("render")
  })
  
}
    
## To be copied in the UI
# 
    
## To be copied in the server
# 
 
