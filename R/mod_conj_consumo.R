#' consumo UI Function
#'
#' @description modulo de consumo das familias, governo e renda media.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList

mod_conj_consumo_ui <- function(id) {
  ns <- NS(id)
  tagList(
    fluidPage(titlePanel(h1("CONSUMO")),
      fluidRow(

        # Resenha
        box(
          closable = FALSE,
          width = 12,
          status = NULL,
          background = "yellow",
          solidHeader = TRUE,
          tags$div(
            class = "res-body",
            HTML(tail(resenhas_conjuntura$consumo, 1))
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
              tabPanel("2021",
              tags$a("Dezembro", href = "www/relatorios/consumo/2021/012/consumo.pdf", target = "_blank"))
            )
          )
        ),

        # Consumo
        box(
          title = tags$div("Consumo das Famílias e Governo", class = "box-tit"),
          closable = FALSE,
          width = 4,
          height = 855,
          status = "warning",
          solidHeader = TRUE,
          tags$div("Contribuição do consumo no PIB", class = "box-subtit"),
          tags$div("Índice, trimestral", class = "box-body"),
          withSpinner(plotlyOutput(ns("plot1")), type = 1, color = "#004b8d", size = 1.5),
          tags$div("Fonte: IBGE", class = "box-legenda"),
          tags$div(
            HTML(
              ifelse(
                is.na(tail(legenda_conjuntura$consumo, 1)),
                "",
                tail(legenda_conjuntura$consumo, 1)
              )
            ),
            class = "box-body"
          ),
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
                header = paste0(tail(series$PIBtriF$value, 1), " (", tail(months(series$PIBtriF$date), 1), ")"),
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
                header = paste0(tail(series$PIBtriG$value, 1), " (", tail(months(series$PIBtriG$date), 1), ")"),
                text = "Consumo do Governo",
                rightBorder = FALSE,
                marginBottom = FALSE
              )
            )
          )
        ),

        # Expectativas do Consumidor
        box(
          title = tags$div("Expectativas do Consumidor", class = "box-tit"),
          closable = FALSE,
          width = 4,
          height = 855,
          status = "warning",
          solidHeader = TRUE,
          tags$div("Percepção do consumidor", class = "box-subtit"),
          tags$div("Índice, mensal", class = "box-body"),
          withSpinner(plotlyOutput(ns("plot3")), type = 1, color = "#004b8d", size = 1.5),
          tags$div("Fonte: Fecomercio", class = "box-legenda"),
          tags$div(
            HTML(
              ifelse(
                is.na(tail(legenda_conjuntura$consumo, 1)),
                "",
                tail(legenda_conjuntura$consumo, 1)
              )
            ),
            class = "box-body"
          ),
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
                header = paste0(tail(series$ICC$value, 1), " (", tail(months(series$ICC$date), 1), ")"),
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
                header = paste0(tail(series$ICE$value, 1), " (", tail(months(series$ICE$date), 1), ")"),
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
                header = paste0(tail(series$IEF$value, 1), " (", tail(months(series$IEF$date), 1), ")"),
                text = "IEF",
                rightBorder = FALSE,
                marginBottom = FALSE
              )
            )
          )
        ),

        # Renda Média
        box(
          title = tags$div("Renda Média", class = "box-tit"),
          closable = FALSE,
          width = 12,
          height = 855,
          status = "warning",
          solidHeader = TRUE,
          tags$div("Renda média real das pessoas ocupadas", class = "box-subtit"),
          tags$div("Mensal, R$", class = "box-body"),
          withSpinner(plotlyOutput(ns("plot2")), type = 1, color = "#004b8d", size = 1.5),
          tags$div("Fonte: IBGE", class = "box-legenda"),
          tags$div(HTML(
            ifelse(
              is.na(tail(legenda_conjuntura$renda.media, 1)),
              "",
              tail(legenda_conjuntura$renda.media, 1)
            )
          ),
          class = "box-body"
          ),
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
                header = paste0( " R$", tail(series$RendaC$value, 1), " em", " (", tail(months(series$RendaC$date), 1), ")"),
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
                header = paste0( " R$", round(tail(series$RendaSC$value, 1), 2), " em", " (", tail(months(series$RendaSC$date), 1), ")"),
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
                header = paste0( " R$", tail(series$RendaPriv$value, 1), " em", " (", tail(months(series$RendaPriv$date), 1), ")"),
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
                header = paste0( " R$", round(tail(series$RendaPub$value, 1), 2), " em", " (", tail(months(series$RendaPub$date), 1), ")"),
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
mod_conj_consumo_server <- function(input, output, session) {
  ns = session$ns

  # Consumo das Famílias
  output$plot1 = renderPlotly({
    plot_ly(
      data = series$PIBtriF, x = ~date, y = ~value,
      type = "scatter", mode = "lines", name = "Consumo das Famílias", line = list(color = "#004B8D")
    ) %>%
      add_trace(
        y = series$PIBtriG$value,
        name = "Consumo do Governo", mode = "lines", line = list(color = "#56af31")
      ) %>%
      layout(
        title = "",
        xaxis = list(title = ""),
        yaxis = list(title = "Índice (1995=100)"),
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
      type = "scatter", mode = "lines", name = "Confiança do Consumidor", line = list(color = "#004B8D")
    ) %>%
      add_trace(
        y = series$ICE$value,
        name = "Condições Econômicas Atuais", mode = "lines", line = list(color = "#56af31")
      ) %>%
      add_trace(
        y = series$IEF$value,
        name = "Expectativas Futuras", mode = "lines", line = list(color = "#79bce7")
      ) %>%
      layout(
        title = "",
        xaxis = list(title = ""),
        yaxis = list(title = "Índice (2000=100)"),
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
          geom_line(color = "#004b8d") +
          scale_y_continuous(labels = scales::number) +
          scale_x_date(guide = guide_axis(n.dodge = 2)) +
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
