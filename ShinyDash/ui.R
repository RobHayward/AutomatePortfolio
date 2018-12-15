ui <- dashboardPage(
  dashboardHeader(title = "EC381 Investment Dashboard"), 
  # sidebar content
  dashboardSidebar(
    sidebarMenu(
      menuItem("Security Selection", tabName = "security_selection", icon = icon("dashboard")), 
      menuItem("Portfolio", tabName = "portfolio", icon = icon("th")),
      menuItem("News", tabName = "news", icon = icon("500px")),
      menuItem("Economic Calendar", icon = icon("calendar"), 
               href = 'https://tradingeconomics.com/calendar')
    )
  ),
  
  dashboardBody(
    tabItems(
      # first tab content
      tabItem(tabName = "security_selection", 
              
    
  # boxes need to be put in rows or columns
  fluidRow(
    
    box(
      title = "Select security",
      width = 4, 
      textInput("name", "Name", ""),
    selectInput("asset", "Asset", choice = c("SPY", "TLT"), selected = "SPY"),
    selectInput("action", "Action", choice = c("Buy", "Sell"), selected = "Buy"),
    numericInput("quantity", "Assets to buy or sell", value = 100, min = 0, max = 10e6),
    actionButton("submit", "Submit")
    ),
  
   box(  
   DT::dataTableOutput("responses", width = 550)   
)
  ) 
),
# second tab content
tabItem(tabName = "portfolio", 
        h2("Portfolio"), 
fluidRow(
    column(3, 
    
    wellPanel(
        selectInput(inputId = "student", label = "Choose a student id:", 
                  choices = students,
                  selected = 'nad20')
      
)),
    
    # Show a summary of the dataset and an HTML table with the 
    # requested number of observations
    #column(9, 
      p("This is a list of transactions that have been carried out by 
        the selected student.  If nothing is shown, it means that no transactions 
        have yet been completed."), 
      
      tableOutput(outputId = "view1"), 
      
      p("This is the portfolio and its valuation for the
      selected student."),
      
      tableOutput(outputId = "view2"),    
      
      
     

plotOutput(outputId = "plot"),

       
      textOutput(outputId = "text1"),
      textOutput(outputId = "text2"), 
p("The annualisation will assume that the gains for the quarter happen 4 times"),

p("The base portfolio is based on a 60:40 equity to bond weighting.") 
)) ,


# third tab content
tabItem(tabName = "news", 
        h2("News information and suggestions"),
        p(tags$strong('Main Point'),
"The softening of trade friction at the weekend meeting in Argentian has
          provided the backdrop to a more stable tone in world equity markets"),
               
tags$ul(
  tags$li('The first thing this week'),
  tags$li('The second thnig this week')
), 
p(tags$strong('Second point'), 
  "The latest economic data will include the US Employment data for November.  As usual
  the attention will be on wages for evidence that tight labour market conditions are 
  translating into increased costs for firms."), 
tags$img(src = '10Y.png', align = 'left', width = "500px", height = "200px")
)
)
)
)