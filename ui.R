

shinyUI(
  #navbarPage("myTinyShinys",inverse=TRUE,collapsable=TRUE,#theme="simplex.min.css", completely threw layout so will defer
             navbarPage("myTinyShinys",id="brand",inverse=TRUE,theme = shinytheme("cosmo"),collapsable=TRUE,             
             tabPanel("Front",
                      fluidRow(
                        column(4,
                               h4("Sports"),
                               includeMarkdown("about.md"),
                               br(),
                               tags$body(includeScript("twitter.js"),
                                         tags$link(rel = 'stylesheet', type = 'text/css', href = 'styles.css'),
                                         
                                         a("Fun", class="twitter-timeline",
                                           href="https://twitter.com/pssGuy/timelines/530063221781049344",
                                           "data-widget-id" = "530064031885709312",
                                           "data-chrome" ="nofooter transparent noheader"))
                        ),
                        
                        column(4,
                               
                               
                               includeMarkdown("frontPage.md")
                               
                        ),
                        
                        
                        column(4,
                               h4("? Some routine or chage layout")
                               
                               
                        )
                        
                      )),
             
             tabPanel("Cricket",
                      tabsetPanel("Panel 1.x",
                                  tabPanel("Test Batting",
                                           selectInput("testBatsman","Select or Type Name",playerChoices,selected="MC Cowdrey"),
                                           ggvisOutput("testBatPlTLGraph")
                                           ),
                                                   
                                           
                                           
                                  tabPanel("Test Batting Firsts",
                                           inputPanel(
                                           selectInput("team1","Team For",teamChoices_All),
                                           selectInput("team2","Team Against",teamChoices_All)
                                          ),
                                           dataTableOutput("testBatFirsts"))
                                           
                                           
                                          
                      )
                      
                      
             ),
            
             tabPanel("MLB",
                      tabsetPanel("Panel 1.x",
                                  tabPanel("a"),
                                  
                                  
                                  
                                  tabPanel("b")
                                  
                                  
                                  
                      )
                      
                      
             ),
             
             tabPanel("NBA",
                     
             ),           
             
             tabPanel("miniApps",
                      tags$iframe(src="https://pssguy.shinyapps.io/sportsBlog/blog.Rmd", width = "1000", height="600",frameborder=0, seamless="seamless")
             ),
             navbarMenu("mts Sites",
                        tabPanel(a("Premier League", href="https://mytinyshinys.shinyapps.io/premierLeague")),
                        tabPanel(a("Sports", href="https://mytinyshinys.shinyapps.io/sports")),
                        tabPanel(a("Science", href="https://mytinyshinys.shinyapps.io/science")),
                        tabPanel(a("Socio-Economic", href="https://mytinyshinys.shinyapps.io/socioEconomic")),
                        tabPanel(a("Diversions", href="https://mytinyshinys.shinyapps.io/diversions"))
                        
             )
             
             
             
  ))
