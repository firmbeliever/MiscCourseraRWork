library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Cars stopping distance based on speed"),
  p("This app looks at data in the R 'cars' dataset, which has 50 observations of the speed of a car
     (in MPH) and its stopping distance (in feet).  The dataset has been plotted, and a linear
     model is shown by the blue line.  You can use the slider below to pick a speed, and the app 
     will predict the stopping distance.  This prediction will be listed below the slider, and it
     will also be plotted by a red dot on the blue line in the graph."),
  
  sidebarLayout(
    sidebarPanel(
       sliderInput("sldSpeed", "Speed of the car", 5, 40, value = 10),
       p("The predicted stopping distance is:"),
       textOutput("pred")
    ),
    
    mainPanel(
       plotOutput("plot1")
    )
  )
))
