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
      easyClose = TRUE,
      size = "l",
      tagList(
        fluidRow(
          style = "padding:1em",
          col_6(
            id = ns("effectslist"),
            fluidRow(
              HTML(
                "For more info about these effects, see the <a target = '_blank' href = 'https://cran.r-project.org/web/packages/magick/vignettes/intro.html'>{magick}</a> package documentation."
              )
            ),
            fluidRow(
              h4("Image Effects")
            ),
            modalinner(
              summary = "Despeckle", 
              checkbox_id = "despeckle", 
              parent_ns = ns, 
              col_6(
                numericInput(
                  ns("times"),  
                  "Time", 
                  min = 0, 
                  value = 0
                )
              )
            ),
            modalinner(
              summary = "Reduce Noise", 
              checkbox_id = "reducenoise", 
              parent_ns = ns, 
              col_6(
                numericInput(
                  ns("radius_reducenoise"), 
                  "Radius", 
                  min = 0, 
                  value = 1
                )
              )
            )
            , 
            modalinner(
              summary = "Add Noise", 
              checkbox_id = "noise", 
              parent_ns = ns, 
              col_12(
                selectInput(
                  ns("noisetype"), 
                  "Noisetype", 
                  selected = magick::noise_types()[2], 
                  choices = magick::noise_types()
                )
              )
            )
            ,
            modalinner(
              summary = "Blur", 
              checkbox_id = "blur", 
              parent_ns = ns, 
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
            ),
            modalinner(
              summary = "Charcoal", 
              checkbox_id = "charcoal", 
              parent_ns = ns, 
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
            ,
            modalinner(
              summary = "oilpaint", 
              checkbox_id = "oilpaint", 
              parent_ns = ns, 
              col_6(
                numericInput(
                  ns("oilpaint_radius"), 
                  "Radius", 
                  min = 0, 
                  value = 1
                )
              )
            )
            ,
            modalinner(
              summary = "emboss", 
              checkbox_id = "emboss", 
              parent_ns = ns, 
              col_6(
                numericInput(
                  ns("emboss_radius"), 
                  "Radius", 
                  min = 0, 
                  value = 1
                )
              ),
              col_6(
                numericInput(
                  ns("emboss_sigma"), 
                  "Sigma", 
                  min = 0, 
                  value = 0.5
                )
              )
            )
            ,
            modalinner(
              summary = "implode", 
              checkbox_id = "implode", 
              parent_ns = ns, 
              col_6(
                numericInput(
                  ns("implode_factor"), 
                  "Factor", 
                  min = 0, 
                  value = 1
                )
              )
            )
            , 
            modalinner(
              summary = "negate", 
              checkbox_id = "negate", 
              parent_ns = ns
            )
            , 
            fluidRow(
              h4("Image Effects")
            ),
            modalinner(
              summary = "rotate", 
              checkbox_id = "rotate", 
              parent_ns = ns, 
              col_6(
                sliderInput(
                  ns("rotate_degrees"), 
                  "Degrees", 
                  min = 0,
                  value = 0,
                  max = 360
                )
              )
            )
            , 
            modalinner(
              summary = "trim", 
              checkbox_id = "trim", 
              parent_ns = ns, 
              col_6(
                numericInput(
                  ns("trim_fuzz"), 
                  "fuzz", 
                  value = 0
                )
              )
            )
            ,
            fluidRow(
              tags$details(
                summary("Flip flop image"),
                tags$div(
                  class = "modalinner innerrounded rounded",
                  col_6(
                    checkboxInput(
                      ns("flip"), 
                      "Flip"
                    )
                  ), 
                  col_6(
                    checkboxInput(
                      ns("flop"), 
                      "Flop"
                    )
                  )
                )
              )
            )
            , 
            fluidRow(
              tags$details(
                summary("Modulate"),
                tags$div(
                  class = "modalinner innerrounded rounded",
                  col_12(
                    checkboxInput(
                      ns("modulate"), 
                      "Modulate"
                    )
                  ), 
                  col_4(
                    numericInput(
                      ns("brightness"), 
                      "Brightness", 
                      value = 100
                    )
                  ), 
                  col_4(
                    numericInput(
                      ns("saturation"), 
                      "Saturation", 
                      value = 100
                    )
                  ), 
                  col_4(
                    numericInput(
                      ns("hue"), 
                      "Hue", 
                      value = 100
                    )
                  )
                )
              )
            )
            , 
            
            fluidRow(
              tags$details(
                summary("Deskew image"),
                tags$div(
                  class = "modalinner innerrounded rounded",
                  col_6(
                    checkboxInput(
                      ns("deskew"), 
                      "Flip"
                    )
                  ), 
                  col_6(
                    numericInput(
                      ns("deskew_threshold"), 
                      "Threshold", 
                      value = 40
                    )
                  )
                )
              )
            )
            , 
            fluidRow(
              h4("Restore")
            ),
            col_12(
              actionButton(
                ns("restoreoriginal"), 
                "Restore original image"
              )
            )
          ), 
          col_6(
            tags$div(
              imageOutput(ns("img")) %>%
                tagAppendAttributes(
                  class = "innermanip"
                )
            )
          )
        )
      ),
      footer = tagList(
        modalButton("Cancel"),
        actionButton(
          ns("okokok"), 
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
#' @importFrom magick noise_types image_read image_despeckle image_reducenoise image_noise image_blur image_charcoal image_oilpaint image_emboss image_implode image_negate image_trim image_rotate image_flip image_flop image_modulate image_deskew image_orient image_write
#' @importFrom whereami cat_where whereami
#' @importFrom fs file_temp file_copy
#' @importFrom tools file_ext
#' @importFrom  shiny observeEvent renderImage withProgress removeModal req updateCheckboxInput
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
    whereami::cat_where(whereami::whereami())
    
    # r$sub_file is the one shown inside the modal
    # Everytime subplot is changed, it need to be copied
    if (is.null( r$sub_file )){
      r$sub_file <- fs::file_temp(
        tools::file_ext(
          img$subplot
        )
      )
    }
    fs::file_copy(
      img$subplot,
      r$sub_file, 
      TRUE
    )
    
  })
  
  
  output$img <- renderImage({
    watch("redraw")
    whereami::cat_where(whereami::whereami())
    # We draw r$sub_file, which contains either the original image
    # or the one transformed by magick
    list(src = r$sub_file)
  }, deleteFile = FALSE)
  
  observeEvent( c(
    input$times, 
    input$despeckle,
    input$reducenoise, 
    input$radius_reducenoise,
    input$blur,
    input$radius_blur,
    input$sigma_blur,
    input$noise,
    input$noisetype, 
    input$charcoal,
    input$radius_charcoal,
    input$sigma_charcoal, 
    input$oilpaint,
    input$oilpaint_radius, 
    input$emboss, 
    input$emboss_radius, 
    input$emboss_sigma,
    input$implode, 
    input$implode_factor,
    input$negate,
    input$trim, 
    input$trim_fuzz, 
    input$rotate, 
    input$rotate_degrees, 
    input$flip, 
    input$flop, 
    input$modulate, 
    input$brightness, 
    input$saturation, 
    input$hue, 
    input$orient, 
    input$deskew
  ), {
    whereami::cat_where(whereami::whereami())
    withProgress(
      message = "Rendering image"
      , {
        
        # We read sub_file here as a magick object
        r$sub_file_read <- magick::image_read(img$subplot)
        
        if (input$despeckle){
          r$sub_file_read <- magick::image_despeckle(
            r$sub_file_read, 
            input$times
          )
        }
        
        if (input$reducenoise){
          r$sub_file_read <- magick::image_reducenoise(
            r$sub_file_read, 
            input$radius_reducenoise
          )
        }
        if (input$noise){
          r$sub_file_read <- magick::image_noise(
            r$sub_file_read, 
            input$noisetype
          )
        }
        if (input$blur){
          r$sub_file_read <- magick::image_blur(
            r$sub_file_read, 
            input$radius_blur, 
            input$sigma_blur
          )
        }
        if (input$charcoal){
          r$sub_file_read <- magick::image_charcoal(
            r$sub_file_read,
            input$radius_charcoal,
            input$sigma_charcoal
          )
        }
        
        if (input$oilpaint){
          r$sub_file_read <- magick::image_oilpaint(
            r$sub_file_read,
            input$oilpaint_radius
          )
        }
        
        if (input$emboss){
          r$sub_file_read <- magick::image_emboss(
            r$sub_file_read,
            input$emboss_radius, 
            input$emboss_sigma
          )
        }
        
        if (input$implode){
          r$sub_file_read <- magick::image_implode(
            r$sub_file_read,
            input$implode_factor
          )
        }
        
        if (input$negate){
          r$sub_file_read <- magick::image_negate(
            r$sub_file_read
          )
        }
        
        if (input$trim){
          r$sub_file_read <- magick::image_trim(
            r$sub_file_read, 
            input$trim_fuzz
          )
        }
        
        if (input$rotate){
          r$sub_file_read <- magick::image_rotate(
            r$sub_file_read,
            input$rotate_degrees
          )
        }
        if (input$flip){
          r$sub_file_read <- magick::image_flip(
            r$sub_file_read
          )
        }
        if (input$flop){
          r$sub_file_read <- magick::image_flop(
            r$sub_file_read
          )
        }
        if (input$modulate){
          r$sub_file_read <- magick::image_modulate(
            r$sub_file_read, 
            input$brightness, 
            input$saturation, 
            input$hue
          )
        }
        
        if (input$deskew){
          r$sub_file_read <- magick::image_deskew(
            r$sub_file_read, 
            input$deskew_threshold
          )
        }
        
        magick::image_write(
          r$sub_file_read, 
          r$sub_file
        )
        
        assert_different(r, img)
        trigger("redraw")
        
      })
  })
  
  observeEvent( input$restoreoriginal , {
    
    # Restore to original is recopying 
    # img$original_image to r$sub_file
    fs::file_copy(
      img$original_image,
      r$sub_file, 
      overwrite = TRUE
    )
    assert_different(r, img)
    trigger("redraw")
  })
  
  observeEvent( input$okokok , {
    removeModal()
    whereami::cat_where(whereami::whereami())
    for (i in c(
      "times", 
      "despeckle",
      "reducenoise", 
      "radius_reducenoise",
      "blur",
      "radius_blur",
      "sigma_blur",
      "noise",
      "noisetype", 
      "charcoal",
      "radius_charcoal",
      "sigma_charcoal", 
      "oilpaint",
      "oilpaint_radius", 
      "emboss", 
      "emboss_radius", 
      "emboss_sigma",
      "implode", 
      "implode_factor",
      "negate",
      "trim", 
      "trim_fuzz", 
      "rotate", 
      "rotate_degrees", 
      "flip", 
      "flop", 
      "modulate", 
      "brightness", 
      "saturation", 
      "hue", 
      "orient", 
      "deskew"
    )){
      updateCheckboxInput(
        session, 
        inputId = i,
        value = FALSE
      )
      fs::file_copy(
        r$sub_file,
        img$subplot,
        TRUE
      )
      trigger("render")
    }
  }) 
  
  observeEvent( c(
    input$restoreoriginal
  ), {
    
    whereami::cat_where(whereami::whereami())
    for (i in c(
      "times", 
      "despeckle",
      "reducenoise", 
      "radius_reducenoise",
      "blur",
      "radius_blur",
      "sigma_blur",
      "noise",
      "noisetype", 
      "charcoal",
      "radius_charcoal",
      "sigma_charcoal", 
      "oilpaint",
      "oilpaint_radius", 
      "emboss", 
      "emboss_radius", 
      "emboss_sigma",
      "implode", 
      "implode_factor",
      "negate",
      "trim", 
      "trim_fuzz", 
      "rotate", 
      "rotate_degrees", 
      "flip", 
      "flop", 
      "modulate", 
      "brightness", 
      "saturation", 
      "hue", 
      "orient", 
      "deskew"
    )){
      updateCheckboxInput(
        session, 
        inputId = i,
        value = FALSE
      )
    }
    
    req(r$sub_file)
    fs::file_copy(
      img$original_image, 
      r$sub_file,
      TRUE
    )
    trigger("render")
  })
  
}

