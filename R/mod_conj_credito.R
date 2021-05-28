#' credito UI Function
#'
#' @description Modulo de credito.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList

mod_conj_credito_ui <- function(id) {
  ns <- NS(id)
  tagList(
    fluidPage(
      fluidRow(

        # Resenha
        box(
          title = tags$div("CRÉDITO", class = "res-tit"),
          closable = FALSE,
          width = 4,
          height = 855,
          status = NULL,
          background = "yellow",
          solidHeader = TRUE,
          collapsible = FALSE,
          enable_dropdown = FALSE,
          tags$div(
            class = "res-body",
            p("A lenta retomada da economia e o mercado de trabalho fragilizado continuam contribuindo para desaceleração do consumo e, consequentemente, da demanda por crédito. Embora em crescimento, a demanda por crédito foi bem aquém do projetado para o trimestre, conforme a Pesquisa Trimestral de Condições de Crédito do Departamento de Estudos e Pesquisas do Banco Central, frustando as expectativas do mercado de crédito pelo segundo trimestre consecutivo."),
            p("Pelo lado da oferta, houve melhora da percepção do mercado em relação ao risco de crédito, revertendo o resultado negativo do trimestre anterior. Entretanto, a oferta também esteve abaixo da expectativa para o trimestre."),
            p("O Espírito Santo ganhou destaque em setembro, quando um estudo da Fecomercio-SP apontou Vitória como a cidade de maior endividamento das famílias entre as capitais — 49%. Embora o endividamento não seja sinônimo da inadimplência, o primeiro antecede o segundo e sua elevação representa um fator de risco a ser monitorado pelos bancos.")
          )
        ),

        # Pesquisa de Condições de Crédito
        box(
          title = tags$div("Mercado de Crédito", class = "box-tit"),
          closable = FALSE,
          width = 4,
          height = 855,
          status = "warning",
          solidHeader = TRUE,
          tags$div("Pesquisa de Condições de Crédito", class = "box-subtit"),
          tags$div("aprovações observadas, em pontos, trimestral", class = "box-body"),
          plotlyOutput(ns("plot1")),
          tags$div("Fonte: BCB-Depep", class = "box-legenda"),
          footer = fluidRow(
            column(
              width = 6,
              descriptionBlock(
                number = paste(round(
                  tail(series$PTCC_grandes$value, 1) - head(tail(series$PTCC_grandes$value, 2), 1), 2
                ), "pts"),
                numberColor = if (tail(series$PTCC_grandes$value, 1) - head(tail(series$PTCC_grandes$value, 2), 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (tail(series$PTCC_grandes$value, 1) - head(tail(series$PTCC_grandes$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste(tail(series$PTCC_grandes$value, 1), tail(months(series$PTCC_grandes$date), 1)),
                text = "grandes empresas",
                rightBorder = TRUE,
                marginBottom = FALSE
              )
            ), column(
              width = 6,
              descriptionBlock(
                number = paste(round(
                  tail(series$PTCC_mpme$value, 1) - head(tail(series$PTCC_mpme$value, 2), 1), 2
                ), "pts"),
                numberColor = if (tail(series$PTCC_mpme$value, 1) - head(tail(series$PTCC_mpme$value, 2), 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (tail(series$PTCC_mpme$value, 1) - head(tail(series$PTCC_mpme$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste(tail(series$PTCC_mpme$value, 1), tail(months(series$PTCC_mpme$date), 1)),
                text = "MPME",
                rightBorder = FALSE,
                marginBottom = FALSE
              )
            )
          ),
          fluidRow(
            column(
              width = 6,
              descriptionBlock(
                number = paste(round(
                  tail(series$PTCC_consumo$value, 1) - head(tail(series$PTCC_consumo$value, 2), 1), 2
                ), "pts"),
                numberColor = if (tail(series$PTCC_consumo$value, 1) - head(tail(series$PTCC_consumo$value, 2), 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (tail(series$PTCC_consumo$value, 1) - head(tail(series$PTCC_consumo$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste(tail(series$PTCC_consumo$value, 1), tail(months(series$PTCC_consumo$date), 1)),
                text = "consumo",
                rightBorder = TRUE,
                marginBottom = FALSE
              )
            ), column(
              width = 6,
              descriptionBlock(
                number = paste(round(
                  tail(series$PTCC_habitacao$value, 1) - head(tail(series$PTCC_habitacao$value, 2), 1), 2
                ), "pts"),
                numberColor = if (tail(series$PTCC_habitacao$value, 1) - head(tail(series$PTCC_habitacao$value, 2), 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (tail(series$PTCC_habitacao$value, 1) - head(tail(series$PTCC_habitacao$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste(tail(series$PTCC_habitacao$value, 1), tail(months(series$PTCC_habitacao$date), 1)),
                text = "MPME",
                rightBorder = FALSE,
                marginBottom = FALSE
              )
            )
          )
        ),

        # Endividamento das Famílias
        box(
          title = tags$div("Endividamento", class = "box-tit"),
          closable = FALSE,
          width = 4,
          height = 855,
          status = "warning",
          solidHeader = TRUE,
          tags$div("Nível de endividamento das famílias", class = "box-subtit"),
          tags$div("Percentual da renda familiar, mensal", class = "box-body"),
          plotlyOutput(ns("plot2")),
          tags$div("Fonte: Banco Central do Brasil", class = "box-legenda"),
          footer = fluidRow(
            column(
              width = 6,
              descriptionBlock(
                number = paste(round(
                  tail(series$End$value, 1) - head(tail(series$End$value, 2), 1), 2
                ), "%"),
                numberColor = if (tail(series$End$value, 1) - head(tail(series$End$value, 2), 1) >= 0) {
                  "danger"
                } else {
                  "success"
                },
                numberIcon = if (tail(series$End$value, 1) - head(tail(series$End$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste(tail(series$End$value, 1), tail(months(series$End$date), 1)),
                text = "Endividamento",
                rightBorder = TRUE,
                marginBottom = FALSE
              )
            ), column(
              width = 6,
              descriptionBlock(
                number = paste(round(
                  tail(series$Endi$value, 1) - head(tail(series$Endi$value, 2), 1), 2
                ), "%"),
                numberColor = if (tail(series$Endi$value, 1) - head(tail(series$Endi$value, 2), 1) >= 0) {
                  "danger"
                } else {
                  "success"
                },
                numberIcon = if (tail(series$Endi$value, 1) - head(tail(series$Endi$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste(tail(series$Endi$value, 1), tail(months(series$Endi$date), 1)),
                text = "Exceto imobiliário",
                rightBorder = FALSE,
                marginBottom = FALSE
              )
            )
          )
        ),

        # Inadimplência BR
        box(
          title = tags$div("Inadimplência BR", class = "box-tit"),
          closable = FALSE,
          width = 4,
          height = 855,
          status = "warning",
          solidHeader = TRUE,
          tags$div("Índice de Inadimplência - BR", class = "box-subtit"),
          tags$div("Percentual sobre saldo de créditos, mensal", class = "box-body"),
          plotlyOutput(ns("plot3")),
          tags$div("Fonte: Banco Central do Brasil", class = "box-legenda"),
          footer = fluidRow(
            column(
              width = 6,
              descriptionBlock(
                number = paste(round(
                  tail(series$InadBRPF$value, 1) - head(tail(series$InadBRPF$value, 2), 1), 2
                ), "%"),
                numberColor = if (tail(series$InadBRPF$value, 1) - head(tail(series$InadBRPF$value, 2), 1) >= 0) {
                  "danger"
                } else {
                  "success"
                },
                numberIcon = if (tail(series$InadBRPF$value, 1) - head(tail(series$InadBRPF$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste(tail(series$InadBRPF$value, 1), tail(months(series$InadBRPF$date), 1)),
                text = "Pessoa física",
                rightBorder = TRUE,
                marginBottom = FALSE
              )
            ), column(
              width = 6,
              descriptionBlock(
                number = paste(round(
                  tail(series$InadBRPJ$value, 1) - head(tail(series$InadBRPJ$value, 2), 1), 2
                ), "%"),
                numberColor = if (tail(series$InadBRPJ$value, 1) - head(tail(series$InadBRPJ$value, 2), 1) >= 0) {
                  "danger"
                } else {
                  "success"
                },
                numberIcon = if (tail(series$InadBRPJ$value, 1) - head(tail(series$InadBRPJ$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste(tail(series$InadBRPJ$value, 1), tail(months(series$InadBRPJ$date), 1)),
                text = "Pessoa Jurídica",
                rightBorder = FALSE,
                marginBottom = FALSE
              )
            )
          ),
          fluidRow(
            column(
              width = 12,
              descriptionBlock(
                number = paste(round(
                  tail(series$InadBR$value, 1) - head(tail(series$InadBR$value, 2), 1), 2
                ), "%"),
                numberColor = if (tail(series$InadBR$value, 1) - head(tail(series$InadBR$value, 2), 1) >= 0) {
                  "danger"
                } else {
                  "success"
                },
                numberIcon = if (tail(series$InadBR$value, 1) - head(tail(series$InadBR$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste(tail(series$InadBR$value, 1), tail(months(series$InadBR$date), 1)),
                text = "Geral",
                rightBorder = FALSE,
                marginBottom = FALSE
              )
            )
          )
        ),

        # Inadimplência ES
        box(
          title = tags$div("Inadimplência ES", class = "box-tit"),
          closable = FALSE,
          width = 4,
          height = 855,
          status = "warning",
          solidHeader = TRUE,
          tags$div("Índice de Inadimplência - ES", class = "box-subtit"),
          tags$div("Percentual sobre saldo de créditos, mensal", class = "box-body"),
          plotlyOutput(ns("plot4")),
          tags$div("Fonte: Banco Central do Brasil", class = "box-legenda"),
          footer = fluidRow(
            column(
              width = 6,
              descriptionBlock(
                number = paste(round(
                  tail(series$InadESPF$value, 1) - head(tail(series$InadESPF$value, 2), 1), 2
                ), "%"),
                numberColor = if (tail(series$InadESPF$value, 1) - head(tail(series$InadESPF$value, 2), 1) >= 0) {
                  "danger"
                } else {
                  "success"
                },
                numberIcon = if (tail(series$InadESPF$value, 1) - head(tail(series$InadESPF$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste(tail(series$InadESPF$value, 1), tail(months(series$InadESPF$date), 1)),
                text = "Pessoa física",
                rightBorder = TRUE,
                marginBottom = FALSE
              )
            ), column(
              width = 6,
              descriptionBlock(
                number = paste(round(
                  tail(series$InadESPJ$value, 1) - head(tail(series$InadESPJ$value, 2), 1), 2
                ), "%"),
                numberColor = if (tail(series$InadESPJ$value, 1) - head(tail(series$InadESPJ$value, 2), 1) >= 0) {
                  "danger"
                } else {
                  "success"
                },
                numberIcon = if (tail(series$InadESPJ$value, 1) - head(tail(series$InadESPJ$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste(tail(series$InadESPJ$value, 1), tail(months(series$InadESPJ$date), 1)),
                text = "Pessoa Jurídica",
                rightBorder = FALSE,
                marginBottom = FALSE
              )
            )
          ),
          fluidRow(
            column(
              width = 12,
              descriptionBlock(
                number = paste(round(
                  tail(series$InadES$value, 1) - head(tail(series$InadES$value, 2), 1), 2
                ), "%"),
                numberColor = if (tail(series$InadES$value, 1) - head(tail(series$InadES$value, 2), 1) >= 0) {
                  "danger"
                } else {
                  "success"
                },
                numberIcon = if (tail(series$InadES$value, 1) - head(tail(series$InadES$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste(tail(series$InadES$value, 1), tail(months(series$InadES$date), 1)),
                text = "Geral",
                rightBorder = FALSE,
                marginBottom = FALSE
              )
            )
          )
        ),

        # Saldo operações de crédito ES
        box(
          title = tags$div("Crédito", class = "box-tit"),
          closable = FALSE,
          width = 4,
          height = 855,
          status = "warning",
          solidHeader = TRUE,
          tags$div("Saldo das operações de crédito do SFN - ES", class = "box-subtit"),
          tags$div("Em R$ bilhões, mensal", class = "box-body"),
          plotlyOutput(ns("plot5")),
          tags$div("Fonte: Banco Central do Brasil", class = "box-legenda"),
          footer = fluidRow(
            column(
              width = 6,
              descriptionBlock(
                number = paste(round(
                  tail(series$SaldoESPF$value, 1) - head(tail(series$SaldoESPF$value, 2), 1), 2
                ), "milhões"),
                numberColor = if (tail(series$SaldoESPF$value, 1) - head(tail(series$SaldoESPF$value, 2), 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (tail(series$SaldoESPF$value, 1) - head(tail(series$SaldoESPF$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste(round(tail(series$SaldoESPF$value / 1000, 1), 1), "bi", tail(months(series$SaldoESPF$date), 1)),
                text = "Pessoa física",
                rightBorder = TRUE,
                marginBottom = FALSE
              )
            ), column(
              width = 6,
              descriptionBlock(
                number = paste(round(
                  tail(series$SaldoESPJ$value, 1) - head(tail(series$SaldoESPJ$value, 2), 1), 2
                ), "milhões"),
                numberColor = if (tail(series$SaldoESPJ$value, 1) - head(tail(series$SaldoESPJ$value, 2), 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (tail(series$SaldoESPJ$value, 1) - head(tail(series$SaldoESPJ$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste(round(tail(series$SaldoESPJ$value / 1000, 1), 1), "bi", tail(months(series$SaldoESPJ$date), 1)),
                text = "Pessoa Jurídica",
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

#' credito Server Function
#'
#' @noRd
mod_conj_credito_server <- function(input, output, session) {
  ns <- session$ns

  # Pesquisa condições de crédito
  output$plot1 <- renderPlotly({
    plot_ly(
      data = series$PTCC_grandes, x = ~date, y = ~value,
      type = "scatter", mode = "lines", name = "Grandes Empresas", line = list(color = "#004B8D")
    ) %>%
      add_trace(
        y = series$PTCC_mpme$value,
        name = "MPME", mode = "lines", line = list(color = "#56af31")
      ) %>%
      add_trace(
        y = series$PTCC_consumo$value,
        name = "Consumo", mode = "lines", line = list(color = "#79bce7")
      ) %>%
      add_trace(
        y = series$PTCC_habitacao$value,
        name = "Habitação", mode = "lines", line = list(color = "#e7d8ac")
      ) %>%
      layout(
        title = "",
        xaxis = list(title = ""),
        yaxis = list(title = "pontos"),
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center"
        )
      )
  })

  # Endividamento das Famílias
  output$plot2 <- renderPlotly({
    plot_ly(
      data = series$End, x = ~date, y = ~value,
      type = "scatter", mode = "lines", name = "End. Famílias SFN", line = list(color = "#004B8D")
    ) %>%
      add_trace(
        y = series$Endi$value,
        name = "Exceto Imobiliário", mode = "lines", line = list(color = "#56af31")
      ) %>%
      layout(
        title = "",
        xaxis = list(title = ""),
        yaxis = list(title = "pontos"),
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center"
        )
      )
  })

  # Inadimplência BR
  output$plot3 <- renderPlotly({
    plot_ly(
      data = series$InadBR, x = ~date, y = ~value,
      type = "scatter", mode = "lines", name = "Geral", line = list(color = "#004B8D")
    ) %>%
      add_trace(
        y = series$InadBRPF$value,
        name = "Pessoa Física", mode = "lines", line = list(color = "#56af31")
      ) %>%
      add_trace(
        y = series$InadBRPJ$value,
        name = "Pessoa Jurídica", mode = "lines", line = list(color = "#79bce7")
      ) %>%
      layout(
        title = "",
        xaxis = list(title = ""),
        yaxis = list(title = "pontos"),
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center"
        )
      )
  })

  # Inadimplência ES
  output$plot4 <- renderPlotly({
    plot_ly(
      data = series$InadES, x = ~date, y = ~value,
      type = "scatter", mode = "lines", name = "Geral", line = list(color = "#004B8D")
    ) %>%
      add_trace(
        y = series$InadESPF$value,
        name = "Pessoa Física", mode = "lines", line = list(color = "#56af31")
      ) %>%
      add_trace(
        y = series$InadESPJ$value,
        name = "Pessoa Jurídica", mode = "lines", line = list(color = "#79bce7")
      ) %>%
      layout(
        title = "",
        xaxis = list(title = ""),
        yaxis = list(title = "pontos"),
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center"
        )
      )
  })

  # Saldo das operações de crédito do SFN - ES
  output$plot5 <- renderPlotly({
    plot_ly(
      data = series$SaldoESPF, x = ~date, y = ~value / 100,
      type = "scatter", mode = "lines", name = "Pessoa Física", line = list(color = "#004B8D")
    ) %>%
      add_trace(
        y = series$SaldoESPJ$value / 100,
        name = "Pessoa Jurídica", mode = "lines", line = list(color = "#56af31")
      ) %>%
      layout(
        title = "",
        xaxis = list(title = ""),
        yaxis = list(title = "R$ bi"),
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center"
        )
      )
  })

}

## To be copied in the UI
# mod_credito_ui("credito_ui_1")

## To be copied in the server
# callModule(mod_credito_server, "credito_ui_1")