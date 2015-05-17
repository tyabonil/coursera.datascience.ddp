library(nnet)
library(shiny)

# Define server logic required to draw a histogram
## Read the data for each file
mush.train  <- read.csv("mush.train.csv")
mush.test <- read.csv("mush.test.csv")

mush.train <- rbind(mush.train, mush.test)

## Get rid of column with only one level 
drops <- c("veil.type")
mush.train <- mush.train[, !(names(mush.train) %in%drops)]

mush.frm <- edible ~ odor + spore.print.color
mush.fit <- nnet(as.formula(mush.frm), data=mush.train, method = "nnet", maxit = 100,  trace = F, size=1, decay=0.1) 

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
