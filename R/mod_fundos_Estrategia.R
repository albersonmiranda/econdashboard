#' fundos_Estrategia UI Function
#'
#' @description  Modulo do fundo Estrategia
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_fundos_Estrategia_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidPage(
      fluidRow(
        
        # resenha
        box(
          title = tags$div("BANESTES ESTRATÉGIA", class = "res-tit"),
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
            HTML(resenhas_fundos$estrategia)
          ),
          tags$a(
            href="https://www.banestes.com.br/investimentos/pdf/lamina_estrategia.pdf",
            "lâmina",
            class = "link"),
          tags$a(
            href="https://www.banestes.com.br/investimentos/pdf/regulamento_estrategia.pdf",
            "regulamento",
            class = "link"),
          tags$a(
            href="https://www.banestes.com.br/investimentos/pdf/adesao_estrategia.pdf",
            "termo de adesão",
            class = "link"),
        ),
        
        
        
        # fundo estrategia
        box(
          title = tags$div("Gráfico de Performance", class = "box-graf"),
          closable = FALSE,
          collapsible = TRUE,
          collapsed = TRUE,
          width = 12,
          status = "warning",
          solidHeader = TRUE,
          tags$div("Fundo de Investimento Renda Fixa", class = "box-subtit"),
          tags$div("Variação % mensal", class = "box-body"),
          plotlyOutput(ns("plot1")),
          tags$div("fonte: Banestes DTVM", style = "box-legenda"),
          footer = fluidRow(
            column(
              width = 12,
              descriptionBlock(
                number = scales::percent(head(tail(fundos$Estrategia$rentabilidade, 2), 1), 0.1),
                numberColor = if (head(tail(fundos$Estrategia$rentabilidade, 2), 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (head(tail(fundos$Estrategia$rentabilidade, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste(scales::percent(tail(fundos$Estrategia$rentabilidade, 1), 0.1), "doze meses"),
                text = "rentabilidade acumulada",
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

    
#' fundos_Estrategia Server Functions
#'
#' @noRd 
mod_fundos_Estrategia_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    # plot fundo
    output$plot1 <- renderPlotly({
      plot_ly(
        data = fundos$Estrategia[1:nrow(fundos$Estrategia) - 1, ],
        x = ~ factor(mes, levels = fundos$Estrategia$mes), y = ~rentabilidade_acum,
        type = "scatter", mode = "lines", name = "Fundo Estratégia", marker = list(color = "#004B8D")
      ) %>%
        add_trace(
          data = fundos$Estrategia[1:nrow(fundos$Estrategia) - 1, ],
          y = ~variacao_cdi, name = "CDI", marker = list(color = "#56af31"), line = list(color = "#56af31")
        ) %>%
        layout(
          title = "", xaxis = list(title = ""), yaxis = list(title = "rentabilidade", tickformat = ".1%"),
          showlegend = TRUE,
          legend = list(orientation = 'h')
        )
    })
  })
}

## To be copied in the UI
# mod_fundos_Estrategia_ui("fundos_Estrategia_ui_1")
    
## To be copied in the server
# mod_fundos_Estrategia_server("fundos_Estrategia_ui_1")
