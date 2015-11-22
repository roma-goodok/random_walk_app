library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("Random Walk Simulation"),  
  sidebarPanel(
    h2("Introduction"),
    p("dsfdsfsdfa dfasdf asdf asdf asdf asdf asdf asdf a dsfdsfsdfa dfasdf asdf asdf asdf asdf asdf asdf a dsfdsfsdfa dfasdf asdf asdf asdf asdf asdf asdf a"),
    p("dsfdsfsdfa dfasdf asdf asdf asdf asdf asdf asdf a dsfdsfsdfa dfasdf asdf asdf asdf asdf asdf asdf a dsfdsfsdfa dfasdf asdf asdf asdf asdf asdf asdf a"),
    h2("How to use"),    
    p("dsfdsfsdfa dfasdf asdf asdf asdf asdf asdf asdf a dsfdsfsdfa dfasdf asdf asdf asdf asdf asdf asdf a dsfdsfsdfa dfasdf asdf asdf asdf asdf asdf asdf a"),
    p("dsfdsfsdfa dfasdf asdf asdf asdf asdf asdf asdf a dsfdsfsdfa dfasdf asdf asdf asdf asdf asdf asdf a dsfdsfsdfa dfasdf asdf asdf asdf asdf asdf asdf a"),
    sliderInput('trainPeriod', 'train period',value = 700, min = 500, max = 1000, step = 2),
    sliderInput('mu', 'estimation of random walk "step"',value = 0.0, min = -0.1, max = 0.1, step = 0.01),    
    submitButton('Submit', icon = icon("refresh")),
    width=10
  ),
  mainPanel(
    p("tra-ta-ta 2. It will take some time"),
    h2("Result of simulation"),
    p("tra-ta-ta 2. It will take some time"),
    plotOutput('newSeries'),
    width = 10
  )
))


