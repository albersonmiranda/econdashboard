#' setor_publico_br UI Function
#'
#' @description Módulo de setor público brasileiro.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_setor_publico_br_ui <- function(id){
  ns <- NS(id)
  tagList(fluidPage(titlePanel(h1("SETOR PÚBLICO BRASILEIRO")),
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
                          HTML(tail(resenhas_conjuntura$setorpublico.br, 1))
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
                      
                      # Resultado primário BR
                      box(
                        title = tags$div("Resultado Primário", class = "box-tit"),
                        closable = FALSE,
                        width = 4,
                        height = 760,
                        status = "warning",
                        solidHeader = TRUE,
                        tags$div("Necessidade de financiamento do setor público consolidado", class = "box-subtit"),
                        tags$div("Fluxo acumulado no ano", class = "box-body"),
                        plotlyOutput(ns("plot1")),
                        tags$div("Fonte: Banco Central do Brasil", class = "box-legenda"),
                        tags$div(HTML(
                          ifelse(
                            is.na(tail(legenda_conjuntura$primario.br, 1)),
                            "",
                            tail(legenda_conjuntura$primario.br, 1)
                          )
                        ),
                        class = "box-body"),
                        footer = fluidRow(
                          column(
                            width = 12,
                            descriptionBlock(
                              number = paste("R$", round(
                                (tail(series$ResultadoBR$value, 1) - head(tail(series$ResultadoBR$value, 2), 1)), 1
                              ), "mi"),
                              numberColor = if (tail(series$ResultadoBR$value, 1) - head(tail(series$ResultadoBR$value, 2), 1) >= 0) {
                                "success"
                              } else {
                                "danger"
                              },
                              numberIcon = if (tail(series$ResultadoBR$value, 1) - head(tail(series$ResultadoBR$value, 2), 1) >= 0) {
                                icon("fas fa-caret-up")
                              } else {
                                icon("fas fa-caret-down")
                              },
                              header = paste0(" R$", round(tail(series$ResultadoBR$value / 100 , 1), 1), " bi", " (", tail(months(series$ResultadoBR$date), 1), ")"),
                              text = "Resultado Primário",
                              rightBorder = FALSE,
                              marginBottom = FALSE
                            )
                          )
                        )
                      ),
                      
                      # Dívida Líquida BR
                      box(
                        title = tags$div("Dívida Líquida", class = "box-tit"),
                        closable = FALSE,
                        width = 4,
                        height = 760,
                        status = "warning",
                        solidHeader = TRUE,
                        tags$div("Dívida líquida do setor público", class = "box-subtit"),
                        tags$div("Saldo em R$ trilhões", class = "box-body"),
                        plotlyOutput(ns("plot2")),
                        tags$div("Fonte: Banco Central do Brasil", class = "box-legenda"),
                        tags$div(HTML(
                          ifelse(
                            is.na(tail(legenda_conjuntura$div.liq.br, 1)),
                            "",
                            tail(legenda_conjuntura$div.liq.br, 1)
                          )
                        ),
                        class = "box-body"),
                        footer = fluidRow(
                          column(
                            width = 12,
                            descriptionBlock(
                              number = paste("R$", round(
                                (tail(series$DividaLiqBR$value, 1) - head(tail(series$DividaLiqBR$value, 2), 1)), 1
                              ), "mi"),
                              numberColor = if (tail(series$DividaLiqBR$value, 1) - head(tail(series$DividaLiqBR$value, 2), 1) >= 0) {
                                "danger"
                              } else {
                                "success"
                              },
                              numberIcon = if (tail(series$DividaLiqBR$value, 1) - head(tail(series$DividaLiqBR$value, 2), 1) >= 0) {
                                icon("fas fa-caret-up")
                              } else {
                                icon("fas fa-caret-down")
                              },
                              header = paste0(" R$", round(tail(series$DividaLiqBR$value / 1000000, 1), 1), " tri", " (", tail(months(series$DividaLiqBR$date), 1), ")"),
                              text = "Dívida Líquida Consolidada",
                              rightBorder = FALSE,
                              marginBottom = FALSE
                            )
                          )
                        )
                      ), 
                      
                    #Dívida Liquida BR %PIB  
                    box(
                      title = tags$div("Dívida Líquida (%PIB)", class = "box-tit"),
                      closable = FALSE,
                      width = 4,
                      height = 760,
                      status = "warning",
                      solidHeader = TRUE,
                      tags$div("Dívida líquida do setor público", class = "box-subtit"),
                      tags$div("Saldo total", class = "box-body"),
                      plotlyOutput(ns("plot4")),
                      tags$div("Fonte: Banco Central do Brasil", class = "box-legenda"),
                      tags$div(
                        HTML(
                          ifelse(
                            is.na(tail(legenda_conjuntura$div.liq.br.pib, 1)),
                            "",
                            tail(legenda_conjuntura$div.liq.br.pib, 1)
                          )
                        ), 
                        class = "box-body"
                      ),
                      footer = fluidRow(
                        column(
                          width = 12,
                          descriptionBlock(
                            number = paste("", round(
                              (tail(series$DividaLiqBR.PIB$value, 1) - head(tail(series$DividaLiqBR.PIB$value, 2), 1)), 1
                            ), "%"),
                            numberColor = if (tail(series$DividaLiqBR.PIB$value, 1) - head(tail(series$DividaLiqBR.PIB$value, 2), 1) >= 0) {
                              "danger"
                            } else {
                              "success"
                            },
                            numberIcon = if (tail(series$DividaLiqBR.PIB$value, 1) - head(tail(series$DividaLiqBR.PIB$value, 2), 1) >= 0) {
                              icon("fas fa-caret-up")
                            } else {
                              icon("fas fa-caret-down")
                            },
                            header = paste0("", round(tail(series$DividaLiqBR.PIB$value, 1), 1), "%", " (", tail(months(series$DividaLiqBR.PIB$date), 1), ")"),
                            text = "Dívida Líquida Consolidada",
                            rightBorder = FALSE,
                            marginBottom = FALSE
                          )
                        )
                      )
                    ),
                    # Dívida Bruta BR
                    box(
                      title = tags$div("Dívida Bruta", class = "box-tit"),
                      closable = FALSE,
                      width = 4,
                      height = 760,
                      status = "warning",
                      solidHeader = TRUE,
                      tags$div("Dívida bruta do Governo Geral", class = "box-subtit"),
                      tags$div("Saldos em R$ trilhões", class = "box-body"),
                      plotlyOutput(ns("plot5")),
                      tags$div("Fonte: Banco Central do Brasil", class = "box-legenda"),
                      tags$div("", class = "box-body"),
                      tags$div(
                        HTML(
                          ifelse(
                            is.na(tail(legenda_conjuntura$div.bruta.br, 1)),
                             "",
                          tail(legenda_conjuntura$div.bruta.br, 1)
                             )
                          ),
                          style = "box-body"),
                      footer = fluidRow(
                        column(
                          width = 12,
                          descriptionBlock(
                            number = paste("R$", round(
                              (tail(series$DividaBrutaBR$value, 1) - head(tail(series$DividaBrutaBR$value, 2), 1)), 1
                            ), "mi"),
                            numberColor = if (tail(series$DividaBrutaBR$value, 1) - head(tail(series$DividaBrutaBR$value, 2), 1) >= 0) {
                              "danger"
                            } else {
                              "success"
                            },
                            numberIcon = if (tail(series$DividaBrutaBR$value, 1) - head(tail(series$DividaBrutaBR$value, 2), 1) >= 0) {
                              icon("fas fa-caret-up")
                            } else {
                              icon("fas fa-caret-down")
                            },
                            header = paste0(" R$", round(tail(series$DividaBrutaBR$value / 1000000, 1), 1), " tri", " (", tail(months(series$DividaBrutaBR$date), 1), ")"),
                            text = "Dívida Bruta",
                            rightBorder = FALSE,
                            marginBottom = FALSE
                          )
                        )
                      )
                    ),
                    #Dívida Liquida BR %PIB  
                    box(
                      title = tags$div("Dívida Bruta (%PIB)", class = "box-tit"),
                      closable = FALSE,
                      width = 4,
                      height = 760,
                      status = "warning",
                      solidHeader = TRUE,
                      tags$div("Dívida bruta do Governo Geral", class = "box-subtit"),
                      tags$div("Saldo total", class = "box-body"),
                      plotlyOutput(ns("plot6")),
                      tags$div("Fonte: Banco Central do Brasil", class = "box-legenda"),
                      tags$div(HTML(
                        ifelse(
                          is.na(tail(legenda_conjuntura$div.bruta.br.pib, 1)),
                          "",
                          tail(legenda_conjuntura$div.bruta.br.pib, 1)
                        )
                      ),
                          class = "box-body"),
                      footer = fluidRow(
                        column(
                          width = 12,
                          descriptionBlock(
                            number = paste("", round(
                              (tail(series$DividaBrutaBR.PIB$value, 1) - head(tail(series$DividaBrutaBR.PIB$value, 2), 1)), 1
                            ), "%"),
                            numberColor = if (tail(series$DividaBrutaBR.PIB$value, 1) - head(tail(series$DividaBrutaBR.PIB$value, 2), 1) >= 0) {
                              "danger"
                            } else {
                              "success"
                            },
                            numberIcon = if (tail(series$DividaBrutaBR.PIB$value, 1) - head(tail(series$DividaBrutaBR.PIB$value, 2), 1) >= 0) {
                              icon("fas fa-caret-up")
                            } else {
                              icon("fas fa-caret-down")
                            },
                            header = paste0("", round(tail(series$DividaBrutaBR.PIB$value, 1), 1), "%", " (", tail(months(series$DividaBrutaBR.PIB$date), 1), ")"),
                            text = "Dívida Bruta",
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
    
#' setor_publico_br Server Functions
#'
#' @noRd 
mod_setor_publico_br_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
    # resultado primário do BR
    output$plot1 <- renderPlotly({
      plot_ly(
        data = series$ResultadoBR,
        x = ~date, y = ~value * 10000000,
        type = "scatter", mode = "lines", name = "Resultado Primário", line = list(color = "#004B8D")
      ) %>%
        layout(
          title = "", xaxis = list(title = ""), yaxis = list(title = "R$ bi"),
          legend = list(
            orientation = "h",
            x = 0.5,
            xanchor = "center"
          )
        )
    })
    
    # Dívida líquida consolidada BR
    output$plot2 <- renderPlotly({
      plot_ly(
        data = series$DividaLiqBR,
        x = ~date, y = ~value * 1000000,
        type = "scatter", mode = "lines", name = "Dívida Líquida", line = list(color = "#004B8D")
      ) %>%
        layout(
          title = "", xaxis = list(title = ""), yaxis = list(title = "R$ tri"),
          legend = list(
            orientation = "h",
            x = 0.5,
            xanchor = "center"
          )
        )
    })
    
   # Dívida líquida consolidada BR % PIB
    output$plot4 <- renderPlotly({
      plot_ly(
        data = series$DividaLiqBR.PIB,
        x = ~date, y = ~value,
        type = "scatter", mode = "lines", name = "Dívida Líquida", line = list(color = "#004B8D")
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
    
    # Dívida bruta consolidada BR
    output$plot5 <- renderPlotly({
      plot_ly(
        data = series$DividaBrutaBR,
        x = ~date, y = ~value * 1000000,
        type = "scatter", mode = "lines", name = "Dívida Bruta", line = list(color = "#004B8D")
      ) %>%
        layout(
          title = "", xaxis = list(title = ""), yaxis = list(title = "R$ tri"),
          legend = list(
            orientation = "h",
            x = 0.5,
            xanchor = "center"
          )
        )
    })
    
    # Dívida Bruta BR % PIB
    output$plot6 <- renderPlotly({
      plot_ly(
        data = series$DividaBrutaBR.PIB,
        x = ~date, y = ~value,
        type = "scatter", mode = "lines", name = "Dívida Bruta", line = list(color = "#004B8D")
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
  })
}
    
## To be copied in the UI
# mod_setor_publico_br_ui("setor_publico_br_ui_1")
    
## To be copied in the server
# mod_setor_publico_br_server("setor_publico_br_ui_1")
