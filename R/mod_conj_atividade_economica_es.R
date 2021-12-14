#' atividade_economica_es UI Function
#'
#' @description Modulo atividade economica do Estado do Espirito Santo.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList

mod_conj_atividade_economica_es_ui <- function(id) {
  ns <- NS(id)
  tagList(
    fluidPage(titlePanel(h1("ATIVIDADE ECONÔMICA CAPIXABA")),
      fluidRow(

        # Resenha
        box(
          closable = FALSE,
          width = 12,
          status = NULL,
          background = "yellow",
          solidHeader = TRUE,
          collapsible = FALSE,
          tags$div(
            class = "res-body",
           HTML(tail(resenhas_conjuntura$atividade.eco.es, 1))
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
               tags$a("2° Trimestre",
                href="www/relatorios/atividade-economica-es/2021/012/atividade-economica-es.pdf",
                 target="_blank"))
            )
          )
        ),

        # PIB variação anual
        box(
          title = tags$div("Produto Interno Bruto ES", class = "box-tit"),
          closable = FALSE,
          width = 4,
          height = 760,
          status = "warning",
          solidHeader = TRUE,
          collapsible = FALSE,
          enable_dropdown = FALSE,
          tags$div("Crescimento do PIB ES", class = "box-subtit"),
          tags$div("Variação % anual real", class = "box-body"),
          plotlyOutput(ns("plot1")),
          tags$div("Fonte: IBGE", class = "box-legenda"),
          tags$div(HTML(
            ifelse(
              is.na(tail(legenda_conjuntura$pib.var.es,1)),
              "",
              tail(legenda_conjuntura$pib.var.es,1)
              )
            ), 
            class = "box-body"),
          footer = fluidRow(
            column(
              width = 12,
              descriptionBlock(
                number = paste(round(
                  tail(series$PIBvarES$value, 1), 2
                ), "%"),
                numberColor = if (tail(series$PIBvarES$value, 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (tail(series$PIBvarES$value, 1) >= 0) {
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

        # PIB a preços de mercado
        box(
          title = tags$div("Produto Interno Bruto ES", class = "box-tit"),
          closable = FALSE,
          width = 4,
          height = 760,
          status = "warning",
          solidHeader = TRUE,
          tags$div("Crescimento do PIB ES", class = "box-subtit"),
          tags$div("Valores observados a preço de mercado em R$", class = "box-body"),
          plotlyOutput(ns("plot2")),
          tags$div("Fonte: IBGE", class = "box-legenda"),
          tags$div(HTML(
            ifelse(
              is.na(tail(legenda_conjuntura$pib.es, 1)), 
              "",
              tail(legenda_conjuntura$pib.es, 1)
              ) 
            ),
            class = "box-body"),
          footer = fluidRow(
            column(
              width = 12,
              descriptionBlock(
                number = paste(round(
                  ((tail(series$PIBES$value, 1) / head(tail(series$PIBES$value, 2), 1)) - 1) * 100, 2
                ), "%"),
                numberColor = if (tail(series$PIBES$value, 1) - head(tail(series$PIBES$value, 2), 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (tail(series$PIBES$value, 1) - head(tail(series$PIBES$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste0(round(tail(series$PIBES$value, 1) / 1000000000, 2), " bi"),
                text = "PIB ES",
                rightBorder = FALSE,
                marginBottom = FALSE
              )
            )
          )
        ),

        # IBCR-ES
        box(
          title = tags$div("IBCR-ES", class = "box-tit"),
          closable = FALSE,
          width = 4,
          height = 760,
          status = "warning",
          solidHeader = TRUE,
          tags$div("Índice de Atividade Econômica Regional", class = "box-subtit"),
          tags$div("Índice mensal observado e dessazonalizado", class = "box-body"),
          plotlyOutput(ns("plot3")),
          tags$div("Fonte: Banco Central do Brasil", class = "box-legenda"),
          tags$div(HTML(
            ifelse(
            is.na(tail(legenda_conjuntura$ibcr.es, 1)),
            "", 
            tail(legenda_conjuntura$ibcr.es, 1)
              )
            ),
            class = "box-body"
          ),
          footer = fluidRow(
            column(
              width = 6,
              descriptionBlock(
                number = paste(round(
                  tail(series$IBCRES$value, 1) - head(tail(series$IBCRES$value, 2), 1), 2
                ), "pts"),
                numberColor = if (tail(series$IBCRES$value, 1) - head(tail(series$IBCRES$value, 2), 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (tail(series$IBCRES$value, 1) - head(tail(series$IBCRES$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste0(tail(series$IBCRES$value, 1), " (", tail(months(series$IBCRES$date), 1), ")"),
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
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (tail(series$IBCRESs$value, 1) - head(tail(series$IBCRESs$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste0(tail(series$IBCRESs$value, 1), " (", tail(months(series$IBCRESs$date), 1), ")"),
                text = "IBCRES-ES Dessazonalizado",
                rightBorder = FALSE,
                marginBottom = FALSE
              )
            )
          )
        ),

        # Varejo e Serviços
        box(
          title = tags$div("Varejo e Serviços ES", class = "box-tit"),
          closable = FALSE,
          width = 4,
          height = 760,
          status = "warning",
          solidHeader = TRUE,
          tags$div("Índice mensal de varejo e serviços", class = "box-subtit"),
          tags$div("Volume de vendas no varejo e receita nominal de serviços", class = "box-body"),
          plotlyOutput(ns("plot4")),
          tags$div("Fonte: IBGE", class = "box-legenda"),
          tags$div(HTML(
            ifelse(
              is.na(tail(legenda_conjuntura$varejo.es, 1)),
              "",
              tail(legenda_conjuntura$varejo.es, 1)
            )
           ),
           class = "box-body"
          ),
          footer = fluidRow(
            column(
              width = 6,
              descriptionBlock(
                number = paste(round(
                  tail(series$VarejoES$value, 1) - head(tail(series$VarejoES$value, 2), 1), 2
                ), "pts"),
                numberColor = if (tail(series$VarejoES$value, 1) - head(tail(series$VarejoES$value, 2), 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (tail(series$VarejoES$value, 1) - head(tail(series$VarejoES$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste0(tail(series$VarejoES$value, 1), " (", tail(months(series$VarejoES$date), 1), ")"),
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
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (tail(series$ServicosES$value, 1) - head(tail(series$ServicosES$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste0(tail(series$ServicosES$value, 1), " (", tail(months(series$ServicosES$date), 1), ")"),
                text = "Serviços ES",
                rightBorder = FALSE,
                marginBottom = FALSE
              )
            )
          )
        ),

        # Exportações
        box(
          title = tags$div("Exportações ES", class = "box-tit"),
          closable = FALSE,
          width = 4,
          height = 760,
          status = "warning",
          solidHeader = TRUE,
          tags$div("Exportações de bens ES", class = "box-subtit"),
          tags$div("US$ milhões, mensal", class = "box-body"),
          plotlyOutput(ns("plot5")),
          tags$div("Fonte: MDIC", class = "box-legenda"),
          tags$div(HTML(
            ifelse(
              is.na(tail(legenda_conjuntura$exportacoes.es, 1)),
              "",
              tail(legenda_conjuntura$exportacoes.es, 1)
            )
          ),
          class = "box-body"),
          footer = fluidRow(
            column(
              width = 12,
              descriptionBlock(
                number = paste("US$", round(
                  (tail(series$ExpES$value, 1) - head(tail(series$ExpES$value, 2), 1)) / 1000, 2
                ), "mi"),
                numberColor = if (tail(series$ExpES$value, 1) - head(tail(series$ExpES$value, 2), 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (tail(series$ExpES$value, 1) - head(tail(series$ExpES$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste0(" US$", tail(series$ExpES$value / 1000, 1), " mi", " (", tail(months(series$ExpES$date), 1), ")"),
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

#' atividade_economica_es Server Function
#'
#' @noRd
mod_conj_atividade_economica_es_server <- function(input, output, session) {
  ns <- session$ns

  # PIB variação anual
  output$plot1 <- renderPlotly({
    plot_ly(
      data = series$PIBvarES, x = ~date, y = ~value,
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

  # PIB em R$ a preços de mercado
  output$plot2 <- renderPlotly({
    plot_ly(
      data = series$PIBES, x = ~date, y = ~value,
      type = "scatter", mode = "lines", name = "PIB ES", line = list(color = "#004B8D")
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
      type = "scatter", mode = "lines", name = "IBCR-ES", line = list(color = "#004B8D")
    ) %>%
      add_trace(y = series$IBCRESs$value, name = "IBC-ES dessazonalizado", line = list(color = "#56af31")) %>%
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
      type = "scatter", mode = "lines", name = "Varejo", line = list(color = "#004B8D")
    ) %>%
      add_trace(y = series$ServicosES$value, name = "Serviços", line = list(color = "#56af31")) %>%
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
      type = "scatter", mode = "lines", name = "Exportações", line = list(color = "#004B8D")
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