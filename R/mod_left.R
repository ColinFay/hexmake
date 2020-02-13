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
mod_left_ui <- function(id){
  ns <- NS(id)
  tagList(
    tags$div(
      class = "rounded",
      h2("Build your own hex sticker"),
      mod_pkg_name_ui(ns("pkg_name_ui_1")),
      mod_image_ui(ns("image_ui_1")),
      mod_hexa_ui(ns("hexa_ui_1")),
      mod_spotlight_ui(ns("spotlight_ui_1")),
      mod_url_ui(ns("url_ui_1")), 
      mod_rendering_ui(ns("rendering_ui_1")), 
      mod_restore_ui(ns("restore_ui_1")),
      mod_dl_ui(ns("dl_ui_1")), 
      mod_about_ui(ns("about_ui_1"))
      
    )
  )
}

# Module Server

#' @rdname mod_left
#' @export
#' @keywords internal

mod_left_server <- function(
  input, 
  output, 
  session, 
  img, 
  r
){
  ns <- session$ns
  
  callModule(mod_pkg_name_server, "pkg_name_ui_1", img, r)
  
  callModule(mod_image_server, "image_ui_1", img, r)
  
  callModule(mod_hexa_server, "hexa_ui_1", img, r)
  
  callModule(mod_spotlight_server, "spotlight_ui_1", img, r)
  
  callModule(mod_url_server, "url_ui_1", img, r)
  
  callModule(mod_rendering_server, "rendering_ui_1", r)
  
  callModule(mod_restore_server, "restore_ui_1", img, r)
  
  callModule(mod_dl_server, "dl_ui_1", img)
  
  callModule(mod_about_server, "about_ui_1")
  
  
}

