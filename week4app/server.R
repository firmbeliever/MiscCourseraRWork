library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    model <- lm(dist ~ speed, data = cars)
    
    pred <- reactive({
        inputSpeed <- input$sldSpeed
        predict(model, newdata = data.frame(speed = inputSpeed))
    })
    
    output$plot1 <- renderPlot({
        plot(cars$speed, cars$dist, xlab = "Speed (MPH)", ylab = "Stopping Distance (FT)",
         xlim = c(0,40), ylim = c(0,150))
        abline(model, col = "blue", lwd = 1)
        points(input$sldSpeed, pred(), col = "red", pch = 19)
    })
    
    output$pred <- renderText({
        pred()
    })
  
})
