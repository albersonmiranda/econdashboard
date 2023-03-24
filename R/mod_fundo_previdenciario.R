#' fundo_previdenciario UI Function
#'
#' @description Módulo do fundo previdenciário Banestes.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_fundo_previdenciario_ui <- function(id){
  ns <- NS(id)
  tagList(fluidPage(
    fluidRow(
      
      # resenha
      box(
        title = tags$div("BANESTES PREVIDENCIÁRIO FI ", class = "res-tit"),
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
          HTML(resenhas_fundos$previdenciario)
        ),
        tags$a(
          href="https://www.banestes.com.br/investimentos/pdf/lamina_Previdenciario.pdf", target="_blank",
          "Lâmina",
          class = "link"),
        tags$a(
          href="https://www.banestes.com.br/investimentos/pdf/regulamento_previdenciario.pdf", target="_blank",
          "Regulamento",
          class = "link"),
        tags$a(
          href="https://www.banestes.com.br/investimentos/pdf/publicitario_PREVIDENCIARIO.pdf", target="_blank",
          "Relatório",
          class = "link"),
        tags$a(
          href="https://www.banestes.com.br/investimentos/pdf/adesao_previdenciario.pdf", target="_blank",
          "Termo de adesão",
          class = "link"),
      ),
      
      #fundo previdenciario
      box(
        title = tags$div("Desempenho do Fundo", class = "box-graf"),
        closable = FALSE,
        collapsible = TRUE,
        collapsed = FALSE,
        width = 12,
        status = "warning",
        solidHeader = TRUE,
        tags$div("Fundo de Investimento Renda Fixa", class = "box-subtit"),
        tags$div("Variação % mensal", class = "box-body"),
        plotlyOutput(ns("plot2")),
        tags$div("fonte: Banestes DTVM", style = "box-legenda"),
        footer = fluidRow(
          column(
            width = 12,
            descriptionBlock(
              number = scales::percent(head(tail(fundos$Previdenciario$rentabilidade, 2),1), 0.1),
              numberColor = if (head(tail(fundos$Previdenciario$rentabilidade, 2), 1) >= 0) {
                "success"
              } else {
                "danger"
              },
              numberIcon = if (head(tail(fundos$Previdenciario$rentabilidade, 2), 1) >= 0) {
                icon("fas fa-caret-up")
              } else {
                icon("fas fa-caret-down")
              },
              header = paste(scales::percent(tail(fundos$Previdenciario$rentabilidade, 1), 0.1), "de rentabilidade acumulada"),
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


#' fundo_previdenciario Server Functions
#'
#' @noRd 
mod_fundo_previdenciario_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    # plot fundo
    output$plot2 <- renderPlotly({
      plot_ly(
        data = fundos$Previdenciario[1:nrow(fundos$Previdenciario) - 1, ],
        x = ~as.Date(mes), y = ~rentabilidade_acum,
        type = "scatter", mode = "lines", name = "Fundo Banestes Previdenciário", marker = list(color = "#004B8D")
      ) %>%
        add_trace(
          data = fundos$Previdenciario[1:nrow(fundos$Previdenciario) - 1, ],
          y = ~indice_acum, name = "IMA-B", marker = list(color = "#56af31"), line = list(color = "#56af31")
        ) %>%
        layout(
          title = "", xaxis = list(title = ""), yaxis = list(title = "rentabilidade", tickformat = ".1%"),
          xaxis = list(
            type = 'date',
            tickformat = "%b %Y"
          ),showlegend = TRUE,
          legend = list(orientation = 'h')
        )
    })
    
  })
}

## To be copied in the UI
# mod_fundo_previdenciario_ui("fundo_previdenciario_ui_1")

## To be copied in the server
# mod_fundo_previdenciario_server("fundo_previdenciario_ui_1")
