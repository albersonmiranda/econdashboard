#' atividade_economica_es UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' @import shinydashboardPlus
#' @import magrittr
#' @import plotly



mod_atividade_economica_es_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidPage(
      fluidRow(
        
        # Resenha
        boxPlus(title = tags$b("ATIVIDADE ECONÔMICA ES", style = 'font-family: "Georgia"'),
                closable = FALSE, 
                width = 4,
                height = 760,
                status = NULL,
                background = "yellow",
                solidHeader = TRUE,
                collapsible = FALSE,
                h4(style = 'text-align: justify; font-family: "Georgia";',
                   "O Produto Interno Bruto (PIB) do Espírito Santo vem mantendo bom desempenho em 2018. Dados divulgados pelo Instituto Jones dos Santos Neves (IJSN) referentes ao terceiro trimestre de 2018 mostram que o ritmo de crescimento da economia capixaba neste ano avançou 2,3% no acumulado do ano em comparação ao mesmo período do ano anterior. O número representa mais que o dobro do resultado nacional, que ficou em 1,1% na mesma base de comparação."),
                br()
        ),
        
        # PIB variação anual
        boxPlus(
          title = tags$b("Produto Interno Bruto ES", style = 'font-family: "Georgia"'),
          closable = FALSE, 
          width = 4,
          height = 760,
          status = "warning", 
          solidHeader = TRUE, 
          collapsible = FALSE,
          enable_dropdown = FALSE,
          tags$b("Crescimento do PIB ES", style = 'text-align: left; font-family: "Georgia"; font-size: 18px; color: #808080;'),
          tags$p("Variação % anual real", style = 'text-align: left; font-family: "Georgia"; font-size: 14px; color: #808080'),
          plotlyOutput(ns("plot1")),
          tags$p("Fonte: IBGE", style = 'text-align: left; font-family: "Georgia"; font-size: 12px; color: #808080'),
          tags$p("O crescimento de 4.1% indica forte retomada da economia capixaba, que vinha de dois anos de uma recessão pior do que a apresentada em 2009 após a crise do subprime.", style = 'text-align: left; font-family: "Georgia"; font-size: 14px; color: #808080'),
          footer = fluidRow(
            column(
              width = 12,
              descriptionBlock(
                number = paste(round(
                  tail(series$PIBvarES$value,1), 2), "%"), 
                numberColor = if(tail(series$PIBvarES$value,1) >= 0) {"green"} else {"red"}, 
                numberIcon = if(tail(series$PIBvarES$value,1) >= 0) {"fas fa-caret-up"} else {"fas fa-caret-down"},
                header = NULL, 
                text = "var. % PIB", 
                rightBorder = TRUE,
                marginBottom = FALSE))))
        
      )))
}
    
#' atividade_economica_es Server Function
#'
#' @noRd 
mod_atividade_economica_es_server <- function(input, output, session){
  ns <- session$ns
 
  # PIB variação anual
  output$plot1 = renderPlotly({
    plot_ly(data = series$PIBvarES, x = ~date, y = ~value,
            type = "bar", name = "PIB Anual") %>%
      layout(title = "", xaxis = list(title = ""), yaxis = list(title = "Variação %"),
             legend = list(orientation = 'h',
                           x = 0.5,
                           xanchor = "center")
      )
  })
  
}
    
## To be copied in the UI
# mod_atividade_economica_es_ui("atividade_economica_es_ui_1")
    
## To be copied in the server
# callModule(mod_atividade_economica_es_server, "atividade_economica_es_ui_1")
 
