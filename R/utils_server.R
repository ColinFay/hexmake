bind_events <- function(
  ids, 
  img, 
  r, 
  parent_input
){
  lapply(
    ids, function(x){
      observeEvent( parent_input[[x]] , {
        img[[x]] <- parent_input[[x]]
        if (r$live) trigger("render")
      })
    }
  )
}

