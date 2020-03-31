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
#' @importFrom golem add_resource_path favicon bundle_resources
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'hexmake'
    ), 
    cicerone::use_cicerone()
  )
}
