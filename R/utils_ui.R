modalinner <- function(
  summary, 
  checkbox_id,
  parent_ns,
  ...
) {
  fluidRow(
    tags$details(
      tags$summary(summary),
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