#' fundos_dividendos UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_fundos_dividendos_ui <- function(id) {
  ns <- NS(id)
  tagList(
    fluidPage(
      fluidRow(
        tags$div(
          class = "conj-tit", br(),
          "Fundos Banestes de Ações"
        ),
        br(),
        
        
        # resenha
        box(
          title = tags$div("BANESTES DIVIDENDOS FI", class = "res-tit"),
          closable = FALSE,
          collapsible = FALSE,
          collapsed = FALSE,
          width = 12,
          status = "warning",
          background = "yellow",
          solidHeader = TRUE,
          enable_dropdown = FALSE,
          tags$div(
            class = "res-body",
            HTML(resenhas_fundos$dividendos)
          ),
          tags$a(
            href = "https://www.banestes.com.br/investimentos/pdf/lamina_Dividendos.pdf", target = "_blank",
            "Lâmina",
            class = "link"
          ),
          tags$a(
            href = "https://www.banestes.com.br/investimentos/pdf/regulamento_dividendos.pdf", target = "_blank",
            "Regulamento",
            class = "link"
          ),
          tags$a(
            href = "https://www.banestes.com.br/investimentos/pdf/publicitario_FDividendos.pdf", target = "_blank",
            "Relatório",
            class = "link"
          ),
          tags$a(
            href = "https://www.banestes.com.br/investimentos/pdf/adesao_dividendos.pdf", target = "_blank",
            "Termo de adesão",
            class = "link"
          ),
        ),
        
        # fundo dividendos fi
        box(
          title = tags$div("Desempenho do Fundo", class = "box-graf"),
          closable = FALSE,
          collapsible = TRUE,
          collapsed = FALSE,
          width = 12,
          status = "warning",
          solidHeader = TRUE,
          tags$div("Fundo de Investimento Renda Variável", class = "box-subtit"),
          tags$div("Variação % mensal", class = "box-body"),
          plotlyOutput(ns("plot1")),
          tags$div("fonte: Banestes DTVM", style = "box-legenda"),
          footer = fluidRow(
            column(
              width = 12,
              descriptionBlock(
                number = scales::percent(head(tail(fundos$Dividendos$rentabilidade, 2), 1), 0.1),
                numberColor = if (head(tail(fundos$Dividendos$rentabilidade, 2), 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (head(tail(fundos$Dividendos$rentabilidade, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste(scales::percent(tail(fundos$Dividendos$rentabilidade, 1), 0.1), "de rentabilidade acumulada"),
                text = "nos últimos 12 meses",
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


#' fundos_dividendos Server Functions
#'
#' @noRd
mod_fundos_dividendos_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    # plot fundo
    output$plot1 <- renderPlotly({
      plot_ly(
        data = fundos$Dividendos[1:nrow(fundos$Dividendos) - 1, ],
        x = ~ as.Date(mes), y = ~rentabilidade_acum,
        type = "scatter", mode = "lines", name = "Fundo Banestes Dividendos", marker = list(color = "#004B8D")
      ) %>%
        add_trace(
          data = fundos$Dividendos[1:nrow(fundos$Dividendos) - 1, ],
          y = ~indice_acum, name = "IBOVESPA", marker = list(color = "#56af31"), line = list(color = "#56af31")
        ) %>%
        layout(
          title = "", xaxis = list(title = ""),
          yaxis = list(
            title = "rentabilidade", tickformat = ".1%"
          ),
          xaxis = list(
            type = "date",
            tickformat = "%b %Y"
          ),
          showlegend = TRUE,
          legend = list(orientation = "h")
        )
    })
  })
}

## To be copied in the UI
# mod_fundos_dividendos_ui("fundos_dividendos_ui_1")

## To be copied in the server
# mod_fundos_dividendos_server("fundos_dividendos_ui_1")