# Module UI

#' @title   mod_left_ui and mod_left_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_left
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
#' @import magrittr
#' @importFrom golem get_golem_options
mod_left_ui <- function(id){
  ns <- NS(id)
  tagList(
    tags$div(
      class = "rounded",
      h2("Build your own hex sticker"),
      h3("Hex design"),
      mod_pkg_name_ui(ns("pkg_name_ui_1")),
      mod_image_ui(ns("image_ui_1")),
      mod_hexa_ui(ns("hexa_ui_1")),
      mod_spotlight_ui(ns("spotlight_ui_1")),
      mod_url_ui(ns("url_ui_1")), 
      h3("Save/Restore hex"),
      mod_restore_ui(ns("restore_ui_1")),
      if ( golem::get_golem_options("with_mongo") ){
        mod_my_hexes_ui(ns("my_hexes_ui_1"))    
      },
      mod_dl_ui(ns("dl_ui_1")), 
      h3("Config"),
      mod_rendering_ui(ns("rendering_ui_1")), 
      h3("About"),
      mod_about_ui(ns("about_ui_1")), 
      mod_guided_tour_ui(ns("guided_tour_ui_1")),
      h3("Prizes"),
      mod_prizes_ui(ns("prizes_ui_1"))
    )
  )
}

# Module Server

#' @rdname mod_left
#' @export
#' @keywords internal
#' @importFrom shiny callModule
mod_left_server <- function(
  input, 
  output, 
  session, 
  img, 
  r
){
  ns <- session$ns
  
  callModule(
    mod_binder_server, 
    "pkg_name_ui_1", 
    img, 
    r, 
    ids = c(
      "package", 
      "p_x", 
      "p_y", 
      "p_color", 
      "p_family",
      "p_size"
    )
  )
  
  callModule(
    mod_image_server, 
    "image_ui_1", 
    img, 
    r
  )
  
  callModule(
    mod_binder_server, 
    "hexa_ui_1", 
    img, 
    r, 
    ids = c(
      "h_size", 
      "h_fill", 
      "h_color"
    )
  )
  
  callModule(
    mod_binder_server, 
    "spotlight_ui_1", 
    img, 
    r, 
    ids = c(
      "spotlight", 
      "l_x", 
      "l_y", 
      "l_width", 
      "l_height", 
      "l_alpha"
    )
  )
  
  callModule(
    mod_binder_server, 
    "url_ui_1", 
    img, 
    r, 
    ids = c(
      "url", 
      "u_x", 
      "u_y", 
      "u_color", 
      "u_family",
      "u_size", 
      "u_angle"
    )
  )
  
  
  callModule(
    mod_rendering_server, 
    "rendering_ui_1", 
    r
  )
  
  callModule(
    mod_restore_server, 
    "restore_ui_1", 
    img, 
    r
  )
  
  callModule(
    mod_dl_server, 
    "dl_ui_1", 
    img
  )
  
  callModule(
    mod_about_server, 
    "about_ui_1"
  )
  
  callModule(
    mod_guided_tour_server, 
    "guided_tour_ui_1", 
    r
  )
  
  callModule(
    mod_my_hexes_server, 
    "my_hexes_ui_1", 
    img
  )
  
  
}

