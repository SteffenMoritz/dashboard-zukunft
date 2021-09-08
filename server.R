#
# server.R for the 'Dashboard Zukunft' Shiny application

# Created for the destatis KI-Hackathon
# Team C for Climate (Denis, Laura, Maria, Steffen)

# See www.destatis.de ( statistisches Bundesamt / German Federal Statistical Office)
#

# Required Libraries
library("shiny")
library("fable")
library("tsibble")
library("lubridate")
library("ggplot2")
library("gridExtra")
library("dplyr")
library("plotly")
library("imputeTS")



# Load pre-calculated forecasts
# ARIMA
load(file = "plot_data/gg_all_voegel_arima.rda")
load(file = "plot_data/gg_agrar_voegel_arima.rda")
load(file = "plot_data/gg_binnen_voegel_arima.rda")
load(file = "plot_data/gg_meer_voegel_arima.rda")
load(file = "plot_data/gg_stadt_voegel_arima.rda")
load(file = "plot_data/gg_wald_voegel_arima.rda")

# ETS
load(file = "plot_data/gg_all_voegel_ets.rda")
load(file = "plot_data/gg_agrar_voegel_ets.rda")
load(file = "plot_data/gg_binnen_voegel_ets.rda")
load(file = "plot_data/gg_meer_voegel_ets.rda")
load(file = "plot_data/gg_stadt_voegel_ets.rda")
load(file = "plot_data/gg_wald_voegel_ets.rda")

# Load general datasets
load(file = "data/voegel4.rda")
load(file = "data/scaled_voegel4.rda")





