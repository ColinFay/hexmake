#' @import shiny
app_server <- function(input, output,session) {
  # List the first level callModules here
  callModule(mod_main_server, "main_ui_1")
}
