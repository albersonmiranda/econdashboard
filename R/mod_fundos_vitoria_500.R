#' fundos_vitoria_500 UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_fundos_vitoria_500_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidPage(
      fluidRow(
        
        # resenha
        box(
          title = tags$div("BANESTES VITÓRIA 500", class = "res-tit"),
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
            HTML(resenhas_fundos$vitoria500)),
          
          tags$a(
            href="https://www.banestes.com.br/investimentos/pdf/lamina_Vitoria_500.pdf",
            "Lâmina",
            class = "link"),
          tags$a(
            href="https://www.banestes.com.br/investimentos/pdf/regulamento-vitoria-500.pdf",
            "Regulamento",
            class = "link"),
          tags$a(
            href="https://www.banestes.com.br/investimentos/pdf/adesao-vitoria-500.pdf",
            "Termo de adesão",
            class = "link"),
        ),
        
        # fundo vitória 500
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
          plotlyOutput(ns("plot1")),
          tags$div("fonte: Banestes DTVM", style = "box-legenda"),
          footer = fluidRow(
            column(
              width = 12,
              descriptionBlock(
                text = "rentabilidade acumulada",
                number = scales::percent(head(tail(fundos$Vitoria_500$rentabilidade, 2), 1), 0.1),
                numberColor = if (head(tail(fundos$Vitoria_500$rentabilidade, 2), 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (head(tail(fundos$Vitoria_500$rentabilidade, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste(scales::percent(tail(fundos$Vitoria_500$rentabilidade, 1), 0.1), "doze meses"),
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

#' fundos_vitoria_500 Server Functions
#'
#' @noRd 
mod_fundos_vitoria_500_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
    # plot fundo
    output$plot1 <- renderPlotly({
      plot_ly(
        data = fundos$Vitoria_500[1:nrow(fundos$Vitoria_500) - 1, ], 
        x = ~as.Date(mes), y = ~rentabilidade_acum,
        type = "scatter", mode = "lines", name = "Fundo Banestes Vitória 500", marker = list(color = "#004B8D")
      ) %>%
        add_trace(
          data = fundos$Vitoria_500[1:nrow(fundos$Vitoria_500) - 1, ],
          y = ~indice_acum, name = "CDI", marker = list(color = "#56af31"), line = list(color = "#56af31")
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
# mod_fundos_vitoria_500_ui("fundos_vitoria_500_ui_1")
    
## To be copied in the server
# mod_fundos_vitoria_500_server("fundos_vitoria_500_ui_1")
