# Module UI

#' @title   mod_right_ui and mod_right_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_right
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList tags imageOutput tagAppendAttributes
mod_right_ui <- function(id){
  ns <- NS(id)
  tagList(
    tags$div(
      imageOutput(ns("img")) %>%
        tagAppendAttributes(
          class = "imgleft"
        )
    )
  )
}

# Module Server

#' @rdname mod_right
#' @export
#' @keywords internal
#' @importFrom shiny renderImage
#' @importFrom whereami cat_where whereami
mod_right_server <- function(input, output, session, img){
  ns <- session$ns
  
  output$img <- renderImage({
    cat_where(whereami())
    watch("render")
    list(src = img$render())
  })

}


