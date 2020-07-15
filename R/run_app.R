#' Run the Shiny Application
#'
#' @param with_mongo Do you want to use mongo as a backend?
#' @export
#' @importFrom shiny shinyApp
#' @importFrom golem with_golem_options
run_app <- function(
  with_mongo = TRUE
) {
  with_golem_options(
    app = shinyApp(ui = app_ui, server = app_server), 
    golem_opts = list(
      with_mongo = with_mongo
    )
  )
}
