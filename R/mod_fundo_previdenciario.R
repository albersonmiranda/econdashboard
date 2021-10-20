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
      
      #resenha 
      box(
        title = tags$div("BANESTES PREVIDENCIÁRIO RF", class = "res-tit"),
        closable = FALSE,
        width = 4,
        height = 760,
        status = NULL,
        background = "yellow",
        solidHeader = TRUE,
        enable_dropdown = FALSE,
        tags$div(
          class = "res-body",
          p("Lorem ipsum dolor sit amet, porttitor eu amet etiam ridiculus praesent nam sed. Inceptos fermentum nibh. Lorem ipsum dolor sit amet, porttitor eu amet etiam ridiculus praesent nam sed. Inceptos fermentum nibh. Lorem ipsum dolor sit amet, porttitor eu amet etiam ridiculus praesent nam sed. Inceptos fermentum nibh. Lorem ipsum dolor sit amet, porttitor eu amet etiam ridiculus praesent nam sed. Inceptos fermentum nibh."),
          p("Lorem ipsum dolor sit amet, porttitor eu amet etiam ridiculus praesent nam sed. Inceptos fermentum nibh. Lorem ipsum dolor sit amet, porttitor eu amet etiam ridiculus praesent nam sed. Inceptos fermentum nibh. Lorem ipsum dolor sit amet, porttitor eu amet etiam ridiculus praesent nam sed. Inceptos fermentum nibh. Lorem ipsum dolor sit amet, porttitor eu amet etiam ridiculus praesent nam sed. Inceptos fermentum nibh.")
        )
      ), 
      
      #fundo previdenciario
      box(
        title = tags$div("BANESTES PREVIDENCIÁRIO RF", class = "box-tit"),
        closable = FALSE,
        width = 8,
        height = 760,
        status = "warning",
        solidHeader = TRUE,
        tags$div("Fundo de Investimento Renda Fixa", class = "box-subtit"),
        tags$div("Variação % mensal", class = "box-body"),
        plotlyOutput(ns("plot2")),
        tags$div("fonte: Banestes DTVM", style = "box-legenda"),
        tags$div("Informações adicionais sobre o fundo (investimento mínimo, liquidez etc)", style = "box-body"),
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
              header = paste(scales::percent(tail(fundos$Previdenciario$rentabilidade, 1), 0.1), "doze meses"),
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
        x = ~ factor(mes, levels = fundos$Previdenciario$mes), y = ~rentabilidade_acum,
        type = "scatter", mode = "lines", name = "Rentabilidade", marker = list(color = "#004B8D")
      ) %>%
        add_trace(
          data = fundos$Previdenciario[1:nrow(fundos$Previdenciario) - 1, ],
          y = ~variacao_cdi, name = "CDI", marker = list(color = "#56af31"), line = list(color = "#56af31")
        ) %>%
        layout(
          title = "", xaxis = list(title = ""), yaxis = list(title = "rentabilidade", tickformat = ".1%"),
          showlegend = FALSE
        )
    })
 
  })
}
    
## To be copied in the UI
# mod_fundo_previdenciario_ui("fundo_previdenciario_ui_1")
    
## To be copied in the server
# mod_fundo_previdenciario_server("fundo_previdenciario_ui_1")
