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
    fluidPage(titlePanel(h1("SETOR PÚBLICO CAPIXABA")),
      fluidRow(

        # Resenha
        box(
          closable = FALSE,
          width = 12,
          status = NULL,
          background = "yellow",
          solidHeader = TRUE,
          enable_dropdown = FALSE,
          tags$div(
            class = "res-body",
            HTML(tail(resenhas_conjuntura$setorpublico.es, 1))
          )
        ),

        #Relatorios
        box(
          title = tags$div("Relatórios", class = "box-tit"),
          closable = FALSE,
          collapsible = TRUE,
          collapsed = FALSE,
          width = 12,
          status = "warning",
          background = "yellow",
          solidHeader = TRUE,
          enable_dropdown = FALSE,
          mainPanel(
            tabsetPanel(
              tabPanel("2021",
              tags$a("2° Trimestre",
              href = "www/relatorios/politica-fiscal-es/2021/012/politica-fiscal-es.pdf",
              target = "_blank"))
            )
          )
        ),

        # Resultado primário ES
        box(
          title = tags$div("Resultado Primário", class = "box-tit"),
          closable = FALSE,
          width = 6,
          height = 760,
          status = "warning",
          solidHeader = TRUE,
          tags$div("Necessidade de financiamento do Estado do ES e municípios", class = "box-subtit"),
          tags$div("Fluxo acumulado no ano, trimestral", class = "box-body"),
          withSpinner(plotlyOutput(ns("plot1")), type = 1, color = "#004b8d", size = 1.5),
          tags$div("Fonte: Banco Central do Brasil", class = "box-legenda"),
          tags$div(
            HTML(
              ifelse(
                is.na(tail(legenda_conjuntura$primario.es, 1)),
                "",
                tail(legenda_conjuntura$primario.es, 1)
              )
            ),
                class = "box-body"),
          footer = fluidRow(
            column(
              width = 12,
              descriptionBlock(
                number = paste("R$", round(
                  (tail(series$ResultadoES$value, 1) - head(tail(series$ResultadoES$value, 2), 1)), 1
                ), "mi"),
                numberColor = if (tail(series$ResultadoES$value, 1) - head(tail(series$ResultadoES$value, 2), 1) >= 0) {
                  "danger"
                } else {
                  "success"
                },
                numberIcon = if (tail(series$ResultadoES$value, 1) - head(tail(series$ResultadoES$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste0(" R$", round(tail(series$ResultadoES$value, 1), 1), " mi", " (", tail(months(series$ResultadoES$date), 1), ")"),
                text = "Resultado Primário",
                rightBorder = FALSE,
                marginBottom = FALSE
              )
            )
          )
        ),

        # Dívida Líquida ES
        box(
          title = tags$div("Dívida líquida", class = "box-tit"),
          closable = FALSE,
          width = 6,
          height = 760,
          status = "warning",
          solidHeader = TRUE,
          tags$div("Dívida líquida consolidada do Estado do ES e municípios", class = "box-subtit"),
          tags$div("Trimestral", class = "box-body"),
          withSpinner(plotlyOutput(ns("plot2")), type = 1, color = "#004b8d", size = 1.5),
          tags$div("Fonte: Banco Central do Brasil", class = "box-legenda"),
          tags$div(
            HTML(
              ifelse(
              is.na(tail(legenda_conjuntura$div.liq.es, 1)),
              "",
              tail(legenda_conjuntura$div.liq.es, 1)
              )
            ),
            class = "box-body"),
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
                header = paste0(" R$", round(tail(series$DividaES$value, 1), 1), " mi", " (", tail(months(series$DividaES$date), 1), ")"),
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
      type = "scatter", mode = "lines", name = "Resultado Primário", line = list(color = "#004B8D")
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
      type = "scatter", mode = "lines", name = "Dívida Líquida", line = list(color = "#004B8D")
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