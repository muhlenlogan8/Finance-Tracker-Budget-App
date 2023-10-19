source("global.R")

# Code I found online, doesn't work as intended, difficult to store the template file
# may need to just store it elsewhere and send the user there to download it to maintain format
# and such
DownloadTemplateButton <- function() {
  fluidPage(
    fileInput(inputId = "file", label = "Read File Here", accept = c(".xlsx")),
    useShinyjs(),
    actionButton("showtxt", "Show/Download File")
  )
}

GetFilePath2 <- function(input, output, session) {
  observeEvent(input$showtxt, {
               tf <- tempdir()
               infile <- input$file
               wb2 <- openxlsx::loadWorkbook(file = infile$datapath)
               df_1 <- data.frame("DF" = c(1:3))
               addWorksheet(wb2, "Parameters1", df_1, startCol = 1, startRow = 2, rowNames = TRUE)
               saveWorkbook(wb2, "File.xlsx")
  })
  onclick("showtxt", runjs("window.open('test.xlsx')"))
}

