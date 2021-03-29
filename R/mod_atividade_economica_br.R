#' atividade_economica_br UI Function
#'
#' @description Modulo da atividade economica nacional.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @import bs4Dash
#' @import magrittr
#' @import plotly



mod_atividade_economica_ui <- function(id) {
  ns <- NS(id)
  tagList(
    fluidPage(
      fluidRow(

        # Resenha
        box(
          title = tags$div("ATIVIDADE ECONÔMICA", class = "res-tit"),
          closable = FALSE,
          width = 4,
          height = 760,
          status = NULL,
          background = "yellow",
          solidHeader = TRUE,
          enable_dropdown = FALSE,
          tags$div(
            class = "res-body",
            p("A previsão do mercado financeiro para a queda da economia brasileira este ano foi ajustada de 5,46% para 5,28%. Para o próximo ano, a expectativa é de crescimento de 3,50%, a mesma previsão há 14 semanas consecutivas. Em 2022 e 2023, o mercado financeiro continua a projetar expansão de 2,50% do PIB."),
            p("O indice de Atividade Economica do Banco Central (IBC-Br) que, com cautela, pode ser utilizado como sinalizador do Produto Interno Bruto (PIB), apresentou avanco de 0,02 por cento em outubro na comparacao com o mes anterior, de acordo com dado dessazonalizado divulgado BC."),
            p("O desempenho foi melhor que a expectativa em pesquisa da Reuters de contracao de 0,20 por cento, representando o quinto resultado positivo no ano.")
          )
        ),

        # Variação do PIB
        box(
          title = tags$div("Produto Interno Bruto", class = "box-tit"),
          closable = FALSE,
          width = 4,
          height = 760,
          status = "warning",
          solidHeader = TRUE,
          tags$div("Crescimento do PIB", class = "box-subtit"),
          tags$div("Variação % anual real", class = "box-body"),
          plotlyOutput(ns("plot1")),
          tags$div("Fonte: IBGE", style = "box-legenda"),
          tags$div("O resultado positivo de 2017 sinaliza o encerramento do período recessivo e início da retomada da economia.", style = "box-body"),
          footer = fluidRow(
            column(
              width = 12,
              descriptionBlock(
                number = paste(round(
                  tail(series$PIBvar$value, 1), 2
                ), "%"),
                numberColor = if (tail(series$PIBvar$value, 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (tail(series$PIBvar$value, 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = NULL,
                text = "var. % PIB",
                rightBorder = FALSE,
                marginBottom = FALSE
              )
            )
          )
        ),

        # PIB trimestral
        box(
          title = tags$div("Produto Interno Bruto", class = "box-tit"),
          closable = FALSE,
          width = 4,
          height = 760,
          status = "warning",
          solidHeader = TRUE,
          tags$div("Crescimento do PIB", class = "box-subtit"),
          tags$div("Índice trimestral, valores observados a preço de mercado", class = "box-body"),
          plotlyOutput(ns("plot2")),
          tags$div("Fonte: IBGE", class = "box-legenda"),
          footer = fluidRow(
            column(
              width = 6,
              descriptionBlock(
                number = paste(round(
                  tail(series$PIBtriobs$value, 1) - head(tail(series$PIBtriobs$value, 2), 1), 2
                ), "pts"),
                numberColor = if (tail(series$PIBtriobs$value, 1) - head(tail(series$PIBtriobs$value, 2), 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (tail(series$PIBtriobs$value, 1) - head(tail(series$PIBtriobs$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste(tail(series$PIBtriobs$value, 1), tail(months(series$PIBtriobs$date), 1)),
                text = "PIB",
                rightBorder = TRUE,
                marginBottom = FALSE
              )
            ),
            column(
              width = 6,
              descriptionBlock(
                number = paste(round(
                  tail(series$PIBtri$value, 1) - head(tail(series$PIBtri$value, 2), 1), 2
                ), "pts"),
                numberColor = if (tail(series$PIBtri$value, 1) - head(tail(series$PIBtri$value, 2), 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (tail(series$PIBtri$value, 1) - head(tail(series$PIBtri$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste(tail(series$PIBtri$value, 1), tail(months(series$PIBtri$date), 1)),
                text = "PIB Dessazonalizado",
                rightBorder = FALSE,
                marginBottom = FALSE
              )
            )
          )
        ),

        # IBC-Br
        box(
          title = tags$div("IBC-Br", class = "box-tit"),
          closable = FALSE,
          width = 4,
          height = 760,
          status = "warning",
          solidHeader = TRUE,
          tags$div("Índice de Atividade Econômica", class = "box-subtit"),
          tags$div("Índice mensal observado e dessazonalizado", class = "box-body"),
          plotlyOutput(ns("plot3")),
          tags$div("Fonte: Banco Central do Brasil", class = "box-legenda"),
          footer = fluidRow(
            column(
              width = 6,
              descriptionBlock(
                number = paste(round(
                  tail(series$IBCBr$value, 1) - head(tail(series$IBCBr$value, 2), 1), 2
                ), "pts"),
                numberColor = if (tail(series$IBCBr$value, 1) - head(tail(series$IBCBr$value, 2), 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (tail(series$IBCBr$value, 1) - head(tail(series$IBCBr$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste(tail(series$IBCBr$value, 1), tail(months(series$IBCBr$date), 1)),
                text = "IBC-Br",
                rightBorder = TRUE,
                marginBottom = FALSE
              )
            ), column(
              width = 6,
              descriptionBlock(
                number = paste(round(
                  tail(series$IBCBrs$value, 1) - head(tail(series$IBCBrs$value, 2), 1), 2
                ), "pts"),
                numberColor = if (tail(series$IBCBrs$value, 1) - head(tail(series$IBCBrs$value, 2), 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (tail(series$IBCBrs$value, 1) - head(tail(series$IBCBrs$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste(tail(series$IBCBrs$value, 1), tail(months(series$IBCBrs$date), 1)),
                text = "IBC-Br Dessazonalizado",
                rightBorder = FALSE,
                marginBottom = FALSE
              )
            )
          )
        ),

        # Varejo e Serviços
        box(
          title = tags$div("Varejo e Serviços", class = "box-tit"),
          closable = FALSE,
          width = 4,
          height = 760,
          status = "warning",
          solidHeader = TRUE,
          tags$div("Índice mensal de varejo e serviços", class = "box-subtit"),
          tags$div("Volume de vendas no varejo e receita nominal de serviços", class = "box-body"),
          plotlyOutput(ns("plot4")),
          tags$div("Fonte: IBGE", class = "box-legenda"),
          footer = fluidRow(
            column(
              width = 6,
              descriptionBlock(
                number = paste(round(
                  tail(series$Varejo$value, 1) - head(tail(series$Varejo$value, 2), 1), 2
                ), "pts"),
                numberColor = if (tail(series$Varejo$value, 1) - head(tail(series$Varejo$value, 2), 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (tail(series$Varejo$value, 1) - head(tail(series$Varejo$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste(tail(series$Varejo$value, 1), tail(months(series$Varejo$date), 1)),
                text = "Varejo",
                rightBorder = TRUE,
                marginBottom = FALSE
              )
            ), column(
              width = 6,
              descriptionBlock(
                number = paste(round(
                  tail(series$Servicos$value, 1) - head(tail(series$Servicos$value, 2), 1), 2
                ), "pts"),
                numberColor = if (tail(series$Servicos$value, 1) - head(tail(series$Servicos$value, 2), 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (tail(series$Servicos$value, 1) - head(tail(series$Servicos$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste(tail(series$Servicos$value, 1), tail(months(series$Servicos$date), 1)),
                text = "Serviços",
                rightBorder = FALSE,
                marginBottom = FALSE
              )
            )
          )
        ),

        # Exportações
        box(
          title = tags$div("Exportação de Bens", class = "box-tit"),
          closable = FALSE,
          width = 4,
          height = 760,
          status = "warning",
          solidHeader = TRUE,
          tags$div("Exportações", class = "box-subtit"),
          tags$div("Em US$ bilhões, balanço de pagamentos, mensal", class = "box-body"),
          plotlyOutput(ns("plot5")),
          tags$div("Fonte: Banco Central do Brasil", class = "box-legenda"),
          footer = fluidRow(
            column(
              width = 12,
              descriptionBlock(
                number = paste("US$", round(
                  (tail(series$ExpBR$value, 1) - head(tail(series$ExpBR$value, 2), 1)) / 1000, 2
                ), "bi"),
                numberColor = if (tail(series$ExpBR$value, 1) - head(tail(series$ExpBR$value, 2), 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (tail(series$ExpBR$value, 1) - head(tail(series$ExpBR$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste("US$", round(tail(series$ExpBR$value / 1000, 1), 1), "bi", tail(months(series$ExpBR$date), 1)),
                text = "Exportações",
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

#' atividade_economica Server Function
#'
#' @noRd
mod_atividade_economica_server <- function(input, output, session) {
  ns <- session$ns

  # PIB variação anual
  output$plot1 <- renderPlotly({
    plot_ly(
      data = series$PIBvar, x = ~date, y = ~value,
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

  # PIB Trimestral
  output$plot2 <- renderPlotly({
    plot_ly(
      data = series$PIBtriobs[match(series$PIBtri$date, series$PIBtriobs$date), ],
      x = ~date, y = ~value,
      type = "scatter", mode = "lines", name = "PIB trimestral observado"
    ) %>%
      add_trace(y = series$PIBtri$value, name = "PIB trimestral dessazonalizado") %>%
      layout(
        title = "", xaxis = list(title = ""), yaxis = list(title = "Indice (1995=100)"),
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center"
        )
      )
  })

  # IBC-Br
  output$plot3 <- renderPlotly({
    plot_ly(
      data = series$IBCBr[match(series$IBCBrs$date, series$IBCBr$date), ],
      x = ~date, y = ~value,
      type = "scatter", mode = "lines", name = "IBC-Br"
    ) %>%
      add_trace(y = series$IBCBrs$value, name = "IBC-Br dessazonalizado") %>%
      layout(
        title = "", xaxis = list(title = ""), yaxis = list(title = "IBC-Br"),
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
      data = series$Varejo[match(series$Servicos$date, series$Varejo$date), ],
      x = ~date, y = ~value,
      type = "scatter", mode = "lines", name = "Varejo"
    ) %>%
      add_trace(y = series$Servicos$value, name = "Serviços") %>%
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
      data = series$ExpBR,
      x = ~date, y = ~ value / 1000,
      type = "scatter", mode = "lines", name = "ExpBr"
    ) %>%
      layout(
        title = "", xaxis = list(title = ""), yaxis = list(title = "US$ bi"),
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center"
        )
      )
  })
}

## To be copied in the UI
# mod_atividade_economica_ui("atividade_economica_ui_1")

## To be copied in the server
# callModule(mod_atividade_economica_server, "atividade_economica_ui_1")