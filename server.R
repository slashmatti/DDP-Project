library(shiny)
library(ggplot2)

# Load the datasets package and create a data.frame
library(ISLR)
data(Auto)
Au <- Auto[-c(8:9)]
dat <- Auto[-9] #Dropped car names column

# A server for the Shiny app
shinyServer(function(input, output) {
    
    # Create a plot
    output$carPlot <- renderPlot({
        
        # Data.frame for plot code
        dataframe <- data.frame(origin = dat$origin, var = dat[[input$statistic]])
        # Labels for the y-axis
        ylabel <- c("Miles per gallon","Number of cylinders between 4 and 8",
                    "Engine displacement (cu. inches)","Engine horsepower",
                    "Vehicle weight (lbs.)","Time to accelerate from 0 to 60 mph (sec.)",
                    "Model year (modulo 100)")
        true_index <- colnames(Au)==input$statistic
        i <- which(true_index)
        
        # Create a boxplot
        ggplot(dataframe, aes(factor(origin),var)) + 
            geom_boxplot(aes(fill = factor(origin))) + 
            scale_fill_discrete(labels=c("American", "European", "Japanese"),
                                name="Origin",
                                breaks=c("1","2","3")) +
            scale_x_discrete(labels=c("American", "European", "Japanese")) +
            ggtitle(input$statistic) +
            theme_bw() +
            xlab("Origin") +
            ylab(ylabel[i])
    })
})