
library(ggplot2)
library(DT)
library(shiny)
library(shinythemes)
library(GGally)
library(bslib)


ui <- tagList(
  shinythemes::themeSelector(),
  navbarPage(
    "Aplikacja",
    
    #============================================= Dane ===========================================================
    tabPanel("Dane",
      titlePanel(h1("Dane", align = "center")),
      
      sidebarLayout(
      sidebarPanel(
      
        conditionalPanel(
        'input.dataset === "Wskaznik_HDI"',
          checkboxGroupInput("show_vars1", "Wybierz kolumny:",
                           names(Wskaznik_HDI), selected = names(Wskaznik_HDI)),
        helpText("Opis danych: Wskaznik rozowju spolecznego HDI.", 
                 "Ocenia kraje na 3 plaszczyznach: dlugie i zdrowe zycie,",
                 "wiedza, dostatni standard zycia.",
                 "Kraje ze wskaznikiem co najmniej 0,710 uwaza sie za wysoko rozwiniete,",
                 "a ponizej 0,536 za rozwiniete slabo.")
        ),
       
        conditionalPanel(
          'input.dataset === "PKB_na_mieszkanca"',
          checkboxGroupInput("show_vars2", "Wybierz kolumny:",
                           names(PKB_na_mieszkanca), selected = names(PKB_na_mieszkanca)),
          helpText("Opis danych: Wskaznik liczony jest jako stosunek realnego PKB",
                   "do sredniej liczby ludnosci w danym roku.",
                   "PKB mierzy wartosc calkowitej koncowej produkcji",
                   "towarow i uslug wytworzonych przez gospodarke w okreslonym czasie.")
          ),
        conditionalPanel(
          'input.dataset === "Wspolczynnik_Giniego"',
          checkboxGroupInput("show_vars3", "Wybierz kolumny:",
                             names(Wspolczynnik_Giniego), selected = names(Wspolczynnik_Giniego)),
          helpText("Opis danych: Wspolczynnik Giniego (Wskaznik Nierownosci Spolecznej)",
                   "- im wartosc wyzsza dla danego kraju,",
                   "tym wieksze rozwarstwienie spoleczne w nim panuje.")
          ),
        conditionalPanel(
          'input.dataset === "Smiertelnosc_niemowlat"',
          checkboxGroupInput("show_vars4", "Wybierz kolumny:",
                             names(Smiertelnosc_niemowlat), selected = names(Smiertelnosc_niemowlat)),
          helpText("Opis danych: Stosunek liczby zgonow dzieci ponizej 1 roku zycia w ciagu roku",
                   "do liczby urodzen zywych w tym roku. Wartosc wyrazona jest na 1000 urodzen zywych.")
          ),
        conditionalPanel(
          'input.dataset === "Ogolne_szczescie"',
          checkboxGroupInput("show_vars5", "Wybierz kolumny:",
                             names(Ogolne_szczescie), selected = names(Ogolne_szczescie)),
          helpText("Opis danych: Dane pochodzace z ankiety dot. szczescia globalnego. Wskaznik obliczony",
                   "wedlug oceny zadowolenia m.in. zdrowotnego, politycznego, ekonomicznego oraz rodzinnego.")
          ),
          width = 3
        
     
      
        ),
        mainPanel(
          
          tabsetPanel(
            
            id = 'dataset',
            tabPanel("Wskaznik_HDI", DT::dataTableOutput("mytable1")),
            tabPanel("PKB_na_mieszkanca", DT::dataTableOutput("mytable2")),
            tabPanel("Wspolczynnik_Giniego", DT::dataTableOutput("mytable3")),
            tabPanel("Smiertelnosc_niemowlat", DT::dataTableOutput("mytable4")),
            tabPanel("Ogolne_szczescie", DT::dataTableOutput("mytable5"))
            ),
          width = 9
        ))
      ),
    
    #============================================== Podstawowe statystyki =========================================================
    
    
    tabPanel("Podstawowe statystyki",
      titlePanel(h1("Statystyki", align = "center")),
      
      sidebarLayout(
       
       sidebarPanel(
        selectInput("datasets", "Wybierz dane:",
                    choices = c("Wskaznik_HDI", "PKB_na_mieszkanca", "Wspolczynnik_Giniego", "Smiertelnosc_niemowlat", "Ogolne_szczescie")),
        
        numericInput("obs", "Liczba obserwacji:", 10),
        
        helpText("Wskazowka: Zmiana obserwacji wplywa jedynie na ilosc", 
                 "wyswietlanych danych, a nie na liczone statystyki"),
        
        actionButton("update", "Zaktualizuj"),
        width = 3
        ),
       
       
       mainPanel(
         
        
           h4("Podsumowanie"),
           verbatimTextOutput("summary"),
         
           h4("Obserwacje"),
           tableOutput("view"),
         width = 8
       )
      )),
    
    
    #============================================= Wykresy ===========================================================
    
    navbarMenu("Wykresy",
               tabPanel("Histogram",
                        titlePanel(h1("Histogram", align = "center")),
                        
                        sidebarLayout(
                          
                          sidebarPanel(
                            selectInput("datasets1", "Wybierz dane:",
                                        choices = c("Wskaznik_HDI", "PKB_na_mieszkanca", "Wspolczynnik_Giniego", "Smiertelnosc_niemowlat", "Ogolne_szczescie")),
                            selectInput("var1", "Wybierz kolumny:",
                                        choices = c("rok.2012"=1,"rok.2013"=2,"rok.2014"=3,"rok.2015"=4, 
                                                    "rok.2016"=5, "rok.2017"=6, "rok.2018"=7, "rok.2019"=8, 
                                                    "rok.2020"=9, "rok.2021"=10)),
                            
                            sliderInput("bin", "Wybierz liczbe pojemnikow na histogramie:", min=5, max=25, value=15),
                            
                            radioButtons("colour1", label = "Wybierz kolor histogramu:",
                                         choices = c("Green", "Red",
                                                     "Yellow", "Blue"), selected = "Green"),
                            actionButton("update1", "Zaktualizuj dane"),
                            width = 3
                          ),
                        
                        mainPanel(
                          
                          
                          plotOutput("hist")
                          
                        )
                        
               )),
               tabPanel("Wykres pudelkowy",
                        titlePanel(h1("Wykres pudelkowy", align = "center")),
                        
                        sidebarLayout(
                          
                          sidebarPanel(
                            selectInput("datasets2", "Wybierz dane:",
                                        choices = c("Wskaznik_HDI", "PKB_na_mieszkanca", "Wspolczynnik_Giniego", "Smiertelnosc_niemowlat", "Ogolne_szczescie")),
                           
                            radioButtons("colour2", label = "Wybierz kolor wykresu pudelkowego",
                                         choices = c("Green", "Red",
                                                     "Yellow", "Blue"), selected = "Green"),
                            actionButton("update2", "Zaktualizuj dane"),
                            width = 3
                          ),
                        
                          
                          mainPanel(
                            
                            plotOutput("boxplot")
                          
                          )
                          
                        )),
               
               tabPanel("Wykres slupkowy",
                        titlePanel(h1("Wykres slupkowy", align = "center")),
                        
                        sidebarLayout(
                          
                          sidebarPanel(
                            selectInput("datasets3", "Wybierz dane:",
                                        choices = c("Wskaznik_HDI", "PKB_na_mieszkanca", "Wspolczynnik_Giniego", "Smiertelnosc_niemowlat", "Ogolne_szczescie")),
                            # uiOutput("target_var"),
                            selectInput("var3", "Wybierz kolumny:",
                                        choices = c("rok.2012"=1,"rok.2013"=2,"rok.2014"=3,"rok.2015"=4, 
                                                    "rok.2016"=5, "rok.2017"=6, "rok.2018"=7, "rok.2019"=8, 
                                                    "rok.2020"=9, "rok.2021"=10)),
                            radioButtons("colour3", label = "Wybierz kolor wykresu pudelkowego",
                                         choices = c("Green", "Red",
                                                     "Yellow", "Blue"), selected = "Green"),
                            actionButton("update3", "Zaktualizuj dane"),
                            width = 3
                          ),
                          
                          
                          mainPanel(
                            
                            plotOutput("barplot")
                            
                          )
    ))
             
             
)))

