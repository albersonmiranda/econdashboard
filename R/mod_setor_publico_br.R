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
                      
                      # Resultado primário BR
                      box(
                        title = tags$div("Necessida de Financiamento do Setor Público", class = "box-tit"),
                        closable = FALSE,
                        width = 4,
                        height = 760,
                        status = "warning",
                        solidHeader = TRUE,
                        tags$div("Resultado Primário", class = "box-subtit"),
                        tags$div("Fluxo acumulado no ano, setor público consolidado", class = "box-body"),
                        plotlyOutput(ns("plot1")),
                        tags$div("Fonte: Banco Central do Brasil", class = "box-legenda"),
                        tags$div("Lorem ipsum dolor sit amet, porttitor eu amet etiam ridiculus praesent nam sed.", class = "box-body"),
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
                              header = paste("R$", round(tail(series$ResultadoBR$value, 1), 1), "mi", tail(months(series$ResultadoBR$date), 1)),
                              text = "Resultado Primário",
                              rightBorder = FALSE,
                              marginBottom = FALSE
                            )
                          )
                        )
                      ),
                      
                      #Resultado primário BR %PIB
                      box(
                        title = tags$div("Necessida de Financiamento do Setor Público", class = "box-tit"),
                        closable = FALSE,
                        width = 4,
                        height = 760,
                        status = "warning",
                        solidHeader = TRUE,
                        tags$div("Resultado Primário em % PIB", class = "box-subtit"),
                        tags$div("Fluxo acumulado no ano, setor público consolidado", class = "box-body"),
                        plotlyOutput(ns("plot3")),
                        tags$div("Fonte: Banco Central do Brasil", class = "box-legenda"),
                        tags$div("Lorem ipsum dolor sit amet, porttitor eu amet etiam ridiculus praesent nam sed.", class = "box-body"),
                        footer = fluidRow(
                          column(
                            width = 12,
                            descriptionBlock(
                              number = paste("R$", round(
                                (tail(series$ResultadoBR.PIB$value, 1) - head(tail(series$ResultadoBR.PIB$value, 2), 1)), 1
                              ), "mi"),
                              numberColor = if (tail(series$ResultadoBR.PIB$value, 1) - head(tail(series$ResultadoBR.PIB$value, 2), 1) >= 0) {
                                "success"
                              } else {
                                "danger"
                              },
                              numberIcon = if (tail(series$ResultadoBR.PIB$value, 1) - head(tail(series$ResultadoBR.PIB$value, 2), 1) >= 0) {
                                icon("fas fa-caret-up")
                              } else {
                                icon("fas fa-caret-down")
                              },
                              header = paste("R$", round(tail(series$ResultadoBR.PIB$value, 1), 1), "mi", tail(months(series$ResultadoBR.PIB$date), 1)),
                              text = "Resultado Primário",
                              rightBorder = FALSE,
                              marginBottom = FALSE
                            )
                          )
                        )
                      ),
                      
                      # Dívida Líquida BR
                      box(
                        title = tags$div("NFSP", class = "box-tit"),
                        closable = FALSE,
                        width = 4,
                        height = 760,
                        status = "warning",
                        solidHeader = TRUE,
                        tags$div("Dívida líquida", class = "box-subtit"),
                        tags$div("Dívida líquida do setor público", class = "box-body"),
                        plotlyOutput(ns("plot2")),
                        tags$div("Fonte: Banco Central do Brasil", class = "box-legenda"),
                        tags$div("Lorem ipsum dolor sit amet, porttitor eu amet etiam ridiculus praesent nam sed.", class = "box-body"),
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
                              header = paste("R$", round(tail(series$DividaLiqBR$value, 1), 1), "mi", tail(months(series$DividaLiqBR$date), 1)),
                              text = "Dívida Líquida Consolidada",
                              rightBorder = FALSE,
                              marginBottom = FALSE
                            )
                          )
                        )
                      ), 
                    #Dívida Liquida BR %PIB  
                    box(
                      title = tags$div("NFSP", class = "box-tit"),
                      closable = FALSE,
                      width = 4,
                      height = 760,
                      status = "warning",
                      solidHeader = TRUE,
                      tags$div("Dívida líquida em % PIB", class = "box-subtit"),
                      tags$div("Dívida líquida do setor público", class = "box-body"),
                      plotlyOutput(ns("plot4")),
                      tags$div("Fonte: Banco Central do Brasil", class = "box-legenda"),
                      tags$div("Lorem ipsum dolor sit amet, porttitor eu amet etiam ridiculus praesent nam sed.", class = "box-body"),
                      footer = fluidRow(
                        column(
                          width = 12,
                          descriptionBlock(
                            number = paste("R$", round(
                              (tail(series$DividaLiqBR.PIB$value, 1) - head(tail(series$DividaLiqBR.PIB$value, 2), 1)), 1
                            ), "mi"),
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
                            header = paste("R$", round(tail(series$DividaLiqBR.PIB$value, 1), 1), "mi", tail(months(series$DividaLiqBR.PIB$date), 1)),
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
    
    #resultado primário do BR % PIB 
    output$plot3 <- renderPlotly({
      plot_ly(
        data = series$ResultadoBR.PIB,
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
    
    # Dívida líquida consolidada BR
    output$plot2 <- renderPlotly({
      plot_ly(
        data = series$DividaLiqBR,
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
    
   # Dívida líquida consolidada BR % PIB
    output$plot4 <- renderPlotly({
      plot_ly(
        data = series$DividaLiqBR.PIB,
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
  })
}
    
## To be copied in the UI
# mod_setor_publico_br_ui("setor_publico_br_ui_1")
    
## To be copied in the server
# mod_setor_publico_br_server("setor_publico_br_ui_1")
