library(shiny)
library(dplyr)
library(ggplot2)
source("data.R")


server <- function(input, output) {
  
  
#Graficos  
  
  output$PlotP <-renderPlot({
    
      pacientes%>%
      ggplot()+
      geom_bar(mapping =aes(x=IC_SEXO, fill = IC_SEXO))+
      ylim(0,8000)
    
  })
  
  output$Plot2P <-renderPlot({
    
      pacientes%>%
      ggplot()+
      geom_bar(mapping = aes(x=AA_NASCIMENTO),fill = "blue", color= "white",
               width = 0.99999)+
      ylim(0,500)+
      labs(x="ano de nascimento", y="número de pacientes")
  })
  
  output$PlotE <-renderPlot({
    
    ggplot(tabela_exames_por_paciente)+
      geom_histogram(mapping = aes(x=ndeexames),fill = "blue", color= "white"
              ) 
    
    })
    
  output$Plot <-renderPlot({
    
    x<-input$options
    
    exames%>%
      filter(DE_EXAME == x)%>%
          ggplot()+
      geom_bar(mapping =aes(x=IC_SEXO, fill = IC_SEXO))+
      ylim(0,8000)
  })
      
  output$Plot2 <-renderPlot({
    
    x<-input$options
    
    exames%>%
      filter(DE_EXAME == x)%>%
      ggplot()+
      geom_bar(mapping = aes(x=AA_NASCIMENTO),fill = "blue", color= "white",
               width = 0.99999)+
      ylim(0,500)+
      labs(x="ano de nascimento", y="número de pacientes")
  })
  
  output$Plot3 <-renderPlot({
    
    x<-input$options
    
    exames%>%
      filter(DE_EXAME==x)%>%
      group_by(DT_COLETA)%>%
      ggplot()+
      geom_bar(mapping= aes(x=as.Date(DT_COLETA)),fill = "blue", color= "white",
                            width = 0.99999)
  })
  
  
#Valueboxes
  
  output$total_de_pacientes <- renderValueBox({
    valueBox(
      n_distinct(exames$ID_PACIENTE), "Total de Pacientes", icon = icon("list"),
      color = "blue"
    )
  })
  
  output$exames_oferecidos <- renderValueBox({
    valueBox(
      n_distinct(exames$DE_EXAME), "Exames Oferecidos", icon = icon("calculator"),
      color = "teal"
    )
  
  })
  
  output$media_de_exames_por_paciente <- renderValueBox({
    valueBox(
      round(nrow(exames)/n_distinct(exames$ID_PACIENTE)), "Média de Exames por Paciente", icon = icon("calculator"),
      color = "navy"
    )
  })
  

  output$total_PCR <- renderValueBox({
    valueBox(
      nrow(
        exames%>%
      filter(DE_EXAME == "PCR em tempo real para detecção de Coron")), "Total de PCRs", icon = icon("calculator"),
     color = "navy")
    
  })
  
  output$total_sorologia <- renderValueBox({
    valueBox(
      nrow(
        exames%>%
        filter(DE_EXAME == "Sorologia SARS-CoV-2/COVID19 IgG/IgM")), "Total de Sorologia", icon = icon("calculator"),
      color = "navy")
    
  })
  #Mapas 
  
  output$leaf1 <- renderLeaflet({
    leaflet(map1) %>%
      addTiles() %>%
      addPolygons(color = "black", opacity = 0.5, weight = 1, fillColor = ~ pal(map1$total),
                  fillOpacity = 0.5, label = map1$total)%>%
      addLegend(pal = pal, values = ~total, opacity = 1)
    
  })
  
  output$leaf2 <- renderLeaflet({ 
    leaflet(map2) %>%
      addTiles() %>%
      addPolygons(color = "black", opacity = 1, weight = 1, fillColor = ~ pal2(map2$total),
                  fillOpacity = 1, label = map2$total)%>%
      addLegend(pal = pal2, values = ~total, opacity = 1)
  })
  
  
}