#InputID already used: symb, dates, get, adjust, plot, plot_select, BB_win, sd, addBB
#addVo, BB_Signal, addMACD, processed, modi_macd, macd_fast, macd_slow, macd_signal
#stop_profit
#stop_trig

library(shiny)
library(ggplot2)

shinyUI(fluidPage(
  title = "Strategy Back Test",
  plotOutput('plot'),

  hr(),
  
  fluidRow(
    column(4,
           h4("Dataset"),
           helpText("Specify the symbol, date range and the basic plot style."),
           br(),
           textInput("symb", "Symbol", "SPY"),
           dateRangeInput("dates", 
                          label=h5("Date range"),
                          start = "2013-01-01",
                          #end   = "2012-12-24"),
                          end =   as.character(Sys.Date())),
           checkboxInput("addVo", "Plot Volume", 
                         value = FALSE),
           selectInput("plot_select", label = h5("Plot Style"), 
                       choices = list("Lin" = 1, "Candlestick" = 2), selected = 1),
           br(),
           submitButton('Submit')
    ),
    column(4, 
           h4("Technical Indicator"),
           helpText("Visualize Bollinger bands and the orders generated by it. The order are generated
                    based on the assumption that the price bouncing back when it touches the edge of the
                    Bollinger band."),
           checkboxInput("addBB", "Add Bollinger Bands", value = FALSE),
           sliderInput("BB_win", label=h6("Bollinger's Window Size:"), min = 14, max = 60,
                       , value = 20, step=1),
           sliderInput("sd", label=h6("Multiple of Standard Deviation:"), min = 1.0, max = 3.2,
                       , value = 2.0, step=0.1),
           br(),
           checkboxInput("processed", "Generate order", value = FALSE),
           checkboxInput("stop_profit", "Stop profit?", value = TRUE),
           numericInput("stop_day", label=h6("Max Days of Holding:"), value=1000, min =1, step = 1),
           sliderInput("stop_trig", label=h6("Stop Sell Trigger:"), min = 0, max = 0.15, value = 0.0, step=0.001)
    ),
    column(4,
           h4('Modifying with MACD'),
           helpText('Our assumption of bouncing price may be invalid when trend is strong. MACD helps to 
                    identify such trend and to adjust strategy accordingly. Tuning the parameter below 
                    to catch trends with different period.'),
           checkboxInput("addMACD", "Plot MACD", value = FALSE),
           sliderInput("macd_fast", label=h6("Fast Indicator:"), min = 7, max = 60,
                       , value = 12, step=1),
           sliderInput("macd_slow", label=h6("Slow Indicator:"), min = 20, max = 150,
                       , value = 26, step=1),
           sliderInput("macd_signal", label=h6("Signal:"), min = 5, max = 60,
                       , value = 9, step=1),  
           checkboxInput("modi_macd", "Modify the order by MACD (Stop sell trigger in the left column is necessary when modifying with MACD).", value = FALSE)
    )
  ),
  hr(),
  h6('DISCLAIMER: The statement and analysis in this website is provided as general information and for
     illustrative purpose only. This app does not intend to provide invesment advice. The author may hold positions in stocks, currencies and 
     industries discussed here. You understand and acknowledge that there is a very high 
     degree of risk involved in trading securities and/or currencies. The author assumes no 
     responsibility or liability for your trading and investment results.')
))