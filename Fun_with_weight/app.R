library(shiny)
library(tidyverse)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Does gender influence weight more than aerobic excercise after controlling for Height?"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         selectInput("Choice",
                     "Choose a factor to display the difference in Weight distribution",
                     choices = c("None", "Gender", "Aerobic Excercise"),
                     selected = "None"
                     ),
         actionButton("goButton", "Show lm() call on residuals"),
         verbatimTextOutput("ex_text")
         ),
      # Show a plot of the generated distribution
      mainPanel(tabsetPanel(type = "tabs",
                            tabPanel("Plot", 
                                     plotOutput("distPlot"),
                                     verbatimTextOutput("summary_text")),
                            tabPanel("Documentation", 
                                     h3("Introduction and Data source"),
                                     h5("This Shiny App had been made as part of the Data Products course on Coursera offered by the Bloomberg School of Public Health at Johns Hopkins University."),
                                     h5("The data source is the BRFSS Dataset maintained by the Center for Disease Control (CDC)."),
                                     h5("Further information can be found in the Links and References Tab."),
                                     h3("What does this applet do?"),
                                     h5("The purpose of this applet is to demonstrate the deceptive covariability of Gender and Height on Weight. This objective is achieved in three ways."),
                                      h5("Firstly, the app plots a distribution of Weight from the BRFSS dataset, by default, to give the user an idea of the shape of this data."),
                                     h5("Secondly, the app invites the user to select a factor variable (Gender or Aerobic) with which, the user can change the plot output and observe the change in distribution of Weight when the variable Gender or Aerobic Excercise is taken into account. Note Aerobic Excercise is a factor variable created for the purposes of this applet and indicates if according to the BRFSS researchers, the user met the Aerobic excercise requirements or not."),
                                     h5("Finally, the user is invited to see the - lm() call - on the residuals of the model lm(Weight ~ Height)."),
                                     h5("To expand further:"),
                                     verbatimTextOutput("model"),
                                     h5("Note R-squared value i.e. the variability in Height accounts for ~ 25% of the variability observed in Weight. The residuals of this model contain the variability in Weight not accounted for by the variability in Height. Hence performing a regression on the residuals with Gender or Aerobic Excericse allows us to ascertain the contributory variation of those factors on Weight since we have now controlled for Height"),
                                     h5("The counter-intuitve R-squared values juxtaposed against the difference in distribution of Weight when seen through the lens of Gender or Aerobic Excercise is informative of the covariance between Gender and Height, but not of Gender and Aerobic Excercise."),
                                     h3("Conclusion"),
                                     h5("There are Weight differences between human males and females, but that difference is due to average differences in height plus other factors not explored here. Gender, per se, has very little influence. Interestingly, according the the BRFSS data analysed by this methodology, meeting Aerobic excercise targets has little influece on the variability of Weight observed in this data.")),
                            tabPanel("Links and References",
                                     h3("Links"),
                                     a("Data Products Coursera Link", href="https://www.coursera.org/learn/data-products/home/welcome"),
                                     hr(),
                                     a("CDC's Website to the BRFSS Dataset", href="https://www.cdc.gov/brfss/annual_data/annual_2017.html"),
                                     h5("Note the 2017 dataset was used for this analysis. The dataset is rather large and available to download in ASCII and *.XPT format. The *.XPT format was downloaded locally, select variables manipulated, and then stored in R's *.rds format."),
                                     hr(),
                                     h5("Github repo for this project", href="")
                                     )
                )
   )
)
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  model_lm <- lm(formula = log(mini_data_set$Weight) ~ log(mini_data_set$Height))
  mini_data_set <- readRDS("mini_brfss.rds")
  output$model <- renderPrint(summary(model_lm))
   output$distPlot <- renderPlot({
     if (input$Choice == "Gender") {
       y <<- mini_data_set$Gender
       lab <<- "Gender"
       subtitle <- "Recall Gender implies difference in average height too!"
     } else if (input$Choice == "Aerobic Excercise") {
       y <<- mini_data_set$Aer_Ex
       lab <<- "Met Aerobic Excercise Targets"
       subtitle <- "Does aerobic activity depend on height?"
     } else {
       y <<- ""
       lab <<- "Weight distribution"
       subtitle <- ""
     }
      mini_data_set %>% ggplot(aes(x = Weight/100)) + 
       geom_density(aes(fill = y), alpha = 0.2) +
       scale_fill_discrete(name = lab) +
        labs(x = "Weight in Kilograms", 
             title = "Density plot of Weight - BRFSS Data", 
             subtitle = subtitle) +
       theme_minimal()
      })
   output$summary_text <- renderPrint({
     input$goButton
     if (input$goButton <= 0){
       invisible()
     } else {
     model_object <- lm(model_lm$residuals ~ y)
     summary(model_object)
     }
   })
   observeEvent(input$goButton, {
   output$ex_text <<- renderPrint({
     if (lab == "Gender"){
       print("Note the very low R-Squared value.")
       print("After controlling for Height, Gender has little influence on Weight.")
     } else if (lab == "Aerobic Excercise") {
       print("Compare the R-Squared values.")
       print("Seems like Aerobic Excercise has a small influence on Weight")
     } else {
       invisible()
     }
   })
   })
}


# Run the application 
shinyApp(ui = ui, server = server)

