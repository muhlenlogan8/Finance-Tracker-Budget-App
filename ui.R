source("InputExcelFile.R")


ui <- shinyUI({
  fluidPage(
    tabsetPanel(
      tabPanel("Input File Tab",
               InputFileModule()
      ),
      
      tabPanel("Data Table Tab",
               PrintTable()
      )
    )
  )
})