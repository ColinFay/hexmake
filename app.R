# Launch the ShinyApp (Do not remove this comment)
# To deploy, run: rsconnect::deployApp()
# Or use the blue button on top of this file
#
library(golem)
pkgload::load_all()
options("golem.app.prod" = TRUE)
run_app(with_mongo = TRUE) # add parameters here (if any)
