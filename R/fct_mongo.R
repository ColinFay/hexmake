#' @importFrom mongolite mongo gridfs
launch_mongo <- function(
  session = getDefaultReactiveDomain(), 
  collection, 
  db, 
  url, 
  port
){
  session$userData$mongo <- mongo(
    collection =  collection, 
    db = db, 
    url = sprintf(
      "mongodb://%s:%s", 
      url,
      port
    )
  )
  
  session$userData$gridfs <- gridfs(
    db = db, 
    url = sprintf(
      "mongodb://%s:%s", 
      url,
      port
    )
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