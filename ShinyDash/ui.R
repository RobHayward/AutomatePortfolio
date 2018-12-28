ui <- dashboardPage(
  dashboardHeader(title = "EC381 Investment Dashboard"), 
  # sidebar content
  dashboardSidebar(
    sidebarMenu(
      menuItem("Security Selection", tabName = "security_selection", icon = icon("dashboard")), 
      menuItem("Portfolio", tabName = "portfolio", icon = icon("th")),
      menuItem("Rules", tabName = "rules", icon = icon("500px")),
      menuItem("News", icon = icon("500px"),
      href = 'https://studentcentral.brighton.ac.uk/webapps/blogs-journals/execute/viewBlog?course_id=_111311_1&blog_id=_95576_1&type=blogs&index_id=month'),
      menuItem("Economic Calendar", icon = icon("calendar"), 
               href = 'https://tradingeconomics.com/calendar'))
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
    selectInput("name", "Name", choice = c("Team1", "Team2", "Team3", "Team4"),
                selected = "Team1"),
    selectInput("asset", "Asset", choice = c("Equity", "Debt", "Gold", "Oil"),
                selected = "SPY"),
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
                  selected = 'Team1')
      
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
tabItem(tabName = "rules", 
        h2("Rules for portfolio management"),
        p(tags$strong('Buying and selling assets'),
"All buying and selling of assets will be determined at the Friday closing price."),
               
tags$ul(
  tags$li('You can make an adjustment any time before midnight on Sunday'),
  tags$li("The transaction prie will be Friday's closing price"),
  tags$li("There are no transactin costs or price slippage"),
  tags$li("You must make sure that you do not sell more than the one million dollars that you have been allocated"),
  tags$li("You will receive a fine of 10 percent of you portfolio if your cash balance goes below zero"),
  tags$li("Make your decisions (assets and volume of trade) on the Security Selection tab"),
  tags$li("Once you have made the decision, press select and wait for your transaction to be recorded in the table.  Allow the transaction time to be completed.  There will be some delay if more than one person is selecting at the same time."),
  tags$li('If the transacton is not recorded in the Security Selection table or you make a mistake, email me pn rh49@brighton.ac.uk so that I can correct')
), 
p(tags$strong('Monitoring the portfolio'), 
  "The portfolio perfomance cnd a record of you transacctions an be monitored on the Portfolio tab.  Please selection your name.  It may also be useful for you to keep your own record of performance so that you can create your own calculations and graphs for the report."), 
p(tags$strong('News and Information'), 
  "You can get information from Yahoo Finance, Thomson-Reuters Eikon and the Bloomberg web site.  There are also updates from me on student central that can be accessed from the news tab to the left. You will have to be logged into to student central for this to work,"), 
p(tags$strong("Friday's closing price is recorded in the Security Price tab"), 
  "The portfolio perfomance cnd a record of you transacctions an be monitored on the Portfolio tab.  Please selection your name.  It may also be useful for you to keep your own record of performance so that you can create your own calculations and graphs for the report.")
#:tags$img(src = '10Y.png', align = 'left', width = "500px", height = "200px")
)
)
)
)
