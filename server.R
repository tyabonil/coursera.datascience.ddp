library(shiny)
## read the model
mush.fit  <- readRDS("mush.fit.rds")
shinyServer(function(input, output) {

  df <- data.frame(odor=NA, spore.print.color=NA)

  output$fit <- renderText({
    paste("The mushroom is ", 
          switch(predict(mush.fit,
                         newdata=data.frame(odor=input$odor, spore.print.color=input$spore.print.color),
                         type="class"), 
          'e' = 'edible!',
          'p' = 'poisinous!',
          'cannot determine'))
    })

  
})
