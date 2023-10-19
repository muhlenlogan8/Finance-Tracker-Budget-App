source("InputExcelFile.R")
source("TemplateFileFeatures.R")

ui <- shinyUI({
  dashboardPage(
    dashboardHeader(title = "Financial Visualizer App"),
    dashboardSidebar(
      sidebarMenu(
        menuItem("Input Data Here", tabName = "inputdata"),
        menuItem("Get Template File Here", tabName = "gettemplate"),
        menuItem("Dashboard", tabName = "dashboard"),
        menuItem("Raw Data Table", tabName = "rawdatatable")
      )
    ),
    dashboardBody(
      tabItems(
        tabItem("inputdata",
                InputFileModule()
        ),
        tabItem("gettemplate",
                DownloadTemplateButton()
        ),
        tabItem("dashboard",
                fluidRow(
                  valueBoxOutput("currentbalance"),
                  valueBoxOutput("incometodate"),
                  valueBoxOutput("debitstodate")
                )
        ),
        tabItem("rawdatatable",
                PrintTable()
                # numericInput("maxrows", "Rows to show", 25),
                # verbatimTextOutput("rawtable"),
                # downloadButton("downloadcsv", "Download as CSV")
        )
      )
    )
  )
})
