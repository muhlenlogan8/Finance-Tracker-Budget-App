source("InputExcelFile.R")


ui <- shinyUI({
  fluidPage(
    tabsetPanel(
      tabPanel("Input File Tab",
               InputFileButton()
      ),
      
      tabPanel("Data Table Tab",
               PrintTableFunc()
      )
    )
  )
})