options(golem.app.prod = FALSE) # TRUE = production mode, FALSE = development mode
# Set options here

# Detach all loaded packages and clean your environment
golem::detach_all_attached()
# rm(list=ls(all.names = TRUE))

# Document and reload your package
golem::document_and_reload()

# Run the application
hexmake::run_app()
