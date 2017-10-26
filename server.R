
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

# library(shiny)
# library(datasets)

#----------------------------------------------------
# carrega dados de entrada
dmat=read.table("Titanic.csv",sep=",",header=TRUE)
idx<-sapply(dmat,is.numeric)
dmatNum<-dmat[,idx]
dmatCor<-cor(dmatNum)
#----------------------------------------------------

function(input, output) {

  # Fill in the spot we created for a plot
  output$barplot <- renderPlot({
    
    #----------------------------------------------------
    # seleciona variavel (via input$var)
    varInteresse <- "SexCode"
    varInteresse <- input$var
    temp <- dmatCor[,varInteresse]
    idx <- which(names(temp)==varInteresse)
    temp <- temp[-idx]
    temp <- sort(temp)
    
    #----------------------------------------------------
    # Render a barplot (Correlation)
    barplot(temp, las=3, ylab = "Correlacao (R)")
    mtext(varInteresse, side = 3)
    #----------------------------------------------------
    
    #----------------------------------------------------
    # Render a barplot (Correlation)
    
})
  
}
