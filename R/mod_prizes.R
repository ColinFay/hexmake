#' prizes UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_prizes_ui <- function(id){
  ns <- NS(id)
  tagList(
    tags$details(
      summary("2020 RStudio Shiny Contest"), 
      tags$div(
        class = "innerrounded rounded",
        align = "center",
        fluidRow(
          col_12(
            h4("{hexmake} won the 2020 RStudio Shiny Contest"), 
            tags$a(href = "https://blog.rstudio.com/2020/07/13/winners-of-the-2nd-shiny-contest/", "Read more", target = "_blank")
          )
        )
      )
    )
    
  )
}
    
#' prizes Server Function
#'
#' @noRd 
mod_prizes_server <- function(input, output, session){
  ns <- session$ns
 
}
    
## To be copied in the UI
# 
    
## To be copied in the server
# callModule(mod_prizes_server, "prizes_ui_1")
 
