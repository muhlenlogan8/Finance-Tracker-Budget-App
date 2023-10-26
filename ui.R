source("InputExcelFile.R") 
source("TemplateFileFeatures.R")

ui <- shinyUI({
  dashboardPage(
    # dashboard header
    dashboardHeader(title = "Financial Visualizer App"),
    dashboardSidebar(
      # menu items
      sidebarMenu(
        menuItem("Input Data Here", tabName = "inputdata"),
        menuItem("Get Template File Here", tabName = "gettemplate"),
        menuItem("Dashboard", tabName = "dashboard"),
        menuItem("Raw Data Table", tabName = "rawdatatable")
      )
    ),
    dashboardBody(
      tabItems(
        # input data tab
        tabItem("inputdata",
                InputFileModule() # input file button module
        ),
        # get template tab
        tabItem("gettemplate",
                DownloadTemplateButton() # download template button module
        ),
        # dashboard tab
        tabItem("dashboard",
                fluidRow(
                  valueBoxOutput("currentbalance"), # current balance value box
                  valueBoxOutput("incometodate"),   # income to date value box
                  valueBoxOutput("debitstodate")    # debits to date value box
                )
        ),
        # raw data table tab
        tabItem("rawdatatable",
                PrintTable() # print raw data table module
        )
      )
    )
  )
})
