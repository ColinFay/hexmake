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
}


