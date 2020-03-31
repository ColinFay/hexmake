#' @importFrom shiny fluidRow tags checkboxInput
modalinner <- function(
  summary, 
  checkbox_id,
  parent_ns,
  ...
) {
  fluidRow(
    tags$details(
      summary(summary),
      tags$div(
        class = "modalinner innerrounded rounded",
        col_12(
          checkboxInput(
            parent_ns(checkbox_id), 
            summary
          )
        ), 
        ...
      )
    )
  )
}

#' @importFrom shiny tags
#' @importFrom tools toTitleCase
h1 <- function(x){
  tags$h1(
    toTitleCase(x)
  )
}
#' @importFrom shiny tags
#' @importFrom tools toTitleCase
h2 <- function(x){
  tags$h2(
    toTitleCase(x)
  )
}
#' @importFrom shiny tags
#' @importFrom tools toTitleCase
h3 <- function(x){
  tags$h3(
    toTitleCase(x)
  )
}
#' @importFrom shiny tags
#' @importFrom tools toTitleCase
h4 <- function(x){
  tags$h4(
    toTitleCase(x)
  )
}
#' @importFrom shiny tags
#' @importFrom tools toTitleCase
h5 <- function(x){
  tags$h5(
    toTitleCase(x)
  )
}
#' @importFrom shiny tags
#' @importFrom tools toTitleCase
h6 <- function(x){
  tags$h6(
    toTitleCase(x)
  )
}
#' @importFrom shiny tags
#' @importFrom tools toTitleCase
summary <- function(x){
  tags$summary(
    toTitleCase(x)
  )
}
