
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(datasets)
library("RColorBrewer") 

#----------------------------------------------------
# carrega dados de entrada
dmat=read.table("Titanic.csv",sep=",",header=TRUE)
idx<-sapply(dmat,is.numeric)
dmatNum<-dmat[,idx]
dmatCor<-cor(dmatNum)
#----------------------------------------------------

function(input, output, session) {

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
  output$heatplot <- renderPlot({  
    color.code <- brewer.pal(9,"RdBu")
    bks<-seq(-1, 1, length.out=10)
    heatmap(dmatCor, col=rev(color.code), scale="none", 
            xlab = "Variaveis Titanic", 
            ylab = "Variaveis Titanic",
            breaks=bks, cexRow = 0.6, cexCol = 0.6)
  }) 
  output$dmat <- DT::renderDataTable({
    df <- dmat 
      # filter(
        #is.null(input$ano) | Ano %in% input$ano,
        #is.null(input$vinculo) | Vinculo %in% input$vinculo,
        #is.null(input$uf) | UF %in% input$uf
        #is.null(input$vinculo) | Vinculo %in% input$vinculo
      # ) %>%
      # mutate(Action = paste('<a class="go-map" href="" data-lat="', Lat, '" data-long="', Long, '"><i class="fa fa-crosshairs"></i></a>', sep=""))
     action <- DT::dataTableAjax(session, df)
    
    DT::datatable(df, options = list(ajax = list(url = action)), escape = FALSE)
  })
  
  
}
