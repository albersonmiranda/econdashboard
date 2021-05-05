#' setor_publico UI Function
#'
#' @description Módulo de Setor Público Capixaba.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_conj_setor_publico_ui <- function(id) {
  ns <- NS(id)
  tagList(
    fluidPage(
      fluidRow(

        # Resenha
        box(
          title = tags$div("SETOR PÚBLICO CAPIXABA", class = "res-tit"),
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

        # Resultado primário ES
        box(
          title = tags$div("NFSP", class = "box-tit"),
          closable = FALSE,
          width = 4,
          height = 760,
          status = "warning",
          solidHeader = TRUE,
          tags$div("Resultado Primário", class = "box-subtit"),
          tags$div("Fluxo acumulado no ano, Estado e municípios, trimestral", class = "box-body"),
          plotlyOutput(ns("plot1")),
          tags$div("Fonte: Banco Central do Brasil", class = "box-legenda"),
          tags$div("Lorem ipsum dolor sit amet, porttitor eu amet etiam ridiculus praesent nam sed.", class = "box-body"),
          footer = fluidRow(
            column(
              width = 12,
              descriptionBlock(
                number = paste("R$", round(
                  (tail(series$ResultadoES$value, 1) - head(tail(series$ResultadoES$value, 2), 1)), 1
                ), "mi"),
                numberColor = if (tail(series$ResultadoES$value, 1) - head(tail(series$ResultadoES$value, 2), 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (tail(series$ResultadoES$value, 1) - head(tail(series$ResultadoES$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste("R$", round(tail(series$ResultadoES$value, 1), 1), "mi", tail(months(series$ResultadoES$date), 1)),
                text = "Resultado Primário",
                rightBorder = FALSE,
                marginBottom = FALSE
              )
            )
          )
        ),

        # Dívida Líquida ES
        box(
          title = tags$div("NFSP", class = "box-tit"),
          closable = FALSE,
          width = 4,
          height = 760,
          status = "warning",
          solidHeader = TRUE,
          tags$div("Dívida líquida", class = "box-subtit"),
          tags$div("Dívida líquida consolidada, Estado e municípios, trimestral", class = "box-body"),
          plotlyOutput(ns("plot2")),
          tags$div("Fonte: Banco Central do Brasil", class = "box-legenda"),
          tags$div("Lorem ipsum dolor sit amet, porttitor eu amet etiam ridiculus praesent nam sed.", class = "box-body"),
          footer = fluidRow(
            column(
              width = 12,
              descriptionBlock(
                number = paste("R$", round(
                  (tail(series$DividaES$value, 1) - head(tail(series$DividaES$value, 2), 1)), 1
                ), "mi"),
                numberColor = if (tail(series$DividaES$value, 1) - head(tail(series$DividaES$value, 2), 1) >= 0) {
                  "danger"
                } else {
                  "success"
                },
                numberIcon = if (tail(series$DividaES$value, 1) - head(tail(series$DividaES$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste("R$", round(tail(series$DividaES$value, 1), 1), "mi", tail(months(series$DividaES$date), 1)),
                text = "Dívida Líquida Consolidada",
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

#' setor_publico Server Function
#'
#' @noRd
mod_conj_setor_publico_server <- function(input, output, session) {
  ns <- session$ns

  # resultado primário do ES
  output$plot1 <- renderPlotly({
    plot_ly(
      data = series$ResultadoES,
      x = ~date, y = ~value,
      type = "scatter", mode = "lines", name = "Resultado Primário"
    ) %>%
      layout(
        title = "", xaxis = list(title = ""), yaxis = list(title = "R$ mi"),
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center"
        )
      )
  })

  # Dívida líquida consolidada ES
  output$plot2 <- renderPlotly({
    plot_ly(
      data = series$DividaES,
      x = ~date, y = ~value,
      type = "scatter", mode = "lines", name = "Dívida Líquida"
    ) %>%
      layout(
        title = "", xaxis = list(title = ""), yaxis = list(title = "R$ mi"),
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center"
        )
      )
  })
}

## To be copied in the UI
# mod_setor_publico_ui("setor_publico_ui_1")

## To be copied in the server
# callModule(mod_setor_publico_server, "setor_publico_ui_1")