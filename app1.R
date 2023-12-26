library(shiny)
library(odbc)
library(klink)
hive_con <- klink::klink_hadoop("DEV", "KNA_BW")

ui <- fluidPage(
  titlePanel("hive data viewer"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("rowLimit",
                  "Number of rows to display:",
                  min = 1,
                  max = 100,
                  value = 10)
      
  ),
  mainPanel(
    tableOutput("hiveData")
  )
)
)

server <- function(input, output){
  
  hive_data <- reactive({
    query <-paste("SELECT * FROM kna_bw.tbl_comp_sales LIMIT", input$rowLimit)
    dbGetQuery(hive_con, query)
  })
  output$hiveData <- renderTable({
    hive_data()
  })
}
shinyApp(ui, server)