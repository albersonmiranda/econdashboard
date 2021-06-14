#' fundos_overview UI Function
#'
#' @description A shiny Module.
#'
#' @param id, input, output, session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_fundos_overview_ui <- function(id) {
  ns <- NS(id)
  tagList(
    fluidPage(
      fluidRow(

        # resenha
        box(
          title = tags$div("BANESTES INSTITUCIONAL RF", class = "res-tit"),
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

        # fundo institucional
        box(
          title = tags$div("BANESTES INSTITUCIONAL RF", class = "box-tit"),
          closable = FALSE,
          width = 8,
          height = 760,
          status = "warning",
          solidHeader = TRUE,
          tags$div("Fundo de Investimento Renda Fixa", class = "box-subtit"),
          tags$div("Variação % mensal", class = "box-body"),
          plotlyOutput(ns("plot1")),
          tags$div("alguma legenda", style = "box-legenda"),
          tags$div("Informações adicionais sobre o fundo (investimento mínimo, liquidez etc)", style = "box-body"),
          footer = fluidRow(
            column(
              width = 12,
              descriptionBlock(
                number = paste(round(
                  tail(series$PIBvar$value, 1), 2
                ), "%"),
                numberColor = if (tail(series$PIBvar$value, 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (tail(series$PIBvar$value, 1) >= 0) {
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
        )
      )
    )
  )
}
    
#' fundos_overview Server Functions
#'
#' @noRd
mod_fundos_overview_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    # PIB variação anual
    output$plot1 <- renderPlotly({
      plot_ly(
        data = fundos$Institucional[1:nrow(fundos$Institucional) - 1,],
        x = ~factor(mes, levels = fundos$Institucional$mes), y = ~rentabilidade,
        type = "scatter", mode = "lines", name = "Rentabilidade", marker = list(color = "#004B8D")
      ) %>%
        add_trace(
          data = fundos$Investidor[1:nrow(fundos$Investidor)-1,],
          y = ~variacao_cdi, name = "CDI", marker = list(color = "#56af31"), line = list(color = "#56af31")
        ) %>%
        layout(
          title = "", xaxis = list(title = ""), yaxis = list(title = "Variação %")
        )
    })
  })
}
    
## To be copied in the UI
# mod_fundos_overview_ui("fundos_overview_ui_1")
    
## To be copied in the server
# mod_fundos_overview_server("fundos_overview_ui_1")
