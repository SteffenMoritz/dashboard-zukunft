#
# ui.R for the 'Dashboard Zukunft' Shiny application

# Created for the destatis KI-Hackathon
# Team C for Climate (Denis, Laura, Maria, Steffen)

# See www.destatis.de ( statistisches Bundesamt / German Federal Statistical Office)
#


# Required Libraries
library("shinyWidgets")
library("shiny")
library("plotly")
library("shinythemes")
library("DT")
library("rsconnect")
library("shinydashboard")


# Create the Dashboard
ui <-
  fluidPage(
#----------------------------------------------------------------------------------------------------------    
    
    # Initial CSS and Theme settings
    includeCSS(path = "AdminLTE.css"),
    includeCSS(path = "shinydashboard.css"),
    theme = shinytheme("readable"), # cerulean #simplex
#----------------------------------------------------------------------------------------------------------    
    
    # Browser window text and header picture
    titlePanel(
      windowTitle = "Dashboard Zukunft",
      title = div(img(src = "header6.jpeg", height = "100px", width = "100%"))
    ),
#----------------------------------------------------------------------------------------------------------    

    # The Actual Page content
    navbarPage(
      title = "",


      # Menu Point 1 - Dashboard Zukunft
      # (includes info boxes and forecasts)
      #----------------------------------------------------------------------------------------------------
      tabPanel(
        "Dashboard Zukunft",
        fluidRow(
          tags$h3("Zielerreichung Artenvielfalt Vogelbestand"),
          tags$br(),
          
          
          valueBox(
            "100", 
            subtitle = "ZIEL (2030)",
            color = "light-blue",
            width = 3
          ),
          valueBox(
            value = textOutput("bestand_all1"),
            subtitle = "AKTUELLER STAND",
            color = "red",
            icon = icon("frown"),
            width = 3
          ),
          tags$i("Der Indikator Artenvielfalt und Landschaftsqualität
                                     zeigt die Bestandsentwicklung für 51 ausgewählte Vogelarten
                                     in Form eines Index. Er wird gemessen in erreichten Prozent
                                     des avisierten Endziels von 100% in 2030."),
          tags$br(),
          tags$br(),
          tags$br(),
          tags$br(),
          tags$br(),
          tags$br(),
          tags$h3("Artenvielfalt je Landschaftstyp"),
          tags$br(),
          valueBox(
            value = textOutput("bestand_all2"),
            subtitle = "Gesamtvogelbestand (2016)",
            color = "maroon",
            icon = icon("crow"),
            width = 2
          ),
          valueBox(
            value = textOutput("bestand_agrar"),
            subtitle = "Agrarland (2016)",
            color = "green",
            icon = icon("tractor"),
            width = 2
          ),
          valueBox(
            value = textOutput("bestand_binnen"),
            subtitle = "Binnengewässer (2016)",
            color = "aqua",
            icon = icon("water"),
            width = 2
          ),
          valueBox(
            value = textOutput("bestand_meere"),
            subtitle = "Küsten/Meere (2016)",
            color = "light-blue",
            icon = icon("ship"),
            width = 2
          ),
          valueBox(
            value = textOutput("bestand_siedlungen"), 
            subtitle = "Siedlungen (2016)",
            color = "purple",
            icon = icon("home"),
            width = 2
          ),
          valueBox(
            value = textOutput("bestand_wald"),
            subtitle = "Wälder (2016)",
            color = "olive",
            icon = icon("tree"),
            width = 2
          ),
          tags$br(),
          tags$br(),
          tags$br(),
          tags$br(),
          tags$br(),
          tags$br(),
          tags$br(),
          tags$i("Gesamt gibt der Indikator die Entwicklung der Bestände ausgewählter Vogelarten für fünf Landschafts- und Lebensraumtypen wieder.
                                         Diese gehen dabei unterschiedlich gewichtet in den Indikator ein, den größten Einfluss haben
                                         Agrarland und Wälder, weil dies auch Flächenmäßig die größten Flächen sind. Mehr zur Gewichtung auf der Hintergund Seite."),
          tags$br(),
          tags$br(),
          tags$br(),
          tags$br(),
          tags$h3("Voraussichtliche Entwicklung Gesamtbestand"),
          tags$i("Untenstehenden Slider nutzen, um den Prognosehorizont zu erweitern. Mit dem Feld Algorithmus
                                     können kann zwischen Prognosealgorithmen gewechselt werden"),
          tags$br(),
          tags$br(),

          # Show a plot of the generated distribution
          plotOutput("all_voegel_fore"),
          fluidRow(
            column(sliderInput("all_voegel_h",
              "",
              min = 1, max = 50, value = 8, width = "100%"
            ), width = 9),
            column(selectInput("algo", label = "", choices = c("ARIMA", "ETS", "NNETAR")), width = 2)
          ),
          tags$i("Prognosen für die einzlenen Lebensräume sind im Menü auf den Detailseiten zu den jeweiligen Lebensräumen zu finden")
        )
      ),
      #----------------------------------------------------------------------------------------------------
      
      
      


      # Menu Point 2 - Wirksamkeitsanalyse
      # (includes side tabs with different analysis)
      #----------------------------------------------------------------------------------------------------
      tabPanel(
        title = "Wirksamkeitsanalyse",
        navlistPanel(
          widths = c(3, 9),
          tabPanel(
            "Zeitliche Entwicklung in den Lebensräumen",
            plotlyOutput("plotly_all")
          ),
          tabPanel(
            "Im Vergleich mit häufigen Klimaindikatoren",
            plotlyOutput("plotly_andere"),
            tags$br(),
            selectInput("norm", label = "Skalierung", choices = c("absolut", "normalisiert"))
          ),
          tabPanel(
            "Helfen monetäre Umweltschutzausgaben der Artenvielfalt",
            plotlyOutput("plotly_umwelt")
          ),
          tabPanel(
            "Mögliche externe Einflussfaktoren",
            plotlyOutput("plotly_ext")
          ),
          tabPanel(
            "Machine Learning Analyse",
            tags$h3("Modellbasierte Analyse"),
            tags$i("Idee ist es ein Modell zu ertellen um Einflussfaktoren auf die Vogelanzahl zu bestimmen. Insbesondere der Zusammenhang zwischen
                                               Ausgaben für den Umweltschutz war von besonderem Interesse, um die Effektivität der Maßnahmen/ der Ausgaben in Bezug auf unseren
                                               Indikator zu überprüfen."),
            tags$br(),
            tags$br(),
            tags$h4("GLM Model (Generalized Linear Model)"),
            tags$br(),
            tags$i("formula = `Bestand repraesentativer Vogelarten, insgesamt` ~
    Umweltschutzausgaben_gesamt + `Feinstaub (PM2,5)` + `Anteil des Stroms aus erneuerbaren Energiequellen am Bruttostromverbrauch` +
        Bevoelkerungsstand + `Bruttowertschoepfung in jeweiligen Preisen, insgesamt`"),
            tags$br(),
            tags$br(),
            tags$img(src = "ML.png", width = "600px", height = "200px")
          )
        )
      ),
      #----------------------------------------------------------------------------------------------------
      
      


      
      # Menu Point 3 - Agrarland
      # (includes more information about )
      #----------------------------------------------------------------------------------------------------
      tabPanel(
        title = "Agrarland",
        fluidRow(
          tags$h3("Voraussichtliche Entwicklung Agrarland"),
          tags$i("Untenstehenden Slider nutzen, um den Prognosehorizont zu erweitern."),
          plotOutput("agrar_voegel_fore", width = "90%"),
          sliderInput("agrar_voegel_h",
            width = "90%",
            "", min = 1, max = 50, value = 8
          )
        )
      ),
      #----------------------------------------------------------------------------------------------------
      
      
      

      # Menu Point 4 - Binnengewässer
      # (includes more information about)
      #----------------------------------------------------------------------------------------------------
      tabPanel(
        "Binnengewässer",
        fluidRow(
          tags$h3("Voraussichtliche Entwicklung Agrarland und Binnengewässer"),
          tags$i("Untenstehenden Slider nutzen, um den Prognosehorizont zu erweitern."),
          plotOutput("binnen_voegel_fore", width = "90%"),
          sliderInput("binnen_voegel_h",
            width = "90%",
            "", min = 1, max = 50, value = 8
          )
        )
      ),
      #----------------------------------------------------------------------------------------------------
      
      
      
      

      # Menu Point 5 - Küsten/Meeren
      # (includes more information about)
      #----------------------------------------------------------------------------------------------------
      tabPanel(
        title = "Küsten/Meere",
        fluidRow(
          tags$h3("Voraussichtliche Entwicklung Meere/Küsten"),
          tags$i("Untenstehenden Slider nutzen, um den Prognosehorizont zu erweitern."),
          plotOutput("meer_voegel_fore", width = "90%"),
          sliderInput("meer_voegel_h",
            width = "90%",
            "", min = 1, max = 50, value = 8
          )
        )
      ),
      #----------------------------------------------------------------------------------------------------
      
      
      

      # Menu Point 6 - Siedlungen
      # (includes more information about)
      #----------------------------------------------------------------------------------------------------
      tabPanel(
        title = "Siedlungen",
        fluidRow(
          tags$h3("Voraussichtliche Entwicklung Siedlungsbebiete"),
          tags$i("Untenstehenden Slider nutzen, um den Prognosehorizont zu erweitern."),
          plotOutput("stadt_voegel_fore", width = "90%"),
          sliderInput("stadt_voegel_h",
            width = "90%",
            "", min = 1, max = 50, value = 8
          )
        )
      ),
      #----------------------------------------------------------------------------------------------------
      
      

      # Menu Point 7 - Wälder
      # (includes more information about)
      #----------------------------------------------------------------------------------------------------
      tabPanel(
        title = "Wälder",
        fluidRow(
          tags$h3("Voraussichtliche Entwicklung Wälder"),
          tags$i("Untenstehenden Slider nutzen, um den Prognosehorizont zu erweitern."),
          tags$br(),
          tags$br(),
          plotOutput("wald_voegel_fore"),
          sliderInput("wald_voegel_h",
            width = "90%",
            "", min = 1, max = 50, value = 8
          )
        )
      ),
      #----------------------------------------------------------------------------------------------------
      
      
      
      # Menu Point 8
      # (includes more information about)
      #----------------------------------------------------------------------------------------------------
      tabPanel(
        title = "Hintergrundwissen",
        navlistPanel(
          widths = c(3, 9),
          tabPanel(
            "Zielsetzung Indikator",
            tags$h3("Zielsetzung Indikator"),
            tags$i("Der Indikator ist einer der zentralen Umwelt-Indikatoren des Umweltbundesamtes. Die Umweltindikatoren
                                                    sind für die deutsche und internationale Umweltpolitik besonders relevant. Ziel des Indikators ist es 100%
                                                    in 2030 zu erreichen und damit entsprechend auf Bestandswerte die 1975 erreicht wurden
                                                    zurückzukommen."),
            tags$br(),
            tags$br(),
            tags$img(src = "ziele.png", width = "800px", height = "600px")
          ),
          tabPanel(
            "Zusammensetzung Indikator",
            tags$h3("Zusammensetzung Indikator"),
            tags$i("Untenstehenden Slider nutzen, um den Prognosehorizont zu erweitern."),
            tags$br(),
            tags$br(),
            tags$img(src = "indikator.png", width = "800px", height = "800px")
          ),
          tabPanel(
            "Linksammlung",
            fluidRow(
              tags$h3("Linksammlung"),
              tags$h5("Datenquellen und Indikator"),
              tags$i("https://www.umweltbundesamt.de/daten/umweltindikatoren"),
              tags$i("https://www.umweltbundesamt.de/daten/umweltindikatoren/indikator-artenvielfalt-landschaftqualitaet"),
              tags$br(),
              tags$br(),
              tags$h5("Bildqellen"),
              tags$i("https://www.umweltbundesamt.de/daten/umweltindikatoren"),
              tags$i("https://www.umweltbundesamt.de/daten/umweltindikatoren/indikator-artenvielfalt-landschaftqualitaet"),
              tags$br(),
              tags$br(),
              tags$h5("Infos zum Dashboard"),
              tags$i("https://www.destatis.de"),
              tags$i("github")
            )
          )
        )
      ),
      #----------------------------------------------------------------------------------------------------
      
      
      
      
      # Menu Point 9 - Impressum
      # (includes more information about)
      #----------------------------------------------------------------------------------------------------
      tabPanel(
        title = "Impressum", fluidPage(htmlOutput("impressum"))
      )
      #----------------------------------------------------------------------------------------------------
      
      
    ), # end navbarPage

    
#----------------------------------------------------------------------------------------------------------  

    # Adding favicon to webpage. Favicon is base64 coded to avoid adding image. 
    title = tags$head(tags$link(
      rel = "icon",
      href = "data:image/x-icon;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQC
                                  AYAAAAf8/9hAAABtUlEQVQ4T62TTUiTcRjAf89sjolsIkmXTYXYIAVBOmRIUAYKK
                                  whqM4o86dSbIR47BIGH9CKIH9PTDokf0aWLhGHILqIEI4wCLQUvdlhBKu7VPfFuu
                                  l4/Bpb+b8//eZ7f8y0cfWMPqrFJKyJ1QPm++juq70lphEevP1pdJCtMhJyo9iG0g
                                  Pz9PxRAFWUUkQ4aJ7dNVcbQdEanQW4cy+jED50DaTAhGcB4MIJI+HTO+1aqIzyca
                                  hXMmvNkMXfaubCq7OlVYTw4iEi7w2bncWlt2jqR3GT2xxI/jU2uFfuocHmylGTK4
                                  NVaDLMZqA4JE6EvgL84v5BvgX66P7/hosNFyFvD/VgvLnsB1UXlXLDZeHYlSFc8y
                                  sjKzAHwqwnYAfJNQLy+F8/b9rSywxegyl1G88JgWu6pasJld9K2GLHWlMwJeOq7Q
                                  6XbQ3hhmKCnhk7/XW7NPmcntXsMkC1hJdDPi6UpShxuGr3XuRd7iZHaY/52NwPL0
                                  6xvJzB0l6Hld5YSLE18UpZZg0TyNzMbn/hlbHGzpJLLhZeyUU1gdPVDRk438cxjP
                                  PMincsqH0D++5isg/nHc/4Dohe5L/OvdC4AAAAASUVORK5CYII=",
      type = "image/x-icon"
    )) # end title/favicon
#----------------------------------------------------------------------------------------------------------        
    
  ) # end fluidPage
