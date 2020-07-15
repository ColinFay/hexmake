# Module UI

#' @title   mod_binder_ui and mod_binder_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_binder
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_binder_ui <- function(id){
  ns <- NS(id)
  tagList(
    
  )
}

# Module Server

#' @rdname mod_binder
#' @export
#' @keywords internal
#' @importFrom shiny updateTextInput updateNumericInput updateSelectInput

mod_binder_server <- function(
  input, 
  output, 
  session, 
  img, 
  r, 
  ids
){
  ns <- session$ns

  bind_events(
    ids, 
    img, 
    r, 
    parent_input = input
  )
  
  observeEvent( watch("restore") , {
    updateTextInput(session, "package", value = img$package)
    updateNumericInput(session, "p_x", value = img$px)
    updateNumericInput(session, "p_y", value = img$p_y)
    updateSelectInput(session, "p_family", selected = img$p_family)
    updateNumericInput(session, "p_size", value = img$p_size)
    updateNumericInput(session, "s_x", value = img$s_x)
    updateNumericInput(session, "s_y", value = img$s_y)
    updateNumericInput(session, "s_width", value = img$s_width)
    updateNumericInput(session, "s_height", value = img$s_height)
    updateNumericInput(session, "asp", value = img$asp)
    updateNumericInput(session, "dpi", value = img$dpi)
    updateNumericInput(session, "h_size", value = img$h_size)
    updateCheckboxInput(session, "spotlight", value = img$spotlight)
    updateNumericInput(session, "l_x", value = img$l_x)
    updateNumericInput(session, "l_y", value = img$l_y)
    updateNumericInput(session, "l_width", value = img$l_width)
    updateNumericInput(session, "l_height", value = img$l_height)
    updateNumericInput(session, "l_alpha", value = img$l_alpha)
    updateTextInput(session, "url", value = img$url)
    updateNumericInput(session, "u_x", value = img$u_x)
    updateNumericInput(session, "u_y", value = img$u_y)
    updateSelectInput(session, "u_family", selected = img$u_family)
    updateNumericInput(session, "u_size", value = img$u_x)
    updateNumericInput(session, "u_angle", value = img$u_y)
    
    golem::invoke_js("update_color", list(
      id = "main_ui_1-left_ui_1-pkg_name_ui_1-p_color", 
      color = img$p_color
    ))
    golem::invoke_js("update_color", list(
      id = "main_ui_1-left_ui_1-hexa_ui_1-h_fill", 
      color = img$h_fill
    ))
    golem::invoke_js("update_color", list(
      id = "main_ui_1-left_ui_1-hexa_ui_1-h_color", 
      color = img$h_color
    ))

  }, ignoreInit = TRUE)
  
}


