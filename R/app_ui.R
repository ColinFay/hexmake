#' @import shiny
app_ui <- function() {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here 
    fluidPage(
      mod_main_ui("main_ui_1")
    )
  )
}

#' @import shiny
golem_add_external_resources <- function(){
  
  addResourcePath(
    'www', system.file('app/www', package = 'hexmake')
  )
 
  tags$head(
    golem::activate_js(),
    golem::favicon(),
    tags$title("hexmake"),
    tags$link(rel="stylesheet", type="text/css", href="www/custom.css")
  )
}
