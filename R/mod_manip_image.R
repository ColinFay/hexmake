# Module UI

#' @title   mod_manip_image_ui and mod_manip_image_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_manip_image
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_manip_image_ui <- function(
  id
){
  ns <- NS(id)
  tagList(
    modalDialog(
      size = "l",
      tagList(
        fluidRow(
          style = "padding:1em",
          col_6(
            fluidRow(
              tags$details(
                tags$summary("Blur image"),
                tags$div(
                  class = "modalinner innerrounded rounded",
                  col_12(
                    checkboxInput(
                      ns("blur"), 
                      "Blur"
                    ), 
                    col_6(
                      numericInput(
                        ns("radius_blur"), 
                        "Radius", 
                        min = 0, 
                        value = 1
                      )
                    ),
                    col_6(
                      numericInput(
                        ns("sigma_blur"), 
                        "Sigma", 
                        min = 0, 
                        value = 0.5
                      )
                    )
                  )
                )
              )
            )
            , 
            fluidRow(
              tags$details(
                tags$summary("Add Noise"),
                tags$div(
                  class = "modalinner innerrounded rounded",
                  col_12(
                    checkboxInput(
                      ns("noise"), 
                      "Noise"
                    ), 
                    col_12(
                      selectInput(
                        ns("noisetype"), 
                        "Noisetype", 
                        selected = magick::noise_types()[2], 
                        choices = magick::noise_types()
                      )
                    )
                    
                  )
                )
              )
            )
            ,
            fluidRow(
              tags$details(
                tags$summary("Charcoal image"),
                tags$div(
                  class = "modalinner innerrounded rounded",
                  col_12(
                    checkboxInput(
                      ns("charcoal"), 
                      "Charcoal"
                    ), 
                    col_6(
                      numericInput(
                        ns("radius_charcoal"), 
                        "Radius", 
                        min = 0, 
                        value = 1
                      )
                    ),
                    col_6(
                      numericInput(
                        ns("sigma_charcoal"), 
                        "Sigma", 
                        min = 0, 
                        value = 0.5
                      )
                    )
                  )
                )
              )
            )
            
          ), 
          col_6(
            imageOutput(ns("img"))
          )
        )
      ),
      footer = tagList(
        modalButton("Cancel"),
        actionButton(
          ns("ok"), 
          "Save this image"
        )
      )
    )
  )
}

# Module Server

#' @rdname mod_manip_image
#' @export
#' @keywords internal

mod_manip_image_server <- function(
  input, 
  output, 
  session, 
  img, 
  r
){
  ns <- session$ns
  
  init("redraw")
  
  observeEvent( img$subplot , {
    r$sub_file <- tempfile(fileext = ".png")
    file.copy(
      img$subplot, 
      r$sub_file
    )
    r$sub_file_read <- magick::image_read(r$sub_file)
  })
  
  
  output$img <- renderImage({
    watch("redraw")
    list(src = r$sub_file)
  }, deleteFile = FALSE)
  
  observeEvent( c(
    input$blur,
    input$radius_blur,
    input$sigma_blur,
    input$noise,
    input$noisetype, 
    input$charcoal,
    input$radius_charcoal,
    input$sigma_charcoal
  ), {
    r$sub_file_read <- magick::image_read(img$subplot)
    if (input$blur){
      r$sub_file_read <- magick::image_blur(
        r$sub_file_read, 
        input$radius_blur, 
        input$sigma_blur
      )
    }
    if (input$noise){
      r$sub_file_read <- magick::image_noise(
        r$sub_file_read, 
        input$noisetype
      )
    }
    if (input$charcoal){
      r$sub_file_read <- magick::image_charcoal(
        r$sub_file_read,
        input$radius_charcoal,
        input$sigma_charcoal
      )
    }
    magick::image_write(r$sub_file_read, r$sub_file)
    trigger("redraw")
  })
  
  
  observeEvent( input$ok , {
    img$subplot <- r$sub_file
    removeModal()
    trigger("render")
  })
  
}

## To be copied in the UI
# 

## To be copied in the server
# 

