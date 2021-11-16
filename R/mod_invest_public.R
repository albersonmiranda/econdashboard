#' invest_public UI Function
#'
#' @description Módulo do fundo Invest Public Banestes.
#'
#' @param id, input, output, session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_invest_public_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidPage(
      fluidRow(
        
        # resenha 
        box(
          title = tags$div("BANESTES INVEST PUBLIC AUTOMÁTICO FI", class = "res-tit"),
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
            HTML(resenhas_fundos$investpublic)
          ),
         
          
           tags$a(
            href="https://www.banestes.com.br/investimentos/pdf/lamina_Invest_Public.pdf", target="_blank",
            "Lâmina",
            class = "link"),
          tags$a(
          href="https://www.banestes.com.br/investimentos/pdf/regulamento_investpublic.pdf", target="_blank",
        "Regulamento",
            class = "link"),
          tags$a(
            href="https://www.banestes.com.br/investimentos/pdf/adesao_investpublic.pdf", target="_blank",
            "Termo de adesão",
            class = "link"),
        ),
        
        
        
      #fundo Invest Public
      box(
        title = tags$div("Desempenho do Fundo", class = "box-graf"),
        closable = FALSE,
        collapsible = TRUE,
        collapsed = TRUE,
        width = 12,
        status = "warning",
        solidHeader = TRUE,
        tags$div("Fundo de Investimento em Renda Fixa", class = "box-subtit"),
        tags$div("Variação % mensal", class = "box-body"),
        plotlyOutput(ns("plot1")),
        tags$div("fonte: Banestes DTVM", style = "box-legenda"),
       
        footer = fluidRow(
          column(
            width = 12,
            descriptionBlock(
              number = scales::percent(head(tail(fundos$Invest_Public$rentabilidade, 2),1), 0.1),
              numberColor = if (head(tail(fundos$Invest_Public$rentabilidade, 2), 1) >= 0) {
                "success"
              } else {
                "danger"
              },
              numberIcon = if (head(tail(fundos$Invest_Public$rentabilidade, 2), 1) >= 0) {
                icon("fas fa-caret-up")
              } else {
                icon("fas fa-caret-down")
              },
              header = paste(scales::percent(tail(fundos$Invest_Public$rentabilidade, 1), 0.1), "de rentabilidade acumulada"),
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
    
#' invest_public Server Functions
#'
#' @noRd 
mod_invest_public_server <- function(id){
  moduleServer( id, function(input, output, session) {
    ns <- session$ns
 
    #plot fundo Invest Public
    output$plot1 <- renderPlotly({
      plot_ly(
        data = fundos$Invest_Public[1:nrow(fundos$Invest_Public) - 1, ],
        x = ~as.Date(mes), y = ~rentabilidade_acum,
        type = "scatter", mode = "lines", name = "Fundo Banestes Invest Public", marker = list(color = "#004B8D")
      ) %>%
        add_trace(
          data = fundos$Invest_Public[1:nrow(fundos$Invest_Public) - 1, ],
          y = ~indice_acum, name = "CDI", marker = list(color = "#56af31"), line = list(color = "#56af31")
        ) %>%
        layout(
          title = "", xaxis = list(title = ""), yaxis = list(title = "rentabilidade", tickformat = ".1%"),
          xaxis = list(
            type = 'date',
            tickformat = "%b %Y"),
           showlegend = TRUE,
          legend = list(orientation = 'h')
        )
    })
  })
}


## To be copied in the UI
# mod_invest_public_ui("invest_public_ui_1")
    
## To be copied in the server
# mod_invest_public_server("invest_public_ui_1")
