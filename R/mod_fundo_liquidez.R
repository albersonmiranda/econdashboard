#' fundo_liquidez UI Function
#'
#' @description Módulo do fundo de liquidez Banestes.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_fundo_liquidez_ui <- function(id){
  ns <- NS(id)
  tagList(fluidPage(
    fluidRow(

      # resenha
      box(
        title = tags$div("BANESTES LIQUIDEZ FI", class = "res-tit"),
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
          HTML(resenhas_fundos$liquidez)
        ),
        tags$a(
          href = "https://www.banestes.com.br/investimentos/pdf/lamina_Liquidez.pdf", target = "_blank",
          "Lâmina",
          class = "link"),
        tags$a(
          href = "https://www.banestes.com.br/investimentos/pdf/regulamento_liquidez_referenciado.pdf", target = "_blank",
          "Regulamento",
          class = "link"),
        tags$a(
          href = "https://www.banestes.com.br/investimentos/pdf/publicitario_liquidez_referenciado.pdf", target = "_blank",
          "Relatório",
          class = "link"),
        tags$a(
          href = "https://www.banestes.com.br/investimentos/pdf/adesao_liquidez_referenciado.pdf", target = "_blank",
          "Termo de adesão",
          class = "link"),
      ),
      # fundo liquidez
      box(
          title = tags$div("Desempenho do Fundo", class = "box-graf"),
          closable = FALSE,
          collapsible = TRUE,
          collapsed = TRUE,
          width = 12,
          status = "warning",
          solidHeader = TRUE,
        tags$div("Fundo de Investimento Renda Fixa", class = "box-subtit"),
        tags$div("Variação % mensal", class = "box-body"),
        withSpinner(plotlyOutput(ns("plot3")), type = 1, color = "#004b8d", size = 1.5),
        tags$div("fonte: Banestes DTVM", style = "box-legenda"),
        footer = fluidRow(
          column(
            width = 12,
            descriptionBlock(
              number = scales::percent(head(tail(fundos$Liquidez$rentabilidade, 2), 1), 0.1),
              numberColor = if (head(tail(fundos$Liquidez$rentabilidade, 2), 1) >= 0) {
                "success"
              } else {
                "danger"
              },
              numberIcon = if (head(tail(fundos$Liquidez$rentabilidade, 2), 1) >= 0) {
                icon("fas fa-caret-up")
              } else {
                icon("fas fa-caret-down")
              },
              header = paste(scales::percent(tail(fundos$Liquidez$rentabilidade, 1), 0.1), "de rentabilidade acumulada"),
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
    
#' fundo_liquidez Server Functions
#'
#' @noRd
mod_fundo_liquidez_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    # plot fundo
    output$plot3 <- renderPlotly({
      plot_ly(
        data = fundos$Liquidez[1:nrow(fundos$Liquidez) - 1, ],
        x = ~as.Date(mes), y = ~rentabilidade_acum,
        type = "scatter", mode = "lines", name = "Fundo Banestes Liquidez", marker = list(color = "#004B8D")
      ) %>%
        add_trace(
          data = fundos$Liquidez[1:nrow(fundos$Liquidez) - 1, ],
          y = ~indice_acum, name = "CDI", marker = list(color = "#56af31"), line = list(color = "#56af31")
        ) %>%
        layout(
          title = "", xaxis = list(title = ""), yaxis = list(title = "rentabilidade", tickformat = ".1%"),
          xaxis = list(
            type = 'date',
            tickformat = "%b %Y"
          ),
           showlegend = TRUE,
          legend = list(orientation = 'h')
        )
    })
  })
}
    
## To be copied in the UI
# mod_fundo_liquidez_ui("fundo_liquidez_ui_1")
    
## To be copied in the server
# mod_fundo_liquidez_server("fundo_liquidez_ui_1")
