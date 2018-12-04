# New development https://rstudio.github.io/DT/shiny.html
library(shiny)
library(DT)
shinyApp(
  ui = fluidPage(DTOutput('tbl')), 
  server = function(input, output) {
      output$tbl = renderDT(
      iris, options = list(lengthChange = FALSE)
    )
  }
)
