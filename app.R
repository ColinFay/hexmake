  # Launch the ShinyApp (Do not remove this comment)
# To deploy, run: rsconnect::deployApp()
# Or use the blue button on top of this file
# 
if (packageVersion("magick") != "2.2"){
  remotes::install_github("ropensci/magick")
}

pkgload::load_all()
options( "golem.app.prod" = TRUE)
hexmake::run_app() # add parameters here (if any)