server <- function(input, output) {
  
  #================================================== Dane ========================================================
  
  output$mytable1 <- DT::renderDataTable({
    DT::datatable(Wskaznik_HDI[, input$show_vars1, drop = FALSE],                        # choose columns to display
                  options = list(lengthMenu = c(10, 20, 30, 40), pageLength = 10))  # customize the length drop-down menu;
  })

  output$mytable2 <- DT::renderDataTable({
    DT::datatable(PKB_na_mieszkanca[, input$show_vars2, drop = FALSE], 
                  options = list(lengthMenu = c(10, 20, 30, 40), pageLength = 10))
  })
  
  output$mytable3 <- DT::renderDataTable({
    DT::datatable(Wspolczynnik_Giniego[, input$show_vars3, drop = FALSE], 
                  options = list(lengthMenu = c(10,20, 30, 40), pageLength = 10)) 
  })
  
  output$mytable4 <- DT::renderDataTable({
    DT::datatable(Smiertelnosc_niemowlat[, input$show_vars4, drop = FALSE], 
                  options = list(lengthMenu = c(10,20,30,40, 50), pageLength = 10))
  })
  
  output$mytable5 <- DT::renderDataTable({
    DT::datatable(Ogolne_szczescie[, input$show_vars5, drop = FALSE], 
                  options = list(lengthMenu = c(10,20, 30, 40), pageLength = 10))
  })
  
  #============================================== Podstawowe statystyki =======================================

  
  datasetInput <- eventReactive(input$update, {
    switch(input$datasets,
           "Wskaznik_HDI" = Wskaznik_HDI,
           "PKB_na_mieszkanca" = PKB_na_mieszkanca,
           "Wspolczynnik_Giniego" = Wspolczynnik_Giniego,
           "Smiertelnosc_niemowlat" = Smiertelnosc_niemowlat,
           "Ogolne_szczescie" = Ogolne_szczescie
           )
  }, ignoreNULL = FALSE)
  
  
  output$summary <- renderPrint({
    datasets <- datasetInput()
    datasets <- na.omit(datasets)
    datasets_val <- datasets[,c(2:ncol(datasets))]
    summary(datasets_val)
  })
  
  output$view <- renderTable({
    head(datasetInput(), n = isolate(input$obs))
  })
  
  
  #============================================== Wykresy =======================================
  
  #Histogram 
  
  datasetInput1 <- eventReactive(input$update1, {
    switch(input$datasets1,
           "Wskaznik_HDI" = Wskaznik_HDI,
           "PKB_na_mieszkanca" = PKB_na_mieszkanca,
           "Wspolczynnik_Giniego" = Wspolczynnik_Giniego,
           "Smiertelnosc_niemowlat" = Smiertelnosc_niemowlat,
           "Ogolne_szczescie" = Ogolne_szczescie_2012_2019
    )
  }, ignoreNULL = FALSE)
  
  
  output$text1 <- renderText({ 
    colm = as.numeric(input$var1)
    paste("Data set variable/column name is", names(datasets1[colm]))
    
  })
  
  output$text2 <- renderText({ 
    paste("Color of histogram is", input$radio)
  })
  
  output$text3 <- renderText({ 
    paste("Number of histogram BINs is", input$bin)
  })
  
  output$hist <- renderPlot({
    datasets1 <- datasetInput1()
    datasets1 <- na.omit(datasets1)
    datasets1_val <- datasets1[,c(2:ncol(datasets1))]
    colm =as.numeric(input$var1)
    
    # GGPLOT2
    
    # datasets1_val %>%
    #   ggplot( aes(x=datasets1_val[,colm])) +                                            
    #   geom_histogram( breaks =seq(0, max(datasets1_val[,colm]),l=input$bin+1), 
    #                   fill=input$colour1, color="black", alpha=0.7) +
    #   xlab(names(datasets1_val[colm]))  +
    #   xlim(c(0, max(datasets1_val[,colm]))) +
    #   ggtitle("Histogram") +
    #   theme_minimal()
    
    
    hist(datasets1_val[,colm], col =input$colour1,
         xlim = c(0, max(datasets1_val[,colm])),
         main = "Histogram",
         breaks = seq(0, max(datasets1_val[,colm]),l=input$bin+1),
         xlab = names(datasets1_val[colm]))
    
    }, height=600, width=1100)  
  
  
  
  #========= Wykres pudelkowy ==================================
  
  datasetInput2 <- eventReactive(input$update2, {
    switch(input$datasets2,
           "Wskaznik_HDI" = Wskaznik_HDI,
           "PKB_na_mieszkanca" = PKB_na_mieszkanca,
           "Wspolczynnik_Giniego" = Wspolczynnik_Giniego,
           "Smiertelnosc_niemowlat" = Smiertelnosc_niemowlat,
           "Ogolne_szczescie" = Ogolne_szczescie
    )
  }, ignoreNULL = FALSE)

  

  output$boxplot <- renderPlot({
    datasets2 <- datasetInput2()
    datasets2 <- na.omit(datasets2)
    datasets2_val <- datasets2[,c(2:ncol(datasets2))]
    
  
    boxplot(datasets2_val,col =input$colour2,  main = "Wykres pudelkowy")

  }, height=600, width=1100)
  
  
  

  datasetInput3 <- eventReactive(input$update3, {
    switch(input$datasets3,
           "Wskaznik_HDI" = Wskaznik_HDI,
           "PKB_na_mieszkanca" = PKB_na_mieszkanca,
           "Wspolczynnik_Giniego" = Wspolczynnik_Giniego,
           "Smiertelnosc_niemowlat" = Smiertelnosc_niemowlat,
           "Ogolne_szczescie" = Ogolne_szczescie_2012_2019
    )
  }, ignoreNULL = FALSE)
  
  output$barplot <- renderPlot({
    datasets3 <- datasetInput3()
    datasets3 <- na.omit(datasets3)
    datasets3_val <- datasets3[,c(2:ncol(datasets3))]
    colm3 =as.numeric(input$var3)
    datasets3_val <- datasets3_val[order(datasets3_val[,colm3], decreasing = F),] 
  
    barplot(height=datasets3_val[,colm3], names=datasets3$region,space=0,
            col=input$colour3,
            horiz=T, las=1
    )
    
  },height=800, width=1100)
  
  # output$target_var <- renderUI({
  #   req(datasetInput3())
  #   selectInput("v_target", "Wybierz zmienna:", choices = colnames(datasetInput3()))
  # })
  
}


shinyApp(ui, server)