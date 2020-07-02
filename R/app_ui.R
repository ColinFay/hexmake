#' @importFrom  shiny fluidPage
app_ui <- function() {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here 
    fluidPage(
      htmlTemplate(app_sys("app/spinner.html")),
      mod_main_ui("main_ui_1"), 
      tagList(
        tags$p(
          class="footer",
          paste("Hexmake, version", packageVersion("hexmake"))
        )
      )
    )
  )
}

#' @importFrom  shiny fluidPage tags
#' @importFrom golem add_resource_path favicon bundle_resources
#' @importFrom cicerone use_cicerone
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
  
  tags$head(
    favicon(),
    waiter::use_waiter(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'hexmake'
    ), 
    use_cicerone()
  )
}
