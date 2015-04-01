all_values <- function(x) {
  print(x$id)
  if(is.null(x)) return(NULL)
  row <- df[df$id == x$id,"tt" ]
  paste0(names(row), format(row), collapse = "<br />")
}


shinyServer(function(input, output) {
  
  testBatsmanData <- reactive({
    print(input$testBatsman)
    
    allBatsIndPlayer <- data.frame(testBatting %>%
                                     filter(!is.na(Minutes)&Player==input$testBatsman) %>%
                                     select(Runs,notOut,Not.Out,Opposition,tt))
     
    df <-allBatsIndPlayer%>%
      mutate(cumRuns=cumsum(Runs),cumNotOut=cumsum(notOut),inns=row_number(),batAv=round(cumRuns/(inns-cumNotOut),2))
    df$id <- 1:nrow(df)
    print(df)
    info=list(df=df)
    # show tooltip for testBatting was outside reactive - still shows Mays
   
    
    return(info)
  })
  
  observe({
    
    df <- testBatsmanData()$df
    
    print(df$id)
     
    df %>%
      ggvis(~inns,~batAv, key := ~id) %>%
      layer_lines(stroke:="red") %>%
      layer_points(~inns,~Runs,fill=~ Opposition) %>%
      add_axis("x",title="Career Test Inning") %>%
      add_axis("y",title="Runs Scored") %>%
    
      add_tooltip(all_values, "click") %>%
      
      bind_shiny('testBatPlTLGraph')
  })
 
  output$testBatFirsts <- renderDataTable({
    
    if (input$team1=="All Countries"&input$team2=="All Countries") {
    temp <- data.frame(testBatting %>%
                         filter(!is.na(Runs)) %>% 
                         mutate(Score=paste0(Runs,asterisk)))
    }
    
    
    if (input$team1=="All Countries"&input$team2!="All Countries") {
      temp <- data.frame(testBatting %>%
                           filter(!is.na(Runs)&Opposition==input$team2) %>% 
                           mutate(Score=paste0(Runs,asterisk)))
    }
    
    if (input$team1!="All Countries"&input$team2=="All Countries") {
      temp <- data.frame(testBatting %>%
                           filter(!is.na(Runs)&Country==input$team1) %>% 
                           mutate(Score=paste0(Runs,asterisk)))
    }
    
    if (input$team1!="All Countries"&input$team2!="All Countries") {
      temp <- data.frame(testBatting %>%
                           filter(!is.na(Runs)&Country==input$team1&Opposition==input$team2) %>% 
                           mutate(Score=paste0(Runs,asterisk)))
    }
    
    temp[temp$Runs > cummax(c(-Inf, head(temp$Runs, -1))),c("Start.Date","Player","Country","Score","Opposition")]
  },options= list(paging = FALSE, searching = FALSE,info=FALSE))
  
})
