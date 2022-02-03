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
    fluidPage(titlePanel(h1("CRÉDITO")),
      fluidRow(

        # Resenha
        box(
          closable = FALSE,
          width = 12,
          status = NULL,
          background = "yellow",
          solidHeader = TRUE,
          collapsible = FALSE,
          enable_dropdown = FALSE,
          tags$div(
            class = "res-body",
            HTML(tail(resenhas_conjuntura$credito,1))
          )
        ),

        #Relatorios
        box(
          title = tags$div("Relatórios", class = "box-tit"),
          closable = FALSE,
          collapsible = TRUE,
          collapsed = TRUE,
          width = 12,
          status = "warning",
          background = "yellow",
          solidHeader = TRUE,
          enable_dropdown = FALSE,
          mainPanel(
            tabsetPanel(
              tabPanel("2021",
               tags$a("Outubro", href = "www/relatorios/credito/2021/10/credito.pdf", target = "_blank"))
            )
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
          withSpinner(plotlyOutput(ns("plot1")), type = 1, color = "#004b8d", size = 1.5),
          tags$div("Fonte: BCB-Depep", class = "box-legenda"),
          tags$div(HTML(
            ifelse(
              is.na(tail(legenda_conjuntura$consumo, 1)),
              "",
              tail(legenda_conjuntura$consumo, 1)
            )
          ),
          class = "box-body"),
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
                header = paste0(tail(series$PTCC_grandes$value, 1), " (", tail(months(series$PTCC_grandes$date), 1), ")"),
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
                header = paste0(tail(series$PTCC_mpme$value, 1), " (", tail(months(series$PTCC_mpme$date), 1), ")"),
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
                header = paste0(tail(series$PTCC_consumo$value, 1)," (", tail(months(series$PTCC_consumo$date), 1), ")"),
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
                header = paste0(tail(series$PTCC_habitacao$value, 1)," (", tail(months(series$PTCC_habitacao$date), 1), ")"),
                text = "HABITAÇÃO",
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
          withSpinner(plotlyOutput(ns("plot2")), type = 1, color = "#004b8d", size = 1.5),
          tags$div("Fonte: Banco Central do Brasil", class = "box-legenda"),
          tags$div(
            HTML(
              ifelse(
                is.na(tail(legenda_conjuntura$endividamento, 1)),
                "",
                tail(legenda_conjuntura$endividamento, 1)
              )
            ),
            class = "box-body"
          ),
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
                header = paste0(tail(series$End$value, 1), " (", tail(months(series$End$date), 1), ")"),
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
                header = paste0(tail(series$Endi$value, 1), " (", tail(months(series$Endi$date), 1), ")"),
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
          withSpinner(plotlyOutput(ns("plot3")), type = 1, color = "#004b8d", size = 1.5),
          tags$div("Fonte: Banco Central do Brasil", class = "box-legenda"),
          tags$div(
            HTML(
              ifelse(
                is.na(tail(legenda_conjuntura$inadimplencia.br, 1)),
                "",
                tail(legenda_conjuntura$inadimplencia.br, 1)
              )
            ),
            class = "box-body"
          ),
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
                header = paste0(tail(series$InadBRPF$value, 1), " (", tail(months(series$InadBRPF$date), 1), ")"),
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
                header = paste0(tail(series$InadBRPJ$value, 1), " (", tail(months(series$InadBRPJ$date), 1), ")"),
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
                header = paste0(tail(series$InadBR$value, 1), " (", tail(months(series$InadBR$date), 1), ")"),
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
          withSpinner(plotlyOutput(ns("plot4")), type = 1, color = "#004b8d", size = 1.5),
          tags$div("Fonte: Banco Central do Brasil", class = "box-legenda"),
          tags$div(
            HTML(
              ifelse(
                is.na(tail(legenda_conjuntura$inadimplencia.es, 1)),
                "",
                tail(legenda_conjuntura$inadimplencia.es, 1)
              )
            ),
            class = "box-body"
          ),
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
                header = paste0(tail(series$InadESPF$value, 1), " (", tail(months(series$InadESPF$date), 1), ")"),
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
                header = paste0(tail(series$InadESPJ$value, 1), " (", tail(months(series$InadESPJ$date), 1), ")"),
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
                header = paste0(tail(series$InadES$value, 1), " (", tail(months(series$InadES$date), 1), ")"),
                text = "Geral",
                rightBorder = FALSE,
                marginBottom = FALSE
              )
            )
          )
        ),

        # Saldo operações de crédito ES
        box(
          title = tags$div("Crédito ES", class = "box-tit"),
          closable = FALSE,
          width = 4,
          height = 855,
          status = "warning",
          solidHeader = TRUE,
          tags$div("Saldo das operações de crédito do SFN - ES", class = "box-subtit"),
          tags$div("Mensal, R$ milhões", class = "box-body"),
          withSpinner(plotlyOutput(ns("plot5")), type = 1, color = "#004b8d", size = 1.5),
          tags$div("Fonte: Banco Central do Brasil", class = "box-legenda"),
          tags$div(
            HTML(
              ifelse(
                is.na(tail(legenda_conjuntura$credito.es, 1)),
                "",
                tail(legenda_conjuntura$credito.es, 1)
              )
            ),
            class = "box-body"
          ),
          footer = fluidRow(
            column(
              width = 6,
              descriptionBlock(
                number = paste("R$", round(
                  (tail(series$SaldoESPF$value, 1) - head(tail(series$SaldoESPF$value, 2), 1)) /1000, 2
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
                header = paste0(" R$", round(tail(series$SaldoESPF$value / 1000, 1), 1), " mi", " (", tail(months(series$SaldoESPF$date), 1), ")"),
                text = "Pessoa física",
                rightBorder = TRUE,
                marginBottom = FALSE
              )
            ), column(
              width = 6,
              descriptionBlock(
                number = paste("R$", round(
                  (tail(series$SaldoESPJ$value, 1) - head(tail(series$SaldoESPJ$value, 2), 1)) / 1000, 2
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
                header = paste0(" R$", round(tail(series$SaldoESPJ$value / 1000, 1), 1), " mi", " (", tail(months(series$SaldoESPJ$date), 1), ")"),
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
      data = series$InadBR[match(series$InadBRPF$date, series$InadBR$date), ], x = ~date, y = ~value,
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
      data = series$SaldoESPF, x = ~date, y = ~value / 1000,
      type = "scatter", mode = "lines", name = "Pessoa Física", line = list(color = "#004B8D")
    ) %>%
      add_trace(
        y = series$SaldoESPJ$value / 1000,
        name = "Pessoa Jurídica", mode = "lines", line = list(color = "#56af31")
      ) %>%
      layout(
        title = "",
        xaxis = list(title = ""),
        yaxis = list(title = "R$ mi"),
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