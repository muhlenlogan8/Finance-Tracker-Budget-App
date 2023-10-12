source("global.R")

# requires library(c(readxl,tidyr,dplyr,formattable)) pulled from global.R

InputFileModule <- function() {
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

PrintTable <- function() {
  fluidPage(
    mainPanel(
      formattableOutput("contents")
    )
  )
}

CreateTable <- function(input, output, session) {
  output$contents <- renderFormattable({
    inFile <- input$file1
    if (is.null(inFile))
      return(NULL)
    file.rename(inFile$datapath,
                paste(inFile$datapath, ".xlsx", sep=""))
    read_excel(paste(inFile$datapath, ".xlsx", sep=""), 1) %>% drop_na(Month) %>% 
      mutate_at("Month", as.integer) %>% mutate_at("Date", as.character) %>% 
      mutate_all(~replace(., is.na(.), values = "")) %>% 
      formattable(., list (
        Income = formatter(.tag = "span", style = x ~ ifelse(
          !is.na(x),
          style(color = "green"), NA)),
        Debits = formatter(.tag = "span", style = x ~ ifelse(
          !is.na(x),
          style(color = "red"), NA)))
      )
  })
}