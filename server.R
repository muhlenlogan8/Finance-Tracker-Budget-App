source("global.R")
source("InputExcelFile.R")


options(shiny.maxRequestSize = 30*1024^2)

server <- function(input, output, session) {
  output$mychoice <- renderText(
    input$select
  )
  CreateTable(input, output, session)
}