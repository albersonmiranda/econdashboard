#' fundos_btg UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_fundos_btg_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidPage(
      fluidRow(
        
        # resenha
        box(
          title = tags$div("BANESTES FIC de FI de AÇÕES BTG PACTUAL", class = "res-tit"),
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
            HTML(resenhas_fundos$btg)
          ),
          tags$a(
            href="https://www.banestes.com.br/investimentos/pdf/lamina_BTG_Pactual_Absoluto.pdf",
            "Lâmina",
            class = "link"),
          tags$a(
            href="https://www.banestes.com.br/investimentos/pdf/regulamento_btg.pdf",
            "Regulamento",
            class = "link"),
          tags$a(
            href="https://www.banestes.com.br/investimentos/pdf/publicitario_btg.pdf",
            "Relatório",
            class = "link"),
          tags$a(
            href="https://www.banestes.com.br/investimentos/pdf/adesao_btg.pdf",
            "Termo de adesão",
            class = "link"),
        ),
        
        # fundo de ações btg pactual
        box(
          title = tags$div("Desempenho do Fundo", class = "box-graf"),
          closable = FALSE,
          collapsible = TRUE,
          collapsed = TRUE,
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
                number = scales::percent(head(tail(fundos$BTG_Pactual_Absoluto$rentabilidade, 2), 1), 0.1),
                numberColor = if (head(tail(fundos$BTG_Pactual_Absoluto$rentabilidade, 2), 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (head(tail(fundos$BTG_Pactual_Absolu$rentabilidade, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste(scales::percent(tail(fundos$BTG_Pactual_Absoluto$rentabilidade, 1), 0.1), "doze meses"),
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



#' fundos_btg Server Functions
#'
#' @noRd 
mod_fundos_btg_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
    # plot fundo
    output$plot1 <- renderPlotly({
      plot_ly(
        data = fundos$BTG_Pactual_Absoluto[1:nrow(fundos$BTG_Pactual_Absoluto) - 1, ], 
        x = ~as.Date(mes), y = ~rentabilidade_acum,
        type = "scatter", mode = "lines", name = "Fundo Banestes de Ações BTG", marker = list(color = "#004B8D")
      ) %>%
        add_trace(
          data = fundos$BTG_Pactual_Absoluto[1:nrow(fundos$BTG_Pactual_Absoluto) - 1, ],
          y = ~indice_acum, name = "IBOVESPA", marker = list(color = "#56af31"), line = list(color = "#56af31")
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
# mod_fundos_btg_ui("fundos_btg_ui_1")
    
## To be copied in the server
# mod_fundos_btg_server("fundos_btg_ui_1")
