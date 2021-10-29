#' fundos_referencial UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_fundos_referencial_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidPage(
      fluidRow(
        
        # resenha
        box(
          title = tags$div("BANESTES REFERENCIAL FI", class = "res-tit"),
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
            HTML(resenhas_fundos$referencial)
          ),
          tags$a(
            href="https://www.banestes.com.br/investimentos/pdf/lamina_IRF_M1.pdf",
            "Lâmina",
            class = "link"),
          tags$a(
            href="https://www.banestes.com.br/investimentos/pdf/regulamento_investreferencial.pdf",
            "Regulamento",
            class = "link"),
          tags$a(
            href="https://www.banestes.com.br/investimentos/pdf/publicitario_IRF-M1.pdf",
            "Relatório",
            class = "link"),
          tags$a(
            href="https://www.banestes.com.br/investimentos/pdf/adesao_investreferencial.pdf",
            "Termo de adesão",
            class = "link"),
        ),
        
        # fundo referencial
        box(
          title = tags$div("Desempenho do Fundo", class = "box-graf"),
          closable = FALSE,
          collapsible = TRUE,
          collapsed = TRUE,
          width = 12,
          status = "warning",
          solidHeader = TRUE,
          tags$div("Fundo de Investimento Renda Fixa IRF-M 1", class = "box-subtit"),
          tags$div("Variação % mensal", class = "box-body"),
          plotlyOutput(ns("plot1")),
          tags$div("fonte: Banestes DTVM", style = "box-legenda"),
          footer = fluidRow(
            column(
              width = 12,
              descriptionBlock(
                number = scales::percent(head(tail(fundos$IRF_M1$rentabilidade, 2), 1), 0.1),
                numberColor = if (head(tail(fundos$IRF_M1$rentabilidade, 2), 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (head(tail(fundos$IRF_M1$rentabilidade, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste(scales::percent(tail(fundos$IRF_M1$rentabilidade, 1), 0.1), "doze meses"),
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

    
#' fundos_referencial Server Functions
#'
#' @noRd 
mod_fundos_referencial_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    # plot fundo
    output$plot1 <- renderPlotly({
      plot_ly(
        data = fundos$IRF_M1[1:nrow(fundos$IRF_M1) - 1, ], 
        x = ~as.Date(mes), y = ~rentabilidade_acum,
        type = "scatter", mode = "lines", name = "Fundo Banestes Referencial", marker = list(color = "#004B8D")
      ) %>%
        add_trace(
          data = fundos$IRF_M1[1:nrow(fundos$IRF_M1) - 1, ],
          y = ~indice_acum, name = "IRF-M 1", marker = list(color = "#56af31"), line = list(color = "#56af31")
        ) %>%
        layout(
          title = "", xaxis = list(title = ""),
          yaxis = list(
            title = "rentabilidade", tickformat = ".1%"
          ),
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
# mod_fundos_referencial_ui("fundos_referencial_ui_1")
    
## To be copied in the server
# mod_fundos_referencial_server("fundos_referencial_ui_1")