shinyServer(function(input, output) {


    
  # Text Output Value Box Vogelbestand Gesamt 1
  #--------------------------------------------------------------#
  output$bestand_all1 <- renderText({
     out <- tail(na_locf(voegel4$`Bestand repraesentativer Vogelarten, insgesamt`),1)
  })
  
  # Text Output Value Box Vogelbestand Gesamt 2
  #--------------------------------------------------------------#
  output$bestand_all2 <- renderText({
      out <- tail(na_locf(voegel4$`Bestand repraesentativer Vogelarten, insgesamt`),1)
  })
  
  # Text Output Value Box Vogelbestand Agar
  #--------------------------------------------------------------#
  output$bestand_agrar <- renderText({
      out <- tail(na_locf(voegel4$`Bestand repraesentativer Vogelarten, Agrarland`),1)
  })
  
  # Text Output Value Box Vogelbestand Binnengewässer
  #--------------------------------------------------------------#
  output$bestand_binnen <- renderText({
      out <- tail(na_locf(voegel4$`Bestand repraesentativer Vogelarten, Binnengewaesser`),1)
  })
  
  # Text Output Value Box Vogelbestand Meere/Küsten
  #--------------------------------------------------------------#
  output$bestand_meere <- renderText({
      out <- tail(na_locf(voegel4$`Bestand repraesentativer Vogelarten, Kuesten/Meere`),1)
      return(as.character(out))
  })

  # Text Output Value Box Vogelbestand Siedlungen
  #--------------------------------------------------------------#
  output$bestand_siedlungen <- renderText({
      out <- tail(na_locf(voegel4$`Bestand repraesentativer Vogelarten, Siedlungen`),1)
  })
  
  # Text Output Value Box Vogelbestand Wald
  #--------------------------------------------------------------#
  output$bestand_wald <- renderText({
      out <- tail(na_locf(voegel4$`Bestand repraesentativer Vogelarten, Waelder`),1)

  })
  

    
  # Forecast alle Vögel
  #--------------------------------------------------------------#
  output$all_voegel_fore <- renderPlot({
    if (input$algo == "ARIMA") {
      gg_all_voegel_fore <- gg_all_voegel_arima
    }
    else if ((input$algo == "ETS")) {
      gg_all_voegel_fore <- gg_all_voegel_ets
    }
    else if ((input$algo == "NNETAR")) {

      # nnetar ggplot2 files are huge, thus get only loaded when required
      load(file = paste0("plot_data/gg_all_voegel_nnetar/gg_all_voegel_nnetar", input$all_voegel_h, ".rda"))
      return(gg3)
    }
    return(gg_all_voegel_fore[[input$all_voegel_h]])
  })

  # Forecast Agrar Vögel
  #--------------------------------------------------------------#
  output$agrar_voegel_fore <- renderPlot({
    gg_agrar_voegel_fore <- gg_agrar_voegel_arima
    return(gg_agrar_voegel_fore[[input$agrar_voegel_h]])
  })
  #--------------------------------------------------------------#

  # Forecast Binnen Vögel
  #--------------------------------------------------------------#
  output$binnen_voegel_fore <- renderPlot({
    gg_binnen_voegel_fore <- gg_binnen_voegel_arima
    return(gg_binnen_voegel_fore[[input$binnen_voegel_h]])
  })
  #--------------------------------------------------------------#

  # Forecast Meer Vögel
  #--------------------------------------------------------------#
  output$meer_voegel_fore <- renderPlot({
    gg_meer_voegel_fore <- gg_meer_voegel_arima
    return(gg_meer_voegel_fore[[input$meer_voegel_h]])
  })
  #--------------------------------------------------------------#

  # Forecast Stadt Vögel
  #--------------------------------------------------------------#
  output$stadt_voegel_fore <- renderPlot({
    gg_stadt_voegel_fore <- gg_stadt_voegel_arima
    return(gg_stadt_voegel_fore[[input$stadt_voegel_h]])
  })
  #--------------------------------------------------------------#

  # Forecast Wald Vögel
  #--------------------------------------------------------------#
  output$wald_voegel_fore <- renderPlot({
    gg_wald_voegel_fore <- gg_wald_voegel_arima
    return(gg_wald_voegel_fore[[input$wald_voegel_h]])
  })
  #--------------------------------------------------------------#



  # Alle Voegel Shiny
  #--------------------------------------------------------------#
  output$plotly_all <- renderPlotly({
    p <- plot_ly(data = voegel4, x = ~Jahr, y = ~`Bestand repraesentativer Vogelarten, insgesamt`, name = "Vogelbestand Insgesamt", type = "scattergl", mode = "lines+markers") %>%
      add_trace(y = ~`Bestand repraesentativer Vogelarten, Agrarland`, name = "Vogelbestand Agrar", mode = "lines+markers", type = "scattergl") %>%
      add_trace(y = ~`Bestand repraesentativer Vogelarten, Binnengewaesser`, name = "Vogelbestand Binnengewässer", mode = "lines+markers", type = "scattergl", visible = "legendonly") %>%
      add_trace(y = ~`Bestand repraesentativer Vogelarten, Kuesten/Meere`, name = "Vogelbestand Küsten/Meere", mode = "lines+markers", type = "scattergl", visible = "legendonly") %>%
      add_trace(y = ~`Bestand repraesentativer Vogelarten, Siedlungen`, name = "Vogelbestand Siedlungen", mode = "lines+markers", type = "scattergl", visible = "legendonly") %>%
      add_trace(y = ~`Bestand repraesentativer Vogelarten, Waelder`, name = "Vogelbestand Wälder", mode = "lines+markers", type = "scattergl") %>%
      layout(
        title = "Bestand repräsentativer Vogelarten in verschiedenen Lebensräumen",
        xaxis = list(title = "Time"),
        yaxis = list(title = "Value")
      )
  })
  #--------------------------------------------------------------#
  selec <- reactive({
    if (input$norm == "normalisiert") {
      return(scaled_voegel4)
    }
    else {
      return(voegel4)
    }
  })

  output$plotly_andere <- renderPlotly({
    p <- plot_ly(data = selec(), x = ~Jahr, y = ~`Kohlendioxidemissionen je Einwohner`, name = "CO2/Einwohner", mode = "lines+markers", type = "scattergl") %>%
      add_trace(y = ~`Bestand repraesentativer Vogelarten, insgesamt`, name = "Vogelbestand Insgesamt", type = "scattergl", mode = "lines+markers", visible = "legendonly") %>%
      add_trace(y = ~Primärenergieverbrauch..Rohöleinheiten.je.Einwoh.., name = "Primärenergieverbrauch/Einw.", mode = "lines+markers", type = "scattergl", visible = "legendonly") %>%
      add_trace(y = ~`Anzahl der Tage mit einem Lufttemperatur-Maximum ueber 30 Grad Celsius (Gebietsmittel)`, name = "Tage über 30 Grad", mode = "lines+markers", type = "scattergl", visible = "legendonly") %>%
      add_trace(y = ~`Emission der von der UN-Klimarahmenkonvention abgedeckten Treibhausgase - Landwirtschaft`, name = "Treibhausgase Landwirtschaft", mode = "lines+markers", type = "scattergl", visible = "legendonly") %>%
      add_trace(y = ~`Feinstaub (PM2,5)`, name = "Feinstaub", mode = "lines+markers", type = "scattergl", visible = "legendonly") %>%
      layout(
        title = "Entwicklung Bestand repräsentativer Vogelarten im Vergleich zu anderen Klimazielen",
        xaxis = list(title = "Time"),
        yaxis = list(title = "Value")
      )
  })

  #--------------------------------------------------------------#

  output$plotly_umwelt <- renderPlotly({
    da <- voegel4 %>% filter(Jahr >= 2010 & Jahr <= 2018)
    p <- plot_ly(data = da, x = ~Jahr, y = ~Umweltschutzausgaben_gesamt, name = "Umweltschutzausgaben_gesamt", mode = "lines+markers", type = "scattergl") %>%
      add_trace(y = ~`Bestand repraesentativer Vogelarten, insgesamt`, name = "Vogelbestand Insgesamt", type = "scattergl", mode = "lines+markers", yaxis = "y2") %>%
      add_trace(y = ~Umweltschutzausgaben_Staat, name = "Umweltschutzausgaben_Staat", mode = "lines+markers", type = "scattergl", visible = "legendonly") %>%
      add_trace(y = ~Umweltschutzausgaben_Unternehmen, name = "Umweltschutzausgaben_Unternehmen", mode = "lines+markers", type = "scattergl", visible = "legendonly") %>%
      add_trace(y = ~Umweltschutzausgaben_Privat, name = "Umweltschutzausgaben_Privat", mode = "lines+markers", type = "scattergl", visible = "legendonly") %>%
      layout(
        title = "Umweltschutzausgaben und Entwicklung Bestand repräsentativer Vogelarten",
        xaxis = list(title = "Time"),
        yaxis = list(title = "Ausgaben"),
        yaxis2 = list(title = "Index", overlaying = "y", side = "right")
      )
  })

  #--------------------------------------------------------------#

  output$plotly_ext <- renderPlotly({
    p <- plot_ly(data = voegel4, x = ~Jahr, y = ~ voegel4$`Anteil des Stroms aus erneuerbaren Energiequellen am Bruttostromverbrauch`, name = "Anteil erneuerbare Energien", mode = "lines+markers", type = "scattergl") %>%
      add_trace(y = ~`Bestand repraesentativer Vogelarten, insgesamt`, name = "Vogelbestand Insgesamt", type = "scattergl", mode = "lines+markers", yaxis = "y2") %>%
      add_trace(y = ~ voegel4$`Feinstaub (PM2,5)`, name = "Feinstaub", mode = "lines+markers", type = "scattergl", visible = "legendonly") %>%
      add_trace(y = ~ voegel4$Bevoelkerungsstand, name = "Bevoelkerungsstand", mode = "lines+markers", type = "scattergl", visible = "legendonly") %>%
      add_trace(y = ~ voegel4$`Bruttowertschoepfung in jeweiligen Preisen, insgesamt`, name = "Bruttowertschoepfung", mode = "lines+markers", type = "scattergl", visible = "legendonly") %>%
      layout(
        title = "Umweltschutzausgaben und Entwicklung Bestand repräsentativer Vogelarten",
        xaxis = list(title = "Time"),
        yaxis = list(title = "Value"),
        yaxis2 = list(title = "Index", overlaying = "y", side = "right")
      )
  })


  #--------------------------------------------------------------#
  output$distPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    x <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = "darkgray", border = "white")
  })

  #--------------------------------------------------------------#

  output$impressum <- renderUI({
    includeHTML("impressum.html")
  })

  #--------------------------------------------------------------#

  output$about <- renderUI({
    includeHTML("about.html")
  })
})
