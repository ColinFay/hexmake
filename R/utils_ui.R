bundle_resources <- function(
  path, 
  app_title,
  name = "golem_resources", 
  version = "0.0.1", 
  meta = NULL, 
  head = NULL,
  attachment = NULL,
  package = NULL,
  all_files = TRUE
){

  css <- list.files(path, pattern = "\\.css$")
  js <- list.files(path, pattern = "\\.js$")
  head <- c(
    as.character(
      tags$title(app_title)
    ), 
    as.character(
      golem::activate_js()
    ),
    head
  )
  htmltools::htmlDependency(
    name, 
    version,
    src = path,
    script = js,
    stylesheet = css,
    meta = meta, 
    head = head,
    attachment = attachment,
    package = package,
    all_files = all_files
  )
}