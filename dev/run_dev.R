options(golem.app.prod = FALSE) # TRUE = production mode, FALSE = development mode
# Set options here

# Detach all loaded packages and clean your environment
golem::detach_all_attached()
# rm(list=ls(all.names = TRUE))

# Document and reload your package
devtools::document()
pkgload::load_all(export_all = FALSE,helpers = FALSE,attach_testthat = FALSE)
# Run the application
run_app(with_mongo = TRUE)
