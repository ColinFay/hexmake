#' @importFrom shiny callModule
app_server <- function(input, output,session) {
  
  whereami::cat_where(whereami::whereami())
  
  mongo_port <- Sys.getenv("MONGOPORT", 27017)
  mongo_url <- Sys.getenv("MONGOURL", "127.0.0.1")
  mongo_db <- Sys.getenv("MONGODB", "hex")
  mongo_collection <- Sys.getenv("MONGOCOLLECTION", "make")
  mongo_user <- Sys.getenv("MONGOUSER", "")
  mongo_password <- Sys.getenv("MONGOPASS", "")
  
  if ( golem::get_golem_options("with_mongo") ){
    launch_mongo(
      collection = mongo_collection, 
      db = mongo_db, 
      url = mongo_url, 
      port = mongo_port, 
      user = mongo_user, 
      pass = mongo_password
    )    
  }
  
  # List the first level callModules here
  callModule(mod_main_server, "main_ui_1")
}
