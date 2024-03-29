#' atividade_economica_br UI Function
#'
#' @description Modulo da atividade economica nacional.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList

mod_conj_atividade_economica_ui <- function(id) {
  ns <- NS(id)
  tagList(
    fluidPage(titlePanel(h1("ATIVIDADE ECONÔMICA BRASILEIRA")),
      fluidRow(

        # Resenha
        box(
          closable = FALSE,
          width = 12,
          status = NULL,
          background = "yellow",
          solidHeader = TRUE,
          enable_dropdown = FALSE,
          aligh = "center",
          tags$div(
            class = "res-body",
            HTML(tail(resenhas_conjuntura$atividadeeconomica, 1))
          )
        ),

        #Relatorios
        box(
          title = tags$div("Relatórios", class = "box-tit"),
          closable = FALSE,
          collapsible = TRUE,
          collapsed = FALSE,
          width = 12,
          status = "warning",
          background = "yellow",
          solidHeader = TRUE,
          enable_dropdown = FALSE,
          mainPanel(
            tabsetPanel(
              tabPanel("2021",
                tags$a("3° Trimestre",
                 href = "www/relatorios/atividade-economica/2021/012/atividade-economica.pdf",
                  target = "_blank"))
            )
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
          withSpinner(plotlyOutput(ns("plot1")), type = 1, color = "#004b8d", size = 1.5),
          tags$div("Fonte: IBGE", style = "box-legenda"),
          tags$div(
            HTML(
              ifelse(
                is.na(tail(legenda_conjuntura$pib, 1)),
                  "",
                  tail(legenda_conjuntura$pib, 1)
                )
              ),
            class = "box-body"),
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
          withSpinner(plotlyOutput(ns("plot2")), type = 1, color = "#004b8d", size = 1.5),
          tags$div("Fonte: IBGE", class = "box-legenda"),
          tags$div(HTML(
            ifelse(
              is.na(tail(legenda_conjuntura$pib.tri, 1)),
              "",
              tail(legenda_conjuntura$pib.tri, 1)
              )
            ),
            class = "box-body"),
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
                header = paste0(tail(series$PIBtriobs$value, 1), " (", tail(months(series$PIBtriobs$date), 1), ")"),
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
                header = paste0(tail(series$PIBtri$value, 1), " (", tail(months(series$PIBtri$date), 1), ")"),
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
          withSpinner(plotlyOutput(ns("plot3")), type = 1, color = "#004b8d", size = 1.5),
          tags$div("Fonte: Banco Central do Brasil", class = "box-legenda"),
          tags$div(HTML(
            ifelse(
              is.na(tail(legenda_conjuntura$ibc.br, 1)),
              "",
              tail(legenda_conjuntura$ibc.br, 1)
                 )
                ),
            class = "box-body"),
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
                header = paste0(tail(series$IBCBr$value, 1), " (", tail(months(series$IBCBr$date), 1), ")"),
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
                header = paste0(tail(series$IBCBrs$value, 1), " (", tail(months(series$IBCBrs$date), 1), ")"),
                text = "IBC-Br Dessazonalizado",
                rightBorder = FALSE,
                marginBottom = FALSE
              )
            )
          )
        ),

        # Serviços
        box(
          title = tags$div("Serviços", class = "box-tit"),
          closable = FALSE,
          width = 4,
          height = 760,
          status = "warning",
          solidHeader = TRUE,
          tags$div("Pesquisa Mensal de Serviços", class = "box-subtit"),
          tags$div("Receita nominal e volume de serviços", class = "box-body"),
          withSpinner(plotlyOutput(ns("plot7")), type = 1, color = "#004b8d", size = 1.5),
          tags$div("Fonte: IBGE", class = "box-legenda"),
          tags$div(
            HTML(
              ifelse(
                is.na(tail(legenda_conjuntura$servicos, 1)),
                "",
                tail(legenda_conjuntura$servicos, 1)
                )
              ),
            class = "box-body"),
          footer = fluidRow(
            column(
              width = 6,
              descriptionBlock(
                number = paste(round(
                  tail(series$Vol.Servicos$value, 1) - head(tail(series$Vol.Servicos$value, 2), 1), 2
                ), "pts"),
                numberColor = if (tail(series$Vol.Servicos$value, 1) - head(tail(series$Vol.Servicos$value, 2), 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (tail(series$Vol.Servicos$value, 1) - head(tail(series$Vol.Servicos$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste0(tail(series$Vol.Servicos$value, 1), " (", tail(months(series$Vol.Servicos$date), 1), ")"),
                text = "Volume de serviços",
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
                header = paste0(tail(series$Servicos$value, 1), " (", tail(months(series$Servicos$date), 1), ")"),
                text = "Receita de Serviços",
                rightBorder = FALSE,
                marginBottom = FALSE
              )
            )
          )
        ),

        # Varejo
        box(
          title = tags$div("Varejo", class = "box-tit"),
          closable = FALSE,
          width = 4,
          height = 760,
          status = "warning",
          solidHeader = TRUE,
          tags$div("Índice de volume de vendas no varejo", class = "box-subtit"),
          tags$div("Mensal", class = "box-body"),
          withSpinner(plotlyOutput(ns("plot4")), type = 1, color = "#004b8d", size = 1.5),
          tags$div("Fonte: IBGE", class = "box-legenda"),
          tags$div(
            HTML(
              ifelse(
                is.na(tail(legenda_conjuntura$varejo, 1)),
                "",
                tail(legenda_conjuntura$varejo, 1)
                )
              ),
            class = "box-body"),
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
                header = paste0(tail(series$Varejo$value, 1), " (", tail(months(series$Varejo$date), 1), ")"),
                text = "Varejo Sazonalizado",
                rightBorder = TRUE,
                marginBottom = FALSE
              )
            ), column(
              width = 6,
              descriptionBlock(
                number = paste(round(
                  tail(series$Varejos$value, 1) - head(tail(series$Varejos$value, 2), 1), 2
                ), "pts"),
                numberColor = if (tail(series$Varejos$value, 1) - head(tail(series$Varejos$value, 2), 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (tail(series$Varejos$value, 1) - head(tail(series$Varejos$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste0(tail(series$Varejos$value, 1), " (", tail(months(series$Varejos$date), 1), ")"),
                text = "Varejo Dessazonalizado",
                rightBorder = FALSE,
                marginBottom = FALSE
              )
            )
          )
        ),

        # Indústria
        box(
          title = tags$div("Indústria", class = "box-tit"),
          closable = FALSE,
          width = 4,
          height = 760,
          status = "warning",
          solidHeader = TRUE,
          collapsible = FALSE,
          enable_dropdown = FALSE,
          tags$div("Indicadores de Produção Industrial", class = "box-subtit"),
          tags$div("Indústria geral, mensal", class = "box-body"),
          withSpinner(plotlyOutput(ns("plot6")), type = 1, color = "#004b8d", size = 1.5),
          tags$div("Fonte: IBGE", class = "box-legenda"),
          tags$div(
            HTML(
              ifelse(
                is.na(tail(legenda_conjuntura$industria, 1)),
                "",
                tail(legenda_conjuntura$industria, 1)
                )
              ),
            class = "box-body"
          ),
          footer = fluidRow(
            column(
              width = 12,
              descriptionBlock(
                number = paste(round(
                  tail(series$IndustriaBR$value, 1) - head(tail(series$IndustriaBR$value, 2), 1), 2
                ), "pts"),
                numberColor = if (tail(series$IndustriaBR$value, 1) - head(tail(series$IndustriaBR$value, 2), 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (tail(series$IndustriaBR$value, 1) - head(tail(series$IndustriaBR$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste0(tail(series$IndustriaBR$value, 1), " pts", " (", tail(months(series$IndustriaBR$date), 1), ")"),
                text = "produção industrial",
                rightBorder = FALSE,
                marginBottom = FALSE
              )
            )
          )
        ),

        # Exportações
        box(
          title = tags$div("Exportações", class = "box-tit"),
          closable = FALSE,
          width = 4,
          height = 760,
          status = "warning",
          solidHeader = TRUE,
          tags$div("Exportações de bens", class = "box-subtit"),
          tags$div("Balanço de pagamentos, US$ bilhões, mensal", class = "box-body"),
          withSpinner(plotlyOutput(ns("plot5")), type = 1, color = "#004b8d", size = 1.5),
          tags$div("Fonte: Banco Central do Brasil", class = "box-legenda"),
          tags$div(HTML(
            ifelse(
              is.na(tail(legenda_conjuntura$exportacoes, 1)),
              "",
              tail(legenda_conjuntura$exportacoes, 1)
            )
           ),
           class = "box-body"),
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
                header = paste0(" US$", round(tail(series$ExpBR$value / 1000, 1), 1), " bi", " (", tail(months(series$ExpBR$date), 1), ")"),
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
mod_conj_atividade_economica_server <- function(input, output, session) {
  ns <- session$ns

  # PIB variação anual
  output$plot1 <- renderPlotly({
    plot_ly(
      data = series$PIBvar, x = ~date, y = ~value,
      type = "bar", name = "PIB Anual", marker = list(color = "#004B8D")
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
      type = "scatter", mode = "lines", name = "PIB trimestral observado", line = list(color = "#004B8D")
    ) %>%
      add_trace(y = series$PIBtri$value, name = "PIB trimestral dessazonalizado", line = list(color = "#56af31")) %>%
      layout(
        title = "", xaxis = list(title = ""), yaxis = list(title = "Índice (1995=100)"),
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
      type = "scatter", mode = "lines", name = "IBC-Br", line = list(color = "#004B8D")
    ) %>%
      add_trace(y = series$IBCBrs$value, name = "IBC-Br dessazonalizado", line = list(color = "#56AF31")) %>%
      layout(
        title = "", xaxis = list(title = ""), yaxis = list(title = "IBC-Br"),
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center"
        )
      )
  })

  # Serviços
  output$plot7 <- renderPlotly({
    plot_ly(
      data = series$Vol.Servicos[match(series$Servicos$date, series$Vol.Servicos$date), ],
      x = ~date, y = ~value,
      type = "scatter", mode = "lines", name = "Volume de Serviços", line = list(color = "#004B8D")
    ) %>%
      add_trace(y = series$Servicos$value, name = "Receita de Serviços", line = list(color = "#56AF31")) %>%
      layout(
        title = "", xaxis = list(title = ""), yaxis = list(title = "Índice"),
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center"
        )
      )
  })

  # Varejo
  output$plot4 <- renderPlotly({
    plot_ly(
      data = series$Varejo[match(series$Varejos$date, series$Varejo$date), ],
      x = ~date, y = ~value,
      type = "scatter", mode = "lines", name = "Varejo Sazonalizado", line = list(color = "#004B8D")
    )  %>%
    add_trace(y = series$Varejos$value, name = "Varejo Dessazonalizado", line = list(color = "#56AF31")) %>%
      layout(
        title = "", xaxis = list(title = ""), yaxis = list(title = "Índice"),
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center"
        )
      )
  })

  # Indústria
  output$plot6 <- renderPlotly({
    plot_ly(
      data = series$IndustriaBR, x = ~date, y = ~value,
      type = "scatter", mode = "lines", name = "produção industrial", line = list(color = "#004B8D")
    ) %>%
      layout(
        title = "", xaxis = list(title = ""), yaxis = list(title = "Índice"),
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
      type = "scatter", mode = "lines", name = "ExpBr", line = list(color = "#004B8D")
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