#' @importFrom mongolite mongo gridfs
launch_mongo <- function(
  session = getDefaultReactiveDomain(), 
  collection, 
  db, 
  url, 
  port, 
  user, 
  pass
){
  if (nchar(user) == 0){
    URI  <- sprintf(
      "mongodb://%s:%s", 
      url,
      port
    )
  } else {
    URI  <- sprintf("mongodb://%s:%s@%s:%s", user, pass, url, port)
  }
  
  session$userData$mongo <- mongo(
    collection =  collection, 
    db = db, 
    url = URI
  )
  
  
  session$userData$gridfs <- gridfs(
    db = db, 
    url = URI
  )
  
  session$userData$mongo_stats <- list(
    collection = collection, 
    db = db, 
    url = url, 
    port = port
  )
}

get_mongo <- function(session = getDefaultReactiveDomain()){
  session$userData$mongo
}
get_gridfs <- function(session = getDefaultReactiveDomain()){
  session$userData$gridfs
}
get_mongo_stats <- function(session = getDefaultReactiveDomain()){
  session$userData$mongo_stats
}