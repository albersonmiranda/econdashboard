#' atividade_economica_es UI Function
#'
#' @description Modulo atividade economica ES.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @import shinydashboardPlus
#' @import magrittr
#' @import plotly



mod_atividade_economica_es_ui <- function(id) {
  ns <- NS(id)
  tagList(
    fluidPage(
      fluidRow(

        # Resenha
        boxPlus(
          title = tags$b("ATIVIDADE ECONÔMICA ES"),
          closable = FALSE,
          width = 4,
          height = 760,
          status = NULL,
          background = "yellow",
          solidHeader = TRUE,
          collapsible = FALSE,
          h4(
            style = "text-align: justify;",
            "O Produto Interno Bruto (PIB) do Espírito Santo vem mantendo bom desempenho em 2018. Dados divulgados pelo Instituto Jones dos Santos Neves (IJSN) referentes ao terceiro trimestre de 2018 mostram que o ritmo de crescimento da economia capixaba neste ano avançou 2,3% no acumulado do ano em comparação ao mesmo período do ano anterior. O número representa mais que o dobro do resultado nacional, que ficou em 1,1% na mesma base de comparação."
          ),
          br()
        ),

        # PIB variação anual
        boxPlus(
          title = tags$b("Produto Interno Bruto ES"),
          closable = FALSE,
          width = 4,
          height = 760,
          status = "warning",
          solidHeader = TRUE,
          collapsible = FALSE,
          enable_dropdown = FALSE,
          tags$b("Crescimento do PIB ES", style = "text-align: left; font-size: 18px; color: #808080;"),
          tags$p("Variação % anual real", style = "text-align: left; font-size: 14px; color: #808080"),
          plotlyOutput(ns("plot1")),
          tags$p("Fonte: IBGE", style = "text-align: left; font-size: 12px; color: #808080"),
          tags$p("O crescimento de 4.1% indica forte retomada da economia capixaba, que vinha de dois anos de uma recessão pior do que a apresentada em 2009 após a crise do subprime.", style = "text-align: left; font-size: 14px; color: #808080"),
          footer = fluidRow(
            column(
              width = 12,
              descriptionBlock(
                number = paste(round(
                  tail(series$PIBvarES$value, 1), 2
                ), "%"),
                numberColor = if (tail(series$PIBvarES$value, 1) >= 0) {
                  "green"
                } else {
                  "red"
                },
                numberIcon = if (tail(series$PIBvarES$value, 1) >= 0) {
                  "fas fa-caret-up"
                } else {
                  "fas fa-caret-down"
                },
                header = NULL,
                text = "var. % PIB",
                rightBorder = TRUE,
                marginBottom = FALSE
              )
            )
          )
        ),

        # PIB a preços de mercado
        boxPlus(
          title = tags$b("Produto Interno Bruto ES", style = ""),
          closable = FALSE,
          width = 4,
          height = 760,
          status = "warning",
          solidHeader = TRUE,
          tags$b("Crescimento do PIB ES", style = "text-align: left; font-size: 18px; color: #808080;"),
          tags$p("Em R$, valores observados a preço de mercado", style = "text-align: left; font-size: 14px; color: #808080"),
          plotlyOutput(ns("plot2")),
          tags$p("Fonte: IBGE", style = "text-align: left; font-size: 12px; color: #808080"),
          tags$p("A economia capixaba fechou 2017 em patamar pré-2012.", style = "text-align: left; font-size: 14px; color: #808080"),
          footer = fluidRow(
            column(
              width = 12,
              descriptionBlock(
                number = paste(round(
                  ((tail(series$PIBES$value, 1) / head(tail(series$PIBES$value, 2), 1)) - 1) * 100, 2
                ), "%"),
                numberColor = if (tail(series$PIBES$value, 1) - head(tail(series$PIBES$value, 2), 1) >= 0) {
                  "green"
                } else {
                  "red"
                },
                numberIcon = if (tail(series$PIBES$value, 1) - head(tail(series$PIBES$value, 2), 1) >= 0) {
                  "fas fa-caret-up"
                } else {
                  "fas fa-caret-down"
                },
                header = paste(round(tail(series$PIBES$value, 1) / 1000000000, 2), "bi"),
                text = "PIB ES",
                rightBorder = TRUE,
                marginBottom = FALSE
              )
            )
          )
        ),

        # IBCR-ES
        boxPlus(
          title = tags$b("Indice de Atividade Economica Regional ES", style = ""),
          closable = FALSE,
          width = 4,
          height = 760,
          status = "warning",
          solidHeader = TRUE,
          tags$b("Índice de Atividade Econômica ES", style = "text-align: left; font-size: 18px; color: #808080;"),
          tags$p("Índice mensal observado e dessazonalizado", style = "text-align: left; font-size: 14px; color: #808080"),
          plotlyOutput(ns("plot3")),
          tags$p("Fonte: Banco Central do Brasil", style = "text-align: left; font-size: 12px; color: #808080"),
          footer = fluidRow(
            column(
              width = 6,
              descriptionBlock(
                number = paste(round(
                  tail(series$IBCRES$value, 1) - head(tail(series$IBCRES$value, 2), 1), 2
                ), "pts"),
                numberColor = if (tail(series$IBCRES$value, 1) - head(tail(series$IBCRES$value, 2), 1) >= 0) {
                  "green"
                } else {
                  "red"
                },
                numberIcon = if (tail(series$IBCRES$value, 1) - head(tail(series$IBCRES$value, 2), 1) >= 0) {
                  "fas fa-caret-up"
                } else {
                  "fas fa-caret-down"
                },
                header = paste(tail(series$IBCRES$value, 1), tail(months(series$IBCRES$date), 1)),
                text = "IBCRES-ES",
                rightBorder = TRUE,
                marginBottom = FALSE
              )
            ), column(
              width = 6,
              descriptionBlock(
                number = paste(round(
                  tail(series$IBCRESs$value, 1) - head(tail(series$IBCRESs$value, 2), 1), 2
                ), "pts"),
                numberColor = if (tail(series$IBCRESs$value, 1) - head(tail(series$IBCRESs$value, 2), 1) >= 0) {
                  "green"
                } else {
                  "red"
                },
                numberIcon = if (tail(series$IBCRESs$value, 1) - head(tail(series$IBCRESs$value, 2), 1) >= 0) {
                  "fas fa-caret-up"
                } else {
                  "fas fa-caret-down"
                },
                header = paste(tail(series$IBCRESs$value, 1), tail(months(series$IBCRESs$date), 1)),
                text = "IBCRES-ES Dessazonalizado",
                rightBorder = TRUE,
                marginBottom = FALSE
              )
            )
          )
        ),

        # Varejo e Serviços
        boxPlus(
          title = tags$b("Varejo e Serviços ES", style = ""),
          closable = FALSE,
          width = 4,
          height = 760,
          status = "warning",
          solidHeader = TRUE,
          tags$b("Índice mensal de varejo e serviços", style = "text-align: left; font-size: 18px; color: #808080;"),
          tags$p("Volume de vendas no varejo e receita nominal de serviços", style = "text-align: left; font-size: 14px; color: #808080"),
          plotlyOutput(ns("plot4")),
          tags$p("Fonte: IBGE", style = "text-align: left; font-size: 12px; color: #808080;"),
          tags$p("", style = "text-align: left; font-size: 14px; color: #808080;"),
          footer = fluidRow(
            column(
              width = 6,
              descriptionBlock(
                number = paste(round(
                  tail(series$VarejoES$value, 1) - head(tail(series$VarejoES$value, 2), 1), 2
                ), "pts"),
                numberColor = if (tail(series$VarejoES$value, 1) - head(tail(series$VarejoES$value, 2), 1) >= 0) {
                  "green"
                } else {
                  "red"
                },
                numberIcon = if (tail(series$VarejoES$value, 1) - head(tail(series$VarejoES$value, 2), 1) >= 0) {
                  "fas fa-caret-up"
                } else {
                  "fas fa-caret-down"
                },
                header = paste(tail(series$VarejoES$value, 1), tail(months(series$VarejoES$date), 1)),
                text = "Varejo ES",
                rightBorder = TRUE,
                marginBottom = FALSE
              )
            ), column(
              width = 6,
              descriptionBlock(
                number = paste(round(
                  tail(series$ServicosES$value, 1) - head(tail(series$ServicosES$value, 2), 1), 2
                ), "pts"),
                numberColor = if (tail(series$ServicosES$value, 1) - head(tail(series$ServicosES$value, 2), 1) >= 0) {
                  "green"
                } else {
                  "red"
                },
                numberIcon = if (tail(series$ServicosES$value, 1) - head(tail(series$ServicosES$value, 2), 1) >= 0) {
                  "fas fa-caret-up"
                } else {
                  "fas fa-caret-down"
                },
                header = paste(tail(series$ServicosES$value, 1), tail(months(series$ServicosES$date), 1)),
                text = "Serviços ES",
                rightBorder = TRUE,
                marginBottom = FALSE
              )
            )
          )
        ),

        # Exportações
        boxPlus(
          title = tags$b("Exportações ES", style = ""),
          closable = FALSE,
          width = 4,
          height = 760,
          status = "warning",
          solidHeader = TRUE,
          tags$b("Exportações", style = "text-align: left; font-size: 18px; color: #808080;"),
          tags$p("Em US$ milhões", style = "text-align: left; font-size: 14px; color: #808080;"),
          plotlyOutput(ns("plot5")),
          tags$p("Fonte: MDIC", style = "text-align: left; font-size: 12px; color: #808080;"),
          footer = fluidRow(
            column(
              width = 12,
              descriptionBlock(
                number = paste("US$", round(
                  (tail(series$ExpES$value, 1) - head(tail(series$ExpES$value, 2), 1)) / 1000, 2
                ), "mi"),
                numberColor = if (tail(series$ExpES$value, 1) - head(tail(series$ExpES$value, 2), 1) >= 0) {
                  "green"
                } else {
                  "red"
                },
                numberIcon = if (tail(series$ExpES$value, 1) - head(tail(series$ExpES$value, 2), 1) >= 0) {
                  "fa fa-caret-up"
                } else {
                  "fa fa-caret-down"
                },
                header = paste("US$", tail(series$ExpES$value / 1000, 1), "mi", tail(months(series$ExpES$date), 1)),
                text = "Exportações",
                rightBorder = TRUE,
                marginBottom = FALSE
              )
            )
          )
        )
      )
    )
  )
}

