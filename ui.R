library(shiny)

# Load the datasets package and create a data.frame
library(ISLR)
data(Auto)
dat <- Auto[-c(8:9)] #Dropped origin and car name columns, for proper input options

# Define UI
shinyUI(
    
    # Fluid Bootstrap layout
    fluidPage(    
        
        titlePanel("Car Data by Origin"),
        
        # Generate a row with a sidebar
        sidebarLayout(      
            
            # A sidebar with one input
            sidebarPanel(
                helpText("Choose a statistic to display a boxplot, by origin of the cars"),
                selectInput("statistic", "Statistic:", 
                            choices=colnames(dat)),
                hr(),
                helpText("Data from the 1983 American Statistical Association Exposition")
            ),
            
            # Create a spot for the barplot
            mainPanel(
                plotOutput("carPlot")  
            )
            
        )
    )
)