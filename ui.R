
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

# carrega dados de entrada
dmat=read.table("Titanic.csv",sep=",",header=TRUE)
idx<-sapply(dmat,is.numeric)
dmatNum<-dmat[,idx]
dmatCor<-cor(dmatNum)
exemplos<-colnames(dmatCor)
exemplos
#----------------------------------------------------


library(shiny)
library(shinythemes)

shinyUI(fluidPage(
  # theme = shinytheme("cerulean"),
  shinythemes::themeSelector(),
  
  navbarPage(
    # theme = "cerulean",  # <--- To use a theme, uncomment this
    "Titanic Survivors",
    tabPanel(
      "ShinyApp - Powered by TADS - UFPR 2017",
      navlistPanel(
        "Menu",
        tabPanel(
          "Introdução",
          h1("Introdução"),
          h3("O Titanic"),
          p(
            "Em 15 de abril de 1912, o RMS Titanic afundou algumas horas depois de colidir com um gigantesco iceberg. Muitos filmes foram feitos desde então para contar a história do navio “impossível de naufragar” que não conseguiu concluir sequer a sua viagem inaugural."
          ),
          p("Confira 8 curiosidades sobre o naufrágio:"),
          p(
            "1. O Titanic demorou duas horas e quarenta minutos para afundar completamente depois de colidir com o iceberg."
          ),
          #renderImage("img/imagem1.jpg"),
          p(
            "2. Se apenas quatro compartimentos do Titanic enchessem de água, o navio não afundaria, porém seis deles foram inundados."
          ),
          p(
            "3. Havia um treinamento de emergência marcado com os passageiros para a mesma data em que o navio afundou, mas o capitão por algum motivo resolveu cancelar. Se o treinamento agendado realmente tivesse acontecido, provavelmente mais pessoas teriam sido salvas."
          ),
          p(
            "4. Os destroços do navio só foram encontrados 73 anos depois, em 1985, a cerca de 600 km da costa de Newfoundland e a quase 4 km abaixo do nível do mar."
          ),
          p(
            "5. Muitos dos barcos salva-vidas não estavam com a sua capacidade máxima de pessoas a bordo. Se estivessem, seria possível salvar 53,4% dos passageiros, mas apenas 31,6% deles sobreviveram."
          ),
          p(
            "6. O Titanic foi o único transatlântico da História que afundou por causa de um iceberg."
          ),
          p(
            "7. A temperatura da água chegava a -2 °C e a maioria das pessoas não conseguiu sobreviver mais de 15 minutos devido à hipotermia."
          ),
          p(
            "8. Só havia 20 barcos salva-vidas a bordo do navio, mas o Titanic era capaz de carregar até 64 e o plano inicial era para que ele carregasse 48. O número foi reduzido para fazer com que o deck não parecesse desorganizado."
          )
          
        ),
        tabPanel(
          "Correlação",
          # h3("This is the second panel")
          selectInput("var", "Variável de Interesse:", choices = colnames(dmatCor)),
          plotOutput("barplot")),
        tabPanel(
          "Heatmap",
          # h3("This is the third panel"))
          plotOutput("heatplot")),
        tabPanel("Dataset",
           # h3("This is the third panel")
           hr(),
           DT::dataTableOutput("dmat")
        ) #Tabpanel END
      ) #Navlist END
    )
    )
  )
  
)


