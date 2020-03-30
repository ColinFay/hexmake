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
            tags$p("Upload an image")
          ),
          col_6(
            tags$p("Modify your image")
          ),
          col_6(
            fileInput(ns("file"), NULL, accept = c(".png", ".jpg", ".jpeg")) %>%
              tagAppendAttributes(
                id = ns("uploaddiv")
              )
          ), 
          col_6(
            actionButton(
              ns("manip"), 
              "Modify"
            )
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
  
  bind_events(
    ids = c(
      "s_x", 
      "s_y", 
      "s_width", 
      "s_height", 
      "asp", 
      "dpi"
    ), 
    img, 
    r, 
    parent_input = input
  )
  
  observeEvent( input$file , {
    whereami::cat_where(whereami::whereami())
    
    # Square the image
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
    
    # Save the squared image as the new original image
    magick::image_write(
      image, 
      img$original_image
    )
    fs::file_copy(
      img$original_image, 
      img$subplot, 
      TRUE
    )
    fs::file_copy(
      img$original_image, 
      r$sub_file, 
      TRUE
    )
    
    assert_different(r, img)
    if (r$live) trigger("render")
    trigger("restore_modifs_checks")
    trigger("redraw")
  })
  
  observeEvent(input$manip, {
    
    whereami::cat_where(whereami::whereami())
    
    showModal(
      mod_manip_image_ui(ns("manip_image_ui_1"))
    )
  })
  
  callModule(
    mod_manip_image_server, 
    "manip_image_ui_1", 
    img, 
    r
  )
  
}
