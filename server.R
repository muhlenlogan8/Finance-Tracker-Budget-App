source("global.R")
source("InputExcelFile.R")


options(shiny.maxRequestSize = 30*1024^2)

# server <- function(input, output, session) {
#   output$mychoice <- renderText(
#     input$select
#   )
#   CreateTable(input, output, session)
# }

server <- function(input, output, session) {
  output$mychoice <- renderText(input$select)
  observeEvent(
    input$file1, {
      tbl <- CreateTable(input, output, session)
      
      withProgress(message = "Making Visuals", value = 0, {
        n <- 4
        incProgress(1/n, detail = "Creating Table")
        Sys.sleep(0.5)
        ModifyTable(tbl, input, output, session)
        
        output$currentbalance <- renderValueBox({
          currentbal <- tbl %>% select(., "Balance") %>% last()
          valueBox(
            value = currentbal,
            subtitle = "Current Balance",
            icon = icon("dollar-sign"),
            color = "blue"
          )
        })
        incProgress(1/n, detail = "Calculating 1/3")
        Sys.sleep(0.5)
        
        output$incometodate <- renderValueBox({
          incometodate <- tbl %>% mutate_at("Income", as.double) %>% 
            filter(., Category == "Income") %>% select(., "Income") %>% sum()
          valueBox(
            value = incometodate,
            subtitle = "Income To Date",
            icon = icon("money-bill"),
            color = "green"
          )
        })
        incProgress(1/n, detail = "Calculating 2/3")
        Sys.sleep(0.5)
        
        output$debitstodate <- renderValueBox({
          debitstodate <- tbl %>% mutate_at("Debits", as.double) %>% 
            filter(., Category != "Income") %>% select(., "Debits") %>% sum()
          valueBox(
            value = debitstodate,
            subtitle = "Debits To Date",
            icon = icon("credit-card"),
            color = "red"
          )
        })
        incProgress(1/n, detail = "Calculating 3/3")
        Sys.sleep(0.5)
      })
    })
}