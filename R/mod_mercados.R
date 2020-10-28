#' mercados UI Function
#'
#' @description Modulo de mercados.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList
#' @import shinydashboardPlus
#' @import magrittr
#' @import plotly



mod_mercados_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidPage(
      fluidRow(
        
        # Resenha
        boxPlus(title = tags$b("MERCADOS", style = 'font-family: "Georgia"'),
                closable = FALSE, 
                width = 4,
                height = 700,
                status = NULL,
                background = "light-blue",
                solidHeader = TRUE,
                h4(style = 'text-align: justify; font-family: "Georgia";',
                   "Para 2019, é esperado um aumento dos juros, motivado por uma provável recuperação da economia. Na média, os analistas do mercado financeiro esperam que a Selic feche o próximo ano em 7,5%.",
                   br(),br(),
                   "No mercado de trabalho, a taxa de desemprego no Brasil recuou para 11,6% no trimestre encerrado em novembro, segundo dados divulgados pelo IBGE, se mantendo praticamente constante — caiu 0,1% em relação ao mês anterior. Não obstante, o sinal é positivo pois foi a oitava queda mensal consecutiva no país."
                )),
        
        # Selic
        boxPlus(
          title = tags$b("Juros", style = 'font-family: "Georgia"'),
          closable = FALSE, 
          width = 4,
          height = 700,
          status = "primary", 
          solidHeader = TRUE, 
          tags$b("Taxa básica Selic", style = 'text-align: left; font-family: "Georgia"; font-size: 18px; color: #808080;'),
          tags$p("Taxa ao ano, diária, anualizada, base 252", style = 'text-align: left; font-family: "Georgia"; font-size: 14px; color: #808080;'),
          plotlyOutput(ns("plot1")),
          tags$p("Fonte: Banco Central do Brasil", style = 'text-align: left; font-family: "Georgia"; font-size: 12px; color: #808080;'),
          footer = fluidRow(
            column(
              width = 12,
              descriptionBlock(
                number = paste(round(
                  tail(series$Selic$value,1)-head(tail(series$Selic$value, 2), 1), 2), "%"), 
                numberColor = if(tail(series$Selic$value,1)-head(tail(series$Selic$value, 2), 1) >= 0) {"red"} else {"green"}, 
                numberIcon = if(tail(series$Selic$value,1)-head(tail(series$Selic$value, 2), 1) >= 0) {"fas fa-caret-up"} else {"fas fa-caret-down"},
                header = paste(tail(series$Selic$value,1), "%", tail(months(series$Selic$date),1)), 
                text = "Selic", 
                rightBorder = TRUE,
                marginBottom = FALSE
              )))),
        
        # Dolar
        boxPlus(
          title = tags$b("Taxa de Câmbio", style = 'font-family: "Georgia"'),
          closable = FALSE, 
          width = 4,
          height = 700,
          status = "primary", 
          solidHeader = TRUE, 
          tags$b("Dólar", style = 'text-align: left; font-family: "Georgia"; font-size: 18px; color: #808080;'),
          tags$p("Preço de compra, cotação diária", style = 'text-align: left; font-family: "Georgia"; font-size: 14px; color: #808080;'),
          plotlyOutput(ns("plot2")),
          tags$p("Fonte: Banco Central do Brasil", style = 'text-align: left; font-family: "Georgia"; font-size: 12px; color: #808080;'),
          footer = fluidRow(
            column(
              width = 12,
              descriptionBlock(
                number = paste('R$',round(
                  tail(series$Dolar$value,1)-head(tail(series$Dolar$value, 2), 1), 2), "/US$"), 
                numberColor = if(tail(series$Dolar$value,1)-head(tail(series$Dolar$value, 2), 1) >= 0) {"red"} else {"green"}, 
                numberIcon = if(tail(series$Dolar$value,1)-head(tail(series$Dolar$value, 2), 1) >= 0) {"fas fa-caret-up"} else {"fas fa-caret-down"},
                header = paste('R$',round(tail(series$Dolar$value,1),2), "/US$",tail(months(series$Dolar$date),1)), 
                text = "Dolar", 
                rightBorder = TRUE,
                marginBottom = FALSE
              )))),
        
        # Mercado de Trabalho
        boxPlus(
          title = tags$b("Mercado de Trabalho", style = 'font-family: "Georgia"'),
          closable = FALSE, 
          width = 4,
          height = 700,
          status = "primary", 
          solidHeader = TRUE, 
          collapsible = FALSE,
          enable_dropdown = FALSE,
          tags$b("Taxa de desemprego", style = 'text-align: left; font-family: "Georgia"; font-size: 18px; color: #808080;'),
          tags$p("Percentual da população economicamente ativa, mensal", style = 'text-align: left; font-family: "Georgia"; font-size: 14px; color: #808080;'),
          plotlyOutput(ns("plot3")),
          tags$p("Fonte: IBGE", style = 'text-align: left; font-family: "Georgia"; font-size: 12px; color: #808080;'),
          footer = fluidRow(
            column(
              width = 12,
              descriptionBlock(
                number = paste(round(
                  tail(series$Desemprego$value,1)-head(tail(series$Desemprego$value, 2), 1), 2), "%"), 
                numberColor = if(tail(series$Desemprego$value,1)-head(tail(series$Desemprego$value, 2), 1) >= 0) {"red"} else {"green"}, 
                numberIcon = if(tail(series$Desemprego$value,1)-head(tail(series$Desemprego$value, 2), 1) >= 0) {"fas fa-caret-up"} else {"fas fa-caret-down"},
                header = paste(tail(series$Desemprego$value,1), "%", tail(months(series$Desemprego$date),1)), 
                text = "Desemprego", 
                rightBorder = TRUE,
                marginBottom = FALSE
              )
            )
          )
        ),
        
        # Emprego ES
        boxPlus(
          title = tags$b("Mercado de Trabalho ES", style = 'font-family: "Georgia"'),
          closable = FALSE, 
          width = 4,
          height = 700,
          status = "primary", 
          solidHeader = TRUE, 
          collapsible = FALSE,
          enable_dropdown = FALSE,
          tags$b("Taxa de Ocupação", style = 'text-align: left; font-family: "Georgia"; font-size: 18px; color: #808080;'),
          tags$p("Índice, população economciamente ativa, mensal", style = 'text-align: left; font-family: "Georgia"; font-size: 14px; color: #808080;'),
          plotlyOutput(ns("plot4")),
          tags$p("Fonte: MTE", style = 'text-align: left; font-family: "Georgia"; font-size: 12px; color: #808080;'),
          footer = fluidRow(
            column(
              width = 12,
              descriptionBlock(
                number = paste(round(
                  tail(series$EmpregoGES$value,1)-head(tail(series$EmpregoGES$value, 2), 1), 2), "unidades"), 
                numberColor = if(tail(series$EmpregoGES$value,1)-head(tail(series$EmpregoGES$value, 2), 1) >= 0) {"green"} else {"red"}, 
                numberIcon = if(tail(series$EmpregoGES$value,1)-head(tail(series$EmpregoGES$value, 2), 1) >= 0) {"fas fa-caret-up"} else {"fas fa-caret-down"},
                header = paste(tail(series$EmpregoGES$value,1), "unidades", tail(months(series$EmpregoGES$date),1)), 
                text = "Emprego Formal ES", 
                rightBorder = TRUE,
                marginBottom = FALSE
              ))))
        
      )
    )
  )
}


    
#' mercados Server Function
#'
#' @noRd 
mod_mercados_server <- function(input, output, session){
  ns <- session$ns
 
  # Selic
  output$plot1 = renderPlotly({
    plot_ly(data = series$Selic, x = ~date, y = ~value,
            type = "scatter", mode = "lines", name = "Selic") %>%
      layout(title = "", xaxis = list(title = ""), yaxis = list(title = "% a.a."),
             legend = list(orientation = 'h',
                           x = 0.5,
                           xanchor = "center")
      )
  })
  
  # Dolar
  output$plot2 = renderPlotly({
    plot_ly(data = subset(series$Dolar, date > "2000-01-01"), x = ~date, y = ~value,
            type = "scatter", mode = "lines", name = "Dolar") %>%
      layout(title = "", xaxis = list(title = ""), yaxis = list(title = "R$/US$"),
             legend = list(orientation = 'h',
                           x = 0.5,
                           xanchor = "center")
      )
  })
  
  # Mercado de Trabalho
  output$plot3 = renderPlotly({
    plot_ly(data = series$Desemprego, x = ~date, y = ~value,
            type = "scatter", mode = "lines", name = "Desemprego") %>%
      layout(title = "", xaxis = list(title = ""), yaxis = list(title = "%"),
             legend = list(orientation = 'h',
                           x = 0.5,
                           xanchor = "center")
      )
  })
  
  # Mercado de Trabalho ES
  output$plot4 = renderPlotly({
    plot_ly(data = series$EmpregoGES, x = ~date, y = ~value,
            type = "scatter", mode = "lines", name = "Emprego Gerado") %>%
      layout(title = "", xaxis = list(title = ""), yaxis = list(title = "unidades"),
             legend = list(orientation = 'h',
                           x = 0.5,
                           xanchor = "center")
      )
  })
  
}
    
## To be copied in the UI
# mod_mercados_ui("mercados_ui_1")
    
## To be copied in the server
# callModule(mod_mercados_server, "mercados_ui_1")
 
