# Developing Data Products - Week 1 - Quiz 1
## Coursera - Data Science - Johns Hopkins


Question 1
----------
Which of the following are absolutely necessary for creating a functioning shiny app? (Check all that apply)

* A ui.R file containing a call to shinyUI()
* A server.R file that sets configuration options for hosting the App
* A server.R file containing a call to shinyServer()
* A server.R file containing calls to shinyServer() and shinyUI()
* A ui.R file that contains information about the CSS and styling of the App

True or False | Statement
--- | ---
True | A server.R file containing a call to shinyServer() 
True | A ui.R file containing a call to shinyUI()

Question 2
----------
Which is incorrect about the following syntax in ui.R?

```{r}
library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Data science FTW!"),
  sidebarPanel(
    h2('Big text')
    h3('Sidebar')
  ),
  mainPanel(
      h3('Main Panel text')
  )
))
```

* Missing comma after the h3 command
* Missing a comma in the sidebar panel
* The h2 command does not take text arguments
* The h3 command should be an h2 command

True or False | Statement
--- | ---
True | Missing a comma in the sidebar panel

Question 3
----------
Consider the following R script:

```{r}
library(shiny)
library(miniUI)

pickXY <- function() {
  ui <- miniPage(
    gadgetTitleBar("Select Points by Dragging your Mouse"),
    miniContentPanel(
      plotOutput("plot", height = "100%", brush = "brush")
    )
  )

  server <- function(input, output, session) {
      output$plot <- renderPlot({
        plot(data_frame$X, data_frame$Y, main = "Plot of Y versus X",
          xlab = "X", ylab = "Y")
      })
  }

  runGadget(ui, server)
}

my_data <- data.frame(X = rnorm(100), Y = rnorm(100))

pickXY(my_data)
```

Why isn't it doing what we want?

* No arguments are defined for pickXY()
* The input data is defined in such a way that it is not compatible with pickXY()
* The call to plot() references the column names of the data frame in the wrong order
* The wrong column names are passed to brushedPoints()

Answer | Statement 
--- | ---
True | No arguments are defined for pickXY()

Question 4
----------
What are the main differences between creating a Shiny Gadget and creating a regular Shiny App? (Check all that apply)

* Shiny Gadgets are designs to be used by R users in the middle of a data analysis
* Shiny Gadgets are specially designed for use on mobile phones and tablet computers
* Shiny Gadgets are designed to have small user interfaces that fit on one page
* Shiny Gadgets can be run on a user's personal computer, unlike a regular Shiny App which needs to be hosted online
* Shiny Gadgets are smaller programs and therefore run faster than Shiny Apps 


Answer | Statement
--- | --- 
True | Shiny Gadgets are designed to be used by R users in the middle of a data analysis.
True | Shiny Gadgets are designed to have small user interfaces that fit on one page.

Question 5
----------
Consider the following in ui.R

```{r}
shinyUI(pageWithSidebar(
  headerPanel("Example plot"),
  sidebarPanel(
    sliderInput('mu', 'Guess at the mu', value = 70, min = 60, max = 80,
      step = 0.05,) ),
  mainPanel(
    plotOutput('newHist')
  )
))
```

And the following in the server.R

```{r}
library(UsingR)
data(galton)

shinyServer(
    function(input, output) {
        output$myHist <- renderPlot({
            hist(galton$child, xlab = 'child height', col = 'lightblue', main = 'Histogram')
            mu <- input$mu
            lines(c(mu,mu),c(0,200),col="red",lwd=5)
            mse <- mean((galton$child - mu)^2)
            text(63, 150, paste("mu = ", mu))
            text(63, 140, paste("MSE = ", round(mse,2)))
            {)      }
)

Why isn't it doing what we want? (Check all that apply)

* The phrase "Guess at the mu value" should say mean instead of "mu"
* The limits of the slider are set incorrectly and giving an error.
* The server.R output name isn't the same as the plotOutput command used in ui.R
* It should be mu <- input$mean in server.R

Answer | Statement
--- | --- 
True | The server.R output name isn�t the same as the plotOutput command used in ui.R.