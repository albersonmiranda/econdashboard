#' consumo UI Function
#'
#' @description modulo de consumo das familias, governo e renda media.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @import bs4Dash
#' @import magrittr
#' @import plotly
#' @import dplyr
#' @import tidyr
#' @import ggplot2



mod_consumo_ui <- function(id) {
  ns <- NS(id)
  tagList(
    fluidPage(
      fluidRow(

        # Resenha
        box(
          title = tags$b("CONSUMO"),
          closable = FALSE,
          width = 4,
          height = 760,
          status = NULL,
          background = "yellow",
          solidHeader = TRUE,
          h4(
            style = "text-align: justify;",
            "Um dos principais motores da economia, o consumo das famílias reduziu seu ritmo de crescimento no 2T de 2018, divulgou o IBGE. Apesar da alta de 1,7% no trimestre, se comparado ao mesmo período de 2017, houve crescimento de apenas 0,1% em relção ao semestre anterior. Contribuem para esse cenário o aumento da informalidade no mercado de trabalho e estagnação da renda."
          ),
          br()
        ),

        # Consumo
        box(
          title = tags$b("Consumo das Famílias e Governo"),
          closable = FALSE,
          width = 4,
          height = 760,
          status = "warning",
          solidHeader = TRUE,
          tags$b("Contribuição do consumo no PIB", style = "text-align: left; font-size: 18px; color: #808080;"),
          tags$p("Índice, trimestral", style = "text-align: left; font-size: 14px; color: #808080;"),
          plotlyOutput(ns("plot1")),
          tags$p("Fonte: IBGE", style = "text-align: left; font-size: 12px; color: #808080;"),
          footer = fluidRow(
            column(
              width = 6,
              descriptionBlock(
                number = paste(round(
                  tail(series$PIBtriF$value, 1) - head(tail(series$PIBtriF$value, 2), 1), 2
                ), "pts"),
                numberColor = if (tail(series$PIBtriF$value, 1) - head(tail(series$PIBtriF$value, 2), 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (tail(series$PIBtriF$value, 1) - head(tail(series$PIBtriF$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste(tail(series$PIBtriF$value, 1), tail(months(series$PIBtriF$date), 1)),
                text = "Consumo das Famílias",
                rightBorder = TRUE,
                marginBottom = FALSE
              )
            ), column(
              width = 6,
              descriptionBlock(
                number = paste(round(
                  tail(series$PIBtriG$value, 1) - head(tail(series$PIBtriG$value, 2), 1), 2
                ), "pts"),
                numberColor = if (tail(series$PIBtriG$value, 1) - head(tail(series$PIBtriG$value, 2), 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (tail(series$PIBtriG$value, 1) - head(tail(series$PIBtriG$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste(tail(series$PIBtriG$value, 1), tail(months(series$PIBtriG$date), 1)),
                text = "Consumo do Governo",
                rightBorder = FALSE,
                marginBottom = FALSE
              )
            )
          )
        ),

        # Expectativas do Consumidor
        box(
          title = tags$b("Expectativas do Consumidor"),
          closable = FALSE,
          width = 4,
          height = 760,
          status = "warning",
          solidHeader = TRUE,
          tags$b("Percepção do consumidor", style = "text-align: left; font-size: 18px; color: #808080;"),
          tags$p("Índice, mensal", style = "text-align: left; font-size: 14px; color: #808080;"),
          plotlyOutput(ns("plot3")),
          tags$p("Fonte: Fecomercio", style = "text-align: left; font-size: 12px; color: #808080;"),
          footer = fluidRow(
            column(
              width = 4,
              descriptionBlock(
                number = paste(round(
                  tail(series$ICC$value, 1) - head(tail(series$ICC$value, 2), 1), 2
                ), "pts"),
                numberColor = if (tail(series$ICC$value, 1) - head(tail(series$ICC$value, 2), 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (tail(series$ICC$value, 1) - head(tail(series$ICC$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste(tail(series$ICC$value, 1), tail(months(series$ICC$date), 1)),
                text = "ICC",
                rightBorder = TRUE,
                marginBottom = FALSE
              )
            ), column(
              width = 4,
              descriptionBlock(
                number = paste(round(
                  tail(series$ICE$value, 1) - head(tail(series$ICE$value, 2), 1), 2
                ), "pts"),
                numberColor = if (tail(series$ICE$value, 1) - head(tail(series$ICE$value, 2), 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (tail(series$ICE$value, 1) - head(tail(series$ICE$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste(tail(series$ICE$value, 1), tail(months(series$ICE$date), 1)),
                text = "ICE",
                rightBorder = TRUE,
                marginBottom = FALSE
              )
            ), column(
              width = 4,
              descriptionBlock(
                number = paste(round(
                  tail(series$IEF$value, 1) - head(tail(series$IEF$value, 2), 1), 2
                ), "pts"),
                numberColor = if (tail(series$IEF$value, 1) - head(tail(series$IEF$value, 2), 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (tail(series$IEF$value, 1) - head(tail(series$IEF$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste(tail(series$IEF$value, 1), tail(months(series$IEF$date), 1)),
                text = "IEF",
                rightBorder = FALSE,
                marginBottom = FALSE
              )
            )
          )
        ),

        # Renda Média
        box(
          title = tags$b("Renda Média"),
          closable = FALSE,
          width = 12,
          height = 760,
          status = "warning",
          solidHeader = TRUE,
          tags$b("Renda média real das pessoas ocupadas", style = "text-align: left; font-size: 18px; color: #808080;"),
          tags$p("Em R$, mensal", style = "text-align: left; font-size: 14px; color: #808080;"),
          plotlyOutput(ns("plot2")),
          tags$p("Fonte: IBGE", style = "text-align: left; font-size: 12px; color: #808080;"),
          footer = fluidRow(
            column(
              width = 6,
              descriptionBlock(
                number = paste(round(
                  tail(series$RendaC$value, 1) - head(tail(series$RendaC$value, 2), 1), 2
                ), "reais"),
                numberColor = if (tail(series$RendaC$value, 1) - head(tail(series$RendaC$value, 2), 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (tail(series$RendaC$value, 1) - head(tail(series$RendaC$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste("R$", tail(series$RendaC$value, 1), "em", tail(months(series$RendaC$date), 1)),
                text = "Formalizado",
                rightBorder = TRUE,
                marginBottom = FALSE
              )
            ), column(
              width = 6,
              descriptionBlock(
                number = paste(round(
                  tail(series$RendaSC$value, 1) - head(tail(series$RendaSC$value, 2), 1), 2
                ), "reais"),
                numberColor = if (tail(series$RendaSC$value, 1) - head(tail(series$RendaSC$value, 2), 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (tail(series$RendaSC$value, 1) - head(tail(series$RendaSC$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste("R$", round(tail(series$RendaSC$value, 1), 2), "em", tail(months(series$RendaSC$date), 1)),
                text = "Informal",
                rightBorder = FALSE,
                marginBottom = FALSE
              )
            )
          ),
          fluidRow(
            column(
              width = 6,
              descriptionBlock(
                number = paste(round(
                  tail(series$RendaPriv$value, 1) - head(tail(series$RendaPriv$value, 2), 1), 2
                ), "reais"),
                numberColor = if (tail(series$RendaPriv$value, 1) - head(tail(series$RendaPriv$value, 2), 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (tail(series$RendaPriv$value, 1) - head(tail(series$RendaPriv$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste("R$", tail(series$RendaPriv$value, 1), "em", tail(months(series$RendaPriv$date), 1)),
                text = "Setor Privado",
                rightBorder = TRUE,
                marginBottom = FALSE
              )
            ), column(
              width = 6,
              descriptionBlock(
                number = paste(round(
                  tail(series$RendaPub$value, 1) - head(tail(series$RendaPub$value, 2), 1), 2
                ), "reais"),
                numberColor = if (tail(series$RendaPub$value, 1) - head(tail(series$RendaPub$value, 2), 1) >= 0) {
                  "success"
                } else {
                  "danger"
                },
                numberIcon = if (tail(series$RendaPub$value, 1) - head(tail(series$RendaPub$value, 2), 1) >= 0) {
                  icon("fas fa-caret-up")
                } else {
                  icon("fas fa-caret-down")
                },
                header = paste("R$", round(tail(series$RendaPub$value, 1), 2), "em", tail(months(series$RendaPub$date), 1)),
                text = "Setor Público",
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

#' consumo Server Function
#'
#' @noRd
mod_consumo_server <- function(input, output, session) {
  ns = session$ns

  # Consumo das Famílias
  output$plot1 = renderPlotly({
    plot_ly(
      data = series$PIBtriF, x = ~date, y = ~value,
      type = "scatter", mode = "lines", name = "Consumo das Famílias"
    ) %>%
      add_trace(
        y = series$PIBtriG$value,
        name = "Consumo do Governo", mode = "lines"
      ) %>%
      layout(
        title = "",
        xaxis = list(title = ""),
        yaxis = list(title = "Indice (1995=100)"),
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center"
        )
      )
  })

  # Expectativas do Consumidor
  output$plot3 = renderPlotly({
    plot_ly(
      data = series$ICC, x = ~date, y = ~value,
      type = "scatter", mode = "lines", name = "Confiança do Consumidor"
    ) %>%
      add_trace(
        y = series$ICE$value,
        name = "Condições Econômicas Atuais", mode = "lines"
      ) %>%
      add_trace(
        y = series$IEF$value,
        name = "Expectativas Futuras", mode = "lines"
      ) %>%
      layout(
        title = "",
        xaxis = list(title = ""),
        yaxis = list(title = "Indice (2000=100)"),
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center"
        )
      )
  })

  # Rendimento médio do trabalhador
  output$plot2 = renderPlotly({

    ggplotly(
      cbind(
        series$RendaPub,
        series$RendaPriv$value,
        series$RendaC$value,
        series$RendaSC$value
      ) %>%
        rename(date = 1, Público = 2, Privado = 3, Formal = 4, Informal = 5) %>%
          pivot_longer(!date) %>%
          ggplot(aes(x = date, y = value)) +
          geom_line(color = "#1f77b4") +
          scale_y_continuous(labels = scales::number) +
          facet_wrap(~name, scales = "free_y") +
          labs(x = "", y = "") +
          theme_bw() +
          theme(
            strip.background = element_rect(fill = "#56af31", color = "#56af31"),
            strip.text = element_text(color = "white", family = "Century Gothic"),
            panel.border = element_rect(color = "#56af31")
          )
    )

  })
}
    
## To be copied in the UI
# mod_consumo_ui("consumo_ui_1")
    
## To be copied in the server
# callModule(mod_consumo_server, "consumo_ui_1")
