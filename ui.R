library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Is that mushroom poisinous?"),
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      h2('Tell us a little about the mushroom:'),
      fluidRow(
        column(12,
               selectInput("odor", label = h3("Odor"), 
                           choices = list("Almond" = "a", "Anise" = "l","Creosote" = "c","foul"="f", "musty"="m","none"="n","pungent"="p"),
                           selected = 1))
      ),
      fluidRow(
        column(12,
               selectInput("spore.print.color", label = h3("Spore Print Color"), 
                           choices = list("black"="k","brown"="n","chocolate"="h","green"="r", "purple"="u","white"="w" ),
                           selected = 1))
      )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      p('This app uses the nnet package to create an artificial neural network trained using the UCI Machine Learning Repoository\'s Mushroom Data Set to predict whether a mushroom is poisinous or edible.'),
      h3(textOutput("fit")),
      p(a("UCI Machine Learning Repository", "https://archive.ics.uci.edu/ml/datasets/Mushroom")),
      p(a("NNET Package", "hhttp://cran.r-project.org/web/packages/nnet/nnet.pdf"))
      

    )
  )
))