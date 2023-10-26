source("global.R")
source("InputExcelFile.R")
source("TemplateFileFeatures.R")

# increases the max file size to 30 MB so larger .xlsx files can be uploaded
options(shiny.maxRequestSize = 30*1024^2)

server <- function(input, output, session) {
  output$mychoice <- renderText(input$select)
  
  # when input file button is observed
  observeEvent(
    input$file1, {
      
      # create table from input file
      tbl <- CreateTable(input, output, session)
      
      # withProgress function to create progress bar
      withProgress(message = "Making Visuals", value = 0, {
        n <- 4 # number of steps in progress bar
        
        # increase progress bar by 1/n (n = 4) and have system sleep to allow for progress bar to update cleanly
        # Note: system sleep is not needed, just allows for progress bar to update in a more visually appealing way
        incProgress(1/n, detail = "Creating Table")
        Sys.sleep(0.5)
        
        # "modify" table for future use
        ModifyTable(tbl, input, output, session)
        
        
        # create current balance value box
        output$currentbalance <- renderValueBox({
          
          # pull current balance from Balance column and last row of table and format as $...
          currentbal <- tbl %>% select(., "Balance") %>% last() %>% 
            as.character(.) %>% paste0("$", .)
          
          valueBox(
            value = currentbal,
            subtitle = "Current Balance",
            icon = icon("dollar-sign"), # icon for value box
            color = "blue" # color of value box
          )
        })
        # increase progress bar by 1/n
        incProgress(1/n, detail = "Calculating Current Balance")
        Sys.sleep(0.5)
        
        # create income to date value box
        output$incometodate <- renderValueBox({
          
          # pull income from Income column, filter out NA values, sum all income values and format as $...
          incometodate <- tbl %>% mutate_at("Income", as.double) %>% 
            filter(., Category == "Income") %>% select(., "Income") %>%
            drop_na() %>% sum() %>% as.character(.) %>% paste0("$", .)
          
          valueBox(
            value = incometodate,
            subtitle = "Income To Date",
            icon = icon("money-bill"), # icon for value box
            color = "green" # color of value box
          )
        })
        # increase progress bar by 1/n
        incProgress(1/n, detail = "Calculating Total Income")
        Sys.sleep(0.5)
        
        # create debits to date value box
        output$debitstodate <- renderValueBox({
          
          # pull debits from Debits column, filter out NA values, sum all debit values and format as $...
          debitstodate <- tbl %>% mutate_at("Debits", as.double) %>% 
            filter(., Category != "Income") %>% select(., "Debits") %>%
            drop_na() %>% sum() %>% as.character(.) %>% paste0("$", .)
          
          valueBox(
            value = debitstodate,
            subtitle = "Debits To Date",
            icon = icon("credit-card"), # icon for value box
            color = "red" # color of value box
          )
        })
        # increase progress bar by 1/n
        incProgress(1/n, detail = "Calculating Total Debits")
        Sys.sleep(0.5)
      })
    })
  
  GetFilePath2(input, output, session)
}