#' atividade_economica_es Server Function
#'
#' @noRd
mod_atividade_economica_es_server <- function(input, output, session) {
  ns <- session$ns

  # PIB variação anual
  output$plot1 <- renderPlotly({
    plot_ly(
      data = series$PIBvarES, x = ~date, y = ~value,
      type = "bar", name = "PIB Anual"
    ) %>%
      layout(
        title = "", xaxis = list(title = ""), yaxis = list(title = "Variação %"),
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center"
        )
      )
  })

  # PIB em R$ a preços de mercado
  output$plot2 <- renderPlotly({
    plot_ly(
      data = series$PIBES, x = ~date, y = ~value,
      type = "scatter", mode = "lines", name = "PIB ES"
    ) %>%
      layout(
        title = "", xaxis = list(title = ""), yaxis = list(title = "PIB (em R$)"),
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center"
        )
      )
  })

  # IBCR-ES
  output$plot3 <- renderPlotly({
    plot_ly(
      data = series$IBCRES[match(series$IBCRESs$date, series$IBCRES$date), ],
      x = ~date, y = ~value,
      type = "scatter", mode = "lines", name = "IBCR-ES"
    ) %>%
      add_trace(y = series$IBCRESs$value, name = "IBC-ES dessazonalizado") %>%
      layout(
        title = "", xaxis = list(title = ""), yaxis = list(title = "IBCR-ES"),
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center"
        )
      )
  })

  # Varejo e Serviços
  output$plot4 <- renderPlotly({
    plot_ly(
      data = series$VarejoES[match(series$ServicosES$date, series$VarejoES$date), ],
      x = ~date, y = ~value,
      type = "scatter", mode = "lines", name = "Varejo"
    ) %>%
      add_trace(y = series$ServicosES$value, name = "Serviços") %>%
      layout(
        title = "", xaxis = list(title = ""), yaxis = list(title = "Indice"),
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center"
        )
      )
  })

  # Exportações
  output$plot5 <- renderPlotly({
    plot_ly(
      data = series$ExpES,
      x = ~date, y = ~ value * 1000,
      type = "scatter", mode = "lines", name = "Exportações"
    ) %>%
      layout(
        title = "", xaxis = list(title = ""), yaxis = list(title = "US$ mi"),
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center"
        )
      )
  })
}

## To be copied in the UI
# mod_atividade_economica_es_ui("atividade_economica_es_ui_1")

## To be copied in the server
# callModule(mod_atividade_economica_es_server, "atividade_economica_es_ui_1")