#' inflacao UI Function
#'
#' @description Modulo de informações de conjuntura relacionadas à inflação.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList

mod_conj_inflacao_ui <- function(id) {
  ns <- NS(id)
  tagList(
    fluidPage(titlePanel(h1("INFLAÇÃO")),
      fluidRow(

        # Resenha
        box(
          closable = FALSE,
          width = 12,
          status = NULL,
          background = "yellow",
          solidHeader = TRUE,
          collapsible = FALSE,
          enable_dropdown = FALSE,
          tags$div(
            class = "res-body",
            HTML(tail(resenhas_conjuntura$inflacao, 1))
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
              tabPanel("2021", tags$a("Novembro", href="www/relatorios/inflacao/2021/11/inflacao.pdf", target="_blank"))
            )
          )
        ),

        # Capacidade Instalada
        box(
          title = tags$div("Capacidade Instalada", class = "box-tit"),
          closable = FALSE,
          width = 4,
          height = 855,
          status = "warning",
          solidHeader = TRUE,
          collapsible = FALSE,
          enable_dropdown = FALSE,
          tags$div("Utilização da Capacidade Instalada", class = "box-subtit"),
          tags$div("%, trimestral", class = "box-body"),
          plotlyOutput(ns("plot3")),
          tags$div("Fonte: FGV", class = "box-legenda"),
          tags$div(HTML(
            ifelse( 
              is.na(tail(legenda_conjuntura$capac.inst, 1)),
              "",
              tail(legenda_conjuntura$capac.inst, 1)
            )
          ),
              style = "box-body"),
          footer = fluidRow(
            column(
              width = 12,
              descriptionBlock(
                number = paste(round(
                  tail(series$CapInst$value, 1) - head(tail(series$CapInst$value, 2), 1), 2
                ), "pts"),
                numberColor = if (tail(series$CapInst$value, 1) - head(tail(series$CapInst$value, 2), 1) >= 0) {
                  "danger"
                } else {
                  "success"
                },
                numberIcon = if (tail(series$CapInst$value, 1) - head(tail(series$CapInst$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon(icon(icon("fas fa-caret-down")))
                },
                header = paste0(tail(series$CapInst$value, 1), "%", " (", tail(months(series$CapInst$date), 1), ")"),
                text = "Capacidade Instalada",
                rightBorder = FALSE,
                marginBottom = FALSE
              )
            )
          )
        ),

        # Cesta Básica Vitória
        box(
          title = tags$div("Cesta Básica", class = "box-tit"),
          closable = FALSE,
          width = 4,
          height = 855,
          status = "warning",
          solidHeader = TRUE,
          collapsible = FALSE,
          enable_dropdown = FALSE,
          tags$div("Custo da Cesta Básica", class = "box-subtit"),
          tags$div("Vitória-ES, índice, mensal", class = "box-body"),
          plotlyOutput(ns("plot2")),
          tags$div("Fonte: DIEESE", class = "box-legenda"),
          tags$div(
            HTML(
              ifelse(
                is.na(tail(legenda_conjuntura$cestabasica, 1)),
                "",
                tail(legenda_conjuntura$cestabasica, 1)
                )
              ), 
            class = "box-body"
          ),
          footer = fluidRow(
            column(
              width = 12,
              descriptionBlock(
                number = paste(round(
                  tail(series$CestaES$value, 1) - head(tail(series$CestaES$value, 2), 1), 2
                ), "pts"),
                numberColor = if (tail(series$CestaES$value, 1) - head(tail(series$CestaES$value, 2), 1) >= 0) {
                  "danger"
                } else {
                  "success"
                },
                numberIcon = if (tail(series$CestaES$value, 1) - head(tail(series$CestaES$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon(icon(icon("fas fa-caret-down")))
                },
                header = paste0(tail(series$CestaES$value, 1), " pts", " (", tail(months(series$CestaES$date), 1), ")"),
                text = "Cesta Básica",
                rightBorder = FALSE,
                marginBottom = FALSE
              )
            )
          )
        ),

        # Inflação
        box(
          title = tags$div("Inflação", class = "box-tit"),
          closable = FALSE,
          width = 12,
          #height = 855,
          status = "warning",
          solidHeader = TRUE,
          tags$div("Índices de preços", class = "box-subtit"),
          tags$div("Variação percentual, mensal", class = "box-body"),
          plotlyOutput(ns("plot1")),
          tags$div("Fonte: IBGE, FGV e DIEESE", class = "box-legenda"),
          tags$div( 
            HTML(
              ifelse(
                is.na(tail(legenda_conjuntura$inflacao, 1)), 
                "", 
                tail(legenda_conjuntura$inflacao, 1)
              )
            ), 
            class = "box-body"),
          footer = fluidRow(
            column(
              width = 3,
              descriptionBlock(
                number = paste(round(
                  tail(series$IPCA$value, 1) - head(tail(series$IPCA$value, 2), 1), 2
                ), "pts"),
                numberColor = if (tail(series$IPCA$value, 1) - head(tail(series$IPCA$value, 2), 1) >= 0) {
                  "danger"
                } else {
                  "success"
                },
                numberIcon = if (tail(series$IPCA$value, 1) - head(tail(series$IPCA$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon(icon(icon("fas fa-caret-down")))
                },
                header = paste0(tail(series$IPCA$value, 1), " (", tail(months(series$IPCA$date), 1), ")"),
                text = "IPCA",
                rightBorder = TRUE,
                marginBottom = FALSE
              )
            ), column(
              width = 3,
              descriptionBlock(
                number = paste(round(
                  tail(series$IGPM$value, 1) - head(tail(series$IGPM$value, 2), 1), 2
                ), "pts"),
                numberColor = if (tail(series$IGPM$value, 1) - head(tail(series$IGPM$value, 2), 1) >= 0) {
                  "danger"
                } else {
                  "success"
                },
                numberIcon = if (tail(series$IGPM$value, 1) - head(tail(series$IGPM$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon(icon(icon("fas fa-caret-down")))
                },
                header = paste0(tail(series$IGPM$value, 1), " (", tail(months(series$IGPM$date), 1), ")"),
                text = "IGPM",
                rightBorder = TRUE,
                marginBottom = FALSE
              )
            ), column(
              width = 3,
              descriptionBlock(
                number = paste(round(
                  tail(series$IPCBr$value, 1) - head(tail(series$IPCBr$value, 2), 1), 2
                ), "pts"),
                numberColor = if (tail(series$IPCBr$value, 1) - head(tail(series$IPCBr$value, 2), 1) >= 0) {
                  "danger"
                } else {
                  "success"
                },
                numberIcon = if (tail(series$IPCBr$value, 1) - head(tail(series$IPCBr$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon(icon(icon("fas fa-caret-down")))
                },
                header = paste0(tail(series$IPCBr$value, 1), " (", tail(months(series$IPCBr$date), 1), ")"),
                text = "IPCBr",
                rightBorder = TRUE,
                marginBottom = FALSE
              )
            ), column(
              width = 3,
              descriptionBlock(
                number = paste(round(
                  tail(series$ICV$value, 1) - head(tail(series$ICV$value, 2), 1), 2
                ), "pts"),
                numberColor = if (tail(series$ICV$value, 1) - head(tail(series$ICV$value, 2), 1) >= 0) {
                  "danger"
                } else {
                  "success"
                },
                numberIcon = if (tail(series$ICV$value, 1) - head(tail(series$ICV$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon(icon(icon("fas fa-caret-down")))
                },
                header = paste0(tail(series$ICV$value, 1), " (", tail(months(series$ICV$date), 1), ")"),
                text = "ICV",
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


#' inflacao Server Function
#'
#' @noRd
mod_conj_inflacao_server <- function(input, output, session) {
  ns <- session$ns

  # Inflação
  output$plot1 <- renderPlotly({
    plot_ly(
      data = series$IPCA, x = ~date, y = ~value,
      type = "scatter", mode = "lines", name = "IPCA", line = list(color = "#004B8D")
    ) %>%
      add_trace(series$IGPM, x = series$IGPM$date, y = series$IGPM$value, name = "IGPM", mode = "lines", line = list(color = "#56af31")) %>%
      add_trace(series$IPCBr, x = series$IPCBr$date, y = series$IPCBr$value, name = "IPCBr", mode = "lines", line = list(color = "#79bce7")) %>%
      add_trace(series$ICV, x = series$ICV$date, y = series$ICV$value, name = "ICV", mode = "lines", line = list(color = "e7d8ac")) %>%
      layout(
        title = "", xaxis = list(title = ""), yaxis = list(title = "Variação %"),
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center"
        )
      )
  })

  # Cesta Básica Vitória
  output$plot2 <- renderPlotly({
    plot_ly(
      data = series$CestaES, x = ~date, y = ~value,
      type = "scatter", mode = "lines", name = "Cesta Básica Vitória", line = list(color = "#004B8D")
    ) %>%
      layout(
        title = "", xaxis = list(title = ""), yaxis = list(title = "Indice"),
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center"
        )
      )
  })

  # Capacidade Instalada
  output$plot3 <- renderPlotly({
    plot_ly(
      data = series$CapInst, x = ~date, y = ~value,
      type = "scatter", mode = "lines", name = "Capacidade Instalada", line = list(color = "#004B8D")
    ) %>%
      layout(
        title = "", xaxis = list(title = ""), yaxis = list(title = "%"),
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center"
        )
      )
  })
}

## To be copied in the UI
# mod_inflacao_ui("inflacao_ui_1")

## To be copied in the server
# callModule(mod_inflacao_server, "inflacao_ui_1")