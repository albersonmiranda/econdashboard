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
          collapsed = TRUE,
          width = 12,
          status = "warning",
          background = "yellow",
          solidHeader = TRUE,
          enable_dropdown = FALSE,
          mainPanel(
            tabsetPanel(
              tabPanel("2021", tags$a("Relatório de Conjuntura", href="www/relatorios/relatorio.pdf", target="_blank"))
            )
          )
        ),

        # Resultado primário ES
        box(
          title = tags$div("Resultado Primário", class = "box-tit"),
          closable = FALSE,
          width = 4,
          height = 760,
          status = "warning",
          solidHeader = TRUE,
          tags$div("Necessidade de financiamento do Estado do ES e municípios", class = "box-subtit"),
          tags$div("Fluxo acumulado no ano, trimestral", class = "box-body"),
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
          title = tags$div("Dívida líquida", class = "box-tit"),
          closable = FALSE,
          width = 4,
          height = 760,
          status = "warning",
          solidHeader = TRUE,
          tags$div("Dívida líquida consolidada do Estado do ES e municípios", class = "box-subtit"),
          tags$div("Trimestral", class = "box-body"),
          plotlyOutput(ns("plot2")),
          tags$div("Fonte: Banco Central do Brasil", class = "box-legenda"),
          tags$div("Após uma queda significativa em 2019, a dívida líquida capixaba voltou a crescer em 2020", class = "box-body"),
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