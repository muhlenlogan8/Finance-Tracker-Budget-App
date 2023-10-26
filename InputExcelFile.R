source("global.R")

# requires library(c(readxl,tidyr,dplyr,formattable)) pulled from global.R

# input file button module
InputFileModule <- function() {
  fluidPage(
    titlePanel("Input .xlsx File"),
    sidebarLayout(
      sidebarPanel(
        fileInput("file1", "Choose .xlsx File",
                  accept = c(".xlsx"))
      ),
      mainPanel()
    )
  )
}

# print table using formattable package module
PrintTable <- function() {
  fluidPage(
    mainPanel(
      formattableOutput("contents")
    )
  )
}

# get file path of input file to utilize in other functions
GetFilePath <- function(input, output, session) {
  inFile <- input$file1
  if (is.null(inFile))
    return(NULL)
  file.rename(inFile$datapath,
              paste(inFile$datapath, ".xlsx", sep=""))
  return(inFile$datapath)
}

# create table using the file path from GetFilePath function with initial filtering of table
CreateTable <- function(input, output, session) {
  filedatapath <- GetFilePath(input, output, session)
  tbl <- read_excel(paste(filedatapath, ".xlsx", sep=""), 1) %>% drop_na(Month) %>%
    mutate_at("Month", as.integer) %>% mutate_at("Date", as.character) %>%
    mutate_all(~replace(., is.na(.), values = ""))
  return(tbl)
}

# use formattable package to modify table for future use
ModifyTable <- function(tbl, input, output, session) {
  output$contents <- renderFormattable({
    tbl %>% formattable(., list(
      Income = formatter(.tag = "span", style = x ~ ifelse(
        !is.na(x),
        style(color = "green"), NA)), # format Income column to be green
      Debits = formatter(.tag = "span", style = x ~ ifelse(
        !is.na(x),
        style(color = "red"), NA))) # format Debits column to be red
    )
  })
}
