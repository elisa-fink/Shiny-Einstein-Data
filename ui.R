library(shiny)
library(dplyr)
library(shinydashboard)
library(ggplot2)
library(plotly)
source("data.R")

ui <- dashboardPage(
  
  dashboardHeader(title = "Dashboard Einstein"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Perfil dos Pacientes", tabName = "perfil", icon = icon("users")),
      menuItem("Exames Geral", tabName = "exames", icon = icon("vials")),
      menuItem("Exames Covid-19", tabName = "covid", icon = icon("viruses"))
    )
  ),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "perfil",
              fluidRow(
                valueBoxOutput(width = 2, outputId = "total_de_pacientes")
              ),
              fluidRow(
                box(
                  plotOutput(outputId = "PlotP")),
                box(
                  plotOutput(outputId = "Plot2P"))
              ),
              fluidRow(
                box(
                  leafletOutput(outputId = "leaf1")),
                box(
                  leafletOutput(outputId = "leaf2"))
              )
      ),
      tabItem(
        tabName = "exames",
        fluidRow(
          valueBoxOutput(width = 2, outputId = "total_de_pacientes"),
          valueBoxOutput(width = 2, outputId = "exames_oferecidos"),
          valueBoxOutput(width = 2, outputId = "media_de_exames_por_paciente")
        ),
        fluidRow(
            box(
            plotOutput(outputId = "PlotE"))
        )
          
        
      ),
      
      tabItem(
        tabName = "covid",
        fluidRow(
          box(width = 6,
              selectInput(inputId = "options", label = NULL, 
                          choices =  c("Sorologia SARS-CoV-2/COVID19 IgG/IgM","PCR em tempo real para detecção de Coron"), 
                          selected = 1)),
          valueBoxOutput(width = 2, outputId = "total_de_pacientes")
        ),
        fluidRow(
          box(
            plotOutput(outputId = "Plot")),
          box(
            plotOutput(outputId = "Plot2")),
          box(
            plotOutput(outputId = "Plot3"))
        )
      )
     )
    )
  )

