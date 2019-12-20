  # Launch the ShinyApp (Do not remove this comment)
# To deploy, run: rsconnect::deployApp()
# Or use the blue button on top of this file
# 
pkgload::load_all()
options( "golem.app.prod" = TRUE)
hexmake::run_app() # add parameters here (if any)
