#' inflacao UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' @import shinydashboardPlus
#' @import magrittr
#' @import plotly



mod_inflacao_ui = function(id){
  ns = NS(id)
  tagList(
 
    fluidPage(
      fluidRow(
        
        # Resenha
        boxPlus(title = tags$b("INFLAÇÃO", style = ''),
                closable = FALSE, 
                width = 4,
                height = 855,
                status = NULL,
                background = "red",
                solidHeader = TRUE,
                collapsible = FALSE,
                enable_dropdown = FALSE,
                h4(style = 'text-align: justify;',
                   "O Índice Nacional de Preços ao Consumidor Amplo (IPCA) teve queda de 0,21% em novembro, conforme divulgado pelo IBGE. O resultado foi o menor desde julho de 2017, quando houve queda de 0,23%. Entre os meses de novembro, a queda é a menor desde o início do Plano Real em 1994. Em 12 meses, a inflação acumula 4,05% enquanto a taxa acumulada de 2018 é de 3,59%.",
                   br(),br(),
                   "A comportamento brando dos índices de inflação é essencial para a recuperação do consumo das famílias e do crédito, uma vez que os últimos dados mostram contração da renda média familiar durante o período de recessão.",
                   br(),br(),
                   "Para 2019, os economistas das instituições financeiras diminuíram a expectativa de inflação de 4,03% para 4,01%. A meta central do próximo ano é de 4,25%, e o intervalo de tolerância do sistema de metas varia de 2,75% a 5,75%."
                )),
        
        # Inflação
        boxPlus(
          title = tags$b("Inflação", style = ''),
          closable = FALSE, 
          width = 4,
          height = 855,
          status = "danger", 
          solidHeader = TRUE, 
          tags$b("Índices de preços", style = 'text-align: left; font-size: 18px; color: #808080;'),
          tags$p("Variação percentual, mensal", style = 'text-align: left; font-size: 14px; color: #808080;'),
          plotlyOutput(ns("plot1")),
          tags$p("Fonte: IBGE, FGV e DIEESE", style = 'text-align: left; font-size: 12px; color: #808080;'),
          footer = fluidRow(
            column(
              width = 6,
              descriptionBlock(
                number = paste(round(
                  tail(series$IPCA$value,1)-head(tail(series$IPCA$value, 2), 1), 2), "pts"), 
                numberColor = if(tail(series$IPCA$value,1) - head(tail(series$IPCA$value, 2), 1) >= 0) {"red"} else {"green"}, 
                numberIcon = if(tail(series$IPCA$value,1) - head(tail(series$IPCA$value, 2), 1) >= 0) {"fas fa-caret-up"} else {"fas fa-caret-down"},
                header = paste(tail(series$IPCA$value,1), tail(months(series$IPCA$date),1)), 
                text = "IPCA", 
                rightBorder = TRUE,
                marginBottom = FALSE
              )
            ), column(
              width = 6,
              descriptionBlock(
                number = paste(round(
                  tail(series$IGPM$value,1)-head(tail(series$IGPM$value, 2), 1), 2), "pts"), 
                numberColor = if(tail(series$IGPM$value,1) - head(tail(series$IGPM$value, 2), 1) >= 0) {"red"} else {"green"}, 
                numberIcon = if(tail(series$IGPM$value,1) - head(tail(series$IGPM$value, 2), 1) >= 0) {"fas fa-caret-up"} else {"fas fa-caret-down"},
                header = paste(tail(series$IGPM$value,1), tail(months(series$IGPM$date),1)), 
                text = "IGPM", 
                rightBorder = TRUE,
                marginBottom = FALSE
              )
            )
          ),
          fluidRow(
            column(
              width = 6,
              descriptionBlock(
                number = paste(round(
                  tail(series$IPCBr$value,1)-head(tail(series$IPCBr$value, 2), 1), 2), "pts"), 
                numberColor = if(tail(series$IPCBr$value,1) - head(tail(series$IPCBr$value, 2), 1) >= 0) {"red"} else {"green"}, 
                numberIcon = if(tail(series$IPCBr$value,1) - head(tail(series$IPCBr$value, 2), 1) >= 0) {"fas fa-caret-up"} else {"fas fa-caret-down"},
                header = paste(tail(series$IPCBr$value,1), tail(months(series$IPCBr$date),1)), 
                text = "IPCBr", 
                rightBorder = TRUE,
                marginBottom = FALSE
              )
            ), column(
              width = 6,
              descriptionBlock(
                number = paste(round(
                  tail(series$ICV$value,1)-head(tail(series$ICV$value, 2), 1), 2), "pts"), 
                numberColor = if(tail(series$ICV$value,1) - head(tail(series$ICV$value, 2), 1) >= 0) {"red"} else {"green"}, 
                numberIcon = if(tail(series$ICV$value,1) - head(tail(series$ICV$value, 2), 1) >= 0) {"fas fa-caret-up"} else {"fas fa-caret-down"},
                header = paste(tail(series$ICV$value,1), tail(months(series$ICV$date),1)), 
                text = "ICV", 
                rightBorder = TRUE,
                marginBottom = FALSE)))),
        
        # Cesta Básica Vitória
          boxPlus(
            title = tags$b("Cesta Básica", style = ''),
            closable = FALSE, 
            width = 4,
            height = 855,
            status = "danger", 
            solidHeader = TRUE, 
            collapsible = FALSE,
            enable_dropdown = FALSE,
            tags$b("Custo da Cesta Básica", style = 'text-align: left; font-size: 18px; color: #808080;'),
            tags$p("Vitória-ES, índice, mensal", style = 'text-align: left; font-size: 14px; color: #808080;'),
            plotlyOutput(ns("plot2")),
            tags$p("Fonte: DIEESE", style = 'text-align: left; font-size: 12px; color: #808080;'),
            footer = fluidRow(
              column(
                width = 12,
                descriptionBlock(
                  number = paste(round(
                    tail(series$CestaES$value,1)-head(tail(series$CestaES$value, 2), 1), 2), "pts."), 
                  numberColor = if(tail(series$CestaES$value,1) - head(tail(series$CestaES$value, 2), 1) >= 0) {"red"} else {"green"}, 
                  numberIcon = if(tail(series$CestaES$value,1) - head(tail(series$CestaES$value, 2), 1) >= 0) {"fas fa-caret-up"} else {"fas fa-caret-down"},
                  header = paste(tail(series$CestaES$value,1), "pts.", tail(months(series$CestaES$date),1)), 
                  text = "Cesta Básica", 
                  rightBorder = TRUE,
                  marginBottom = FALSE))))
      )
    )
  )
}

  
#' inflacao Server Function
#'
#' @noRd 
mod_inflacao_server <- function(input, output, session){
  ns = session$ns
  
  # Inflação
  output$plot1 = renderPlotly({
    
    plot_ly(data = series$IPCA, x = ~date, y = ~value,
            type = "scatter", mode = "lines", name = "IPCA") %>%
      add_trace(series$IGPM, x = series$IGPM$date, y = series$IGPM$value, name = "IGPM", mode = "lines") %>%
      add_trace(series$IPCBr, x = series$IPCBr$date, y = series$IPCBr$value, name = "IPCBr", mode = "lines") %>%
      add_trace(series$ICV, x = series$ICV$date, y = series$ICV$value, name = "ICV", mode = "lines") %>%
      layout(title = "", xaxis = list(title = ""), yaxis = list(title = 'Variação %'),
             legend = list(orientation = 'h',
                           x = 0.5,
                           xanchor = "center"))
  })
 
  
  output$plot2 = renderPlotly({
    
    plot_ly(data = series$CestaES, x=~date, y=~value,
            type = "scatter", mode = "lines", name = "Cesta Básica Vitória") %>%
      layout(title = "", xaxis = list(title = ""), yaxis = list(title = "Indice"),
             legend = list(orientation = 'h',
                           x = 0.5,
                           xanchor = "center"))
  })
  
  
}
    
## To be copied in the UI
# mod_inflacao_ui("inflacao_ui_1")
    
## To be copied in the server
# callModule(mod_inflacao_server, "inflacao_ui_1")
 
