#' guided_tour UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList  tags fluidRow actionButton
mod_guided_tour_ui <- function(id){
  ns <- NS(id)
  tagList(
    tags$details(
      summary("Get a Guided Tour"), 
      tags$div(
        class = "innerrounded rounded",
        align = "center",
        fluidRow(
          col_12(
            actionButton(
              ns("get"), 
              "How to use this app", 
              class = "modbutton"
            )
          )
        )
      )
    )
    
  )
}

#' guided_tour Server Function
#'
#' @noRd 
#' @importFrom golem invoke_js
#' @importFrom cicerone Cicerone
#' @importFrom purrr pmap
#' @importFrom shiny NS
mod_guided_tour_server <- function(
  input, 
  output, 
  session,
  r
  ){
  ns <- session$ns
  
  observeEvent( input$get , {
    invoke_js(
      "drive", list(arg = TRUE)
    )
    guide <- Cicerone$
      new(
        allow_close = FALSE, 
        opacity = 0.75, 
        stage_background = "transparent"
      )
    
    ns <- NS("main_ui_1-left_ui_1")
    
    pmap(
      data.frame(
        ids = c(
          ns("pkg_name_ui_1-package"),
          ns("pkg_name_ui_1-p_x"),
          ns("pkg_name_ui_1-p_y"),
          ns("pkg_name_ui_1-p_color"),
          ns("pkg_name_ui_1-fonfam"),
          ns("pkg_name_ui_1-p_size"),
          ns("image_ui_1-uploaddiv"),
          ns("image_ui_1-manip"),
          ns("image_ui_1-s_x"),
          ns("image_ui_1-s_y"),
          ns("image_ui_1-s_width"),
          ns("image_ui_1-s_height"),
          ns("image_ui_1-asp"),
          ns("image_ui_1-dpi"),
          ns("hexa_ui_1-h_size"),
          ns("hexa_ui_1-h_fill"),
          ns("hexa_ui_1-h_color"),
          ns("spotlight_ui_1-spotlight"), 
          ns("spotlight_ui_1-l_x"),
          ns("spotlight_ui_1-l_y"),
          ns("spotlight_ui_1-l_width"),
          ns("spotlight_ui_1-l_height"), 
          ns("spotlight_ui_1-l_alpha"),
          ns("url_ui_1-url"),
          ns("url_ui_1-u_x"),
          ns("url_ui_1-u_y"),
          ns("url_ui_1-u_color"),
          ns("url_ui_1-u_family"),
          ns("url_ui_1-u_size"),
          ns("url_ui_1-u_angle"),
          ns("restore_ui_1-restore"), 
          ns("restore_ui_1-dl"),
          ns("restore_ui_1-file"), 
          ns("my_hexes_ui_1-save"),
          ns("my_hexes_ui_1-restore"), 
          ns("dl_ui_1-dl"),
          ns("rendering_ui_1-live"), 
          ns("rendering_ui_1-render")
        ), 
        titles = c(
          "Name", 
          "Name Position", 
          "Name Position", 
          "Name Color", 
          "Name Font",
          "Name Size",
          "Hex Image", 
          "Modify Image", 
          "Image Position",
          "Image Position",
          "Image Size",
          "Image Size", 
          "Image Aspect",
          "Image Aspect",
          "Hex Borders",
          "Hex Colors",
          "Hex Colors",
          "Spotlight", 
          "Spotlight Position", 
          "Spotlight Position", 
          "Spotlight Size", 
          "Spotlight Size", 
          "Spotligth Alpha", 
          "URL", 
          "URL Position",
          "URL Position",
          "URL Color", 
          "URL Font", 
          "URL Size", 
          "URL Angle",
          "Restore to default", 
          "Download Config", 
          "Upload Config", 
          "Save your Hex in the Open Hex DataBase", 
          "Browse the Open Hex DataBase", 
          "Download hex", 
          "Live rendering", 
          "Launch rendering"
        ), 
        texts = c(
          "Here, you can change the name of the package.", 
          "Change the x position of the package name using this numeric input.", 
          "Change the y position of the package name using this numeric input.",
          "You can select here a different color for the package name.", 
          "Use this input to change the font used for the package name.", 
          "Change the size of the package name using this numeric input.", 
          "Upload a new Image from your Computer",
          "Use <a href = 'https://github.com/ropensci/magick'>{magick}</a> to change your image.", 
          "Change the x position of the image.",
          "Change the y position of the image.",
          "Modify the size of the image using these two numeric inputs",
          "Modify the size of the image using these two numeric inputs",
          "Modify the aspect ratio of the image.", 
          "This numeric input modify the resolution of your image.",
          "Change the size of the hex borders.",
          "These two inputs control the colors of the hex.",
          "These two inputs control the colors of the hex.", 
          "Add a Spotlight on the hex.", 
          "Change the x position of the Spotlight.",
          "Change the y position of the Spotlight.",
          "Change the width of the Spotlight.",
          "Change the height of the Spotlight.", 
          "Modify the alpha of the Spotlight.", 
          "Add a URL at the lower border.", 
          "Modify the x position of the URL.",
          "Modify the y position of the URL.",
          "Modify the color of the URL.", 
          "Select a Font for the URL.", 
          "Change the Size of the URL.", 
          "Modify the angle of the URL.", 
          "Restore every config to their default.", 
          "Download a .hex file with an hex configuration.", 
          "Upload a previously downloaded hex configuration.",
          "This will save your current hex inside the Open Hex Database.",
           "Browse the database to restore a configuration.",
          "Download the hex in png.", 
          "Enable live rendering.", 
          "If live rendering is disable, use this button to render the hex <button>pouet</button>."
        )
      ), ~ {
        guide$step(
          ..1,  ..2, ..3
        )
      }
    )
    
    guide$
      init()$
      start()
  })
}
