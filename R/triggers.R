#' @importFrom shiny reactiveVal getDefaultReactiveDomain
init <- function(name, session = getDefaultReactiveDomain()){
  session$userData[[name]] <- reactiveVal(0)
}

trigger <- function(name, session = getDefaultReactiveDomain()){
  session$userData[[name]](
    session$userData[[name]]() + 1
  )
}

watch <- function(name, session = getDefaultReactiveDomain()){
  session$userData[[name]]()
}