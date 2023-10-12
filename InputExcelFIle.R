source("global.R")

# requires library(c(readxl,tidyr,dplyr)) pulled from global.R

InputFileButton <- function() {
  fluidPage(
    titlePanel("Use readxl"),
    sidebarLayout(
      sidebarPanel(
        fileInput("file1", "Choose .xlsx File",
                  accept = c(".xlsx"))
      ),
      mainPanel()
    )
  )
}

PrintTableFunc <- function() {
  fluidPage(
    mainPanel(
      tableOutput("contents")
    )
  )
}

TableOfInputtedFile <- function(input, output, session) {
  output$contents <- renderTable({
    inFile <- input$file1
    if (is.null(inFile))
      return(NULL)
    file.rename(inFile$datapath,
                paste(inFile$datapath, ".xlsx", sep=""))
    read_excel(paste(inFile$datapath, ".xlsx", sep=""), 1) %>% drop_na(Month) %>% 
      mutate_at("Month", as.integer) %>% mutate_at("Date", as.character)
  })
}