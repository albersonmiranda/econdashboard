#' mercados UI Function
#'
#' @description Modulo de mercados.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList

mod_conj_mercados_ui <- function(id) {
  ns <- NS(id)
  tagList(
    fluidPage(
      fluidRow(

        # Resenha
        box(
          title = tags$div("MERCADOS", class = "res-tit"),
          closable = FALSE,
          width = 4,
          height = 700,
          status = NULL,
          background = "yellow",
          solidHeader = TRUE,
          tags$div(
            class = "res-body",
            p("Para 2019, é esperado um aumento dos juros, motivado por uma provável recuperação da economia. Na média, os analistas do mercado financeiro esperam que a Selic feche o próximo ano em 7,5%."),
            p("No mercado de trabalho, a taxa de desemprego no Brasil recuou para 11,6% no trimestre encerrado em novembro, segundo dados divulgados pelo IBGE, se mantendo praticamente constante — caiu 0,1% em relação ao mês anterior. Não obstante, o sinal é positivo pois foi a oitava queda mensal consecutiva no país.")
          )
        ),

        # Mercado de Trabalho
        box(
          title = tags$div("Mercado de Trabalho", class = "box-tit"),
          closable = FALSE,
          width = 4,
          height = 700,
          status = "warning",
          solidHeader = TRUE,
          collapsible = FALSE,
          enable_dropdown = FALSE,
          tags$div("Taxa de desemprego", class = "box-subtit"),
          tags$div("Percentual da população economicamente ativa, mensal", class = "box-body"),
          plotlyOutput(ns("plot3")),
          tags$div("Fonte: IBGE", class = "box-legenda"),
          footer = fluidRow(
            column(
              width = 12,
              descriptionBlock(
                number = paste(round(
                  tail(series$Desemprego$value, 1) - head(tail(series$Desemprego$value, 2), 1), 2
                ), "%"),
                numberColor = if (tail(series$Desemprego$value, 1) - head(tail(series$Desemprego$value, 2), 1) >= 0) {
                  "danger"
                } else {
                  "success"
                },
                numberIcon = if (tail(series$Desemprego$value, 1) - head(tail(series$Desemprego$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste(tail(series$Desemprego$value, 1), "%", tail(months(series$Desemprego$date), 1)),
                text = "Desemprego",
                rightBorder = FALSE,
                marginBottom = FALSE
              )
            )
          )
        ),
        # Emprego ES
        box(
          title = tags$div("Mercado de Trabalho ES", class = "box-tit"),
          closable = FALSE,
          width = 4,
          height = 700,
          status = "warning",
          solidHeader = TRUE,
          collapsible = FALSE,
          enable_dropdown = FALSE,
          tags$div("Geração de emprego", class = "box-subtit"),
          tags$div("Unidades, empregos formais, mensal", class = "box-body"),
          plotlyOutput(ns("plot4")),
          tags$div("Fonte: MTE", class = "box-legenda"),
          footer = fluidRow(
            column(
              width = 12,
              descriptionBlock(
                number = paste(round(
                  tail(series$EmpregoGES$value, 1) - head(tail(series$EmpregoGES$value, 2), 1), 2
                ), "unidades"),
                numberColor = if (tail(series$EmpregoGES$value, 1) - head(tail(series$EmpregoGES$value, 2), 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (tail(series$EmpregoGES$value, 1) - head(tail(series$EmpregoGES$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste(tail(series$EmpregoGES$value, 1), "unidades", tail(months(series$EmpregoGES$date), 1)),
                text = "Emprego Formal ES",
                rightBorder = FALSE,
                marginBottom = FALSE
              )
            )
          )
        ),
        # Selic
        box(
          title = tags$div("Juros", class = "box-tit"),
          closable = FALSE,
          width = 4,
          height = 700,
          status = "warning",
          solidHeader = TRUE,
          tags$div("Taxa básica Selic", class = "box-subtit"),
          tags$div("Taxa ao ano, diária, anualizada, base 252", class = "box-body"),
          plotlyOutput(ns("plot1")),
          tags$div("Fonte: Banco Central do Brasil", class = "box-legenda"),
          footer = fluidRow(
            column(
              width = 12,
              descriptionBlock(
                number = paste(round(
                  tail(series$Selic$value, 1) - head(tail(series$Selic$value, 2), 1), 2
                ), "%"),
                numberColor = if (tail(series$Selic$value, 1) - head(tail(series$Selic$value, 2), 1) >= 0) {
                  "danger"
                } else {
                  "success"
                },
                numberIcon = if (tail(series$Selic$value, 1) - head(tail(series$Selic$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste(tail(series$Selic$value, 1), "%", tail(months(series$Selic$date), 1)),
                text = "Selic",
                rightBorder = FALSE,
                marginBottom = FALSE
              )
            )
          )
        ),
        # Dolar
        box(
          title = tags$div("Taxa de Câmbio", class = "box-tit"),
          closable = FALSE,
          width = 8,
          height = 700,
          status = "warning",
          solidHeader = TRUE,
          tags$div("Dólar", class = "box-subtit"),
          tags$div("Preço de compra, cotação diária", class = "box-body"),
          plotlyOutput(ns("plot2")),
          tags$div("Fonte: Banco Central do Brasil", class = "box-legenda"),
          footer = fluidRow(
            column(
              width = 12,
              descriptionBlock(
                number = paste("R$", round(
                  tail(series$Dolar$value, 1) - head(tail(series$Dolar$value, 2), 1), 2
                ), "/US$"),
                numberColor = if (tail(series$Dolar$value, 1) - head(tail(series$Dolar$value, 2), 1) >= 0) {
                  "danger"
                } else {
                  "success"
                },
                numberIcon = if (tail(series$Dolar$value, 1) - head(tail(series$Dolar$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste("R$", round(tail(series$Dolar$value, 1), 2), "/US$", tail(months(series$Dolar$date), 1)),
                text = "Dolar",
                rightBorder = FALSE,
                marginBottom = FALSE
              )
            )
          )
        )
      )
    )
  )
}


    
#' mercados Server Function
#'
#' @noRd
mod_conj_mercados_server <- function(input, output, session) {
  ns <- session$ns

  # Selic
  output$plot1 = renderPlotly({
    plot_ly(data = series$Selic, x = ~date, y = ~value,
            type = "scatter", mode = "lines", name = "Selic", line = list(color = "#004B8D")) %>%
      layout(title = "", xaxis = list(title = ""), yaxis = list(title = "% a.a."),
             legend = list(orientation = "h",
                           x = 0.5,
                           xanchor = "center")
      )
  })

  # Dolar
  output$plot2 = renderPlotly({
    plot_ly(data = subset(series$Dolar, date > "2000-01-01"), x = ~date, y = ~value,
            type = "scatter", mode = "lines", name = "Dolar", line = list(color = "#004B8D")) %>%
      layout(title = "", xaxis = list(title = ""), yaxis = list(title = "R$/US$"),
             legend = list(orientation = "h",
                           x = 0.5,
                           xanchor = "center")
      )
  })

  # Mercado de Trabalho
  output$plot3 = renderPlotly({
    plot_ly(data = series$Desemprego, x = ~date, y = ~value,
            type = "scatter", mode = "lines", name = "Desemprego", line = list(color = "#004B8D")) %>%
      layout(title = "", xaxis = list(title = ""), yaxis = list(title = "%"),
             legend = list(orientation = "h",
                           x = 0.5,
                           xanchor = "center")
      )
  })

  # Mercado de Trabalho ES
  output$plot4 = renderPlotly({
    plot_ly(data = series$EmpregoGES, x = ~date, y = ~value,
            type = "scatter", mode = "lines", name = "Emprego Gerado", line = list(color = "#004B8D")) %>%
      layout(title = "", xaxis = list(title = ""), yaxis = list(title = "unidades"),
             legend = list(orientation = "h",
                           x = 0.5,
                           xanchor = "center")
      )
  })

}
    
## To be copied in the UI
# mod_mercados_ui("mercados_ui_1")
    
## To be copied in the server
# callModule(mod_mercados_server, "mercados_ui_1")
