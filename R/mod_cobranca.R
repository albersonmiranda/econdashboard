#' cobranca UI Function
#'
#' @description Modulo de cobranca colocado pela Gerat.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_cobranca_ui <- function(id) {
  ns <- NS(id)
  tagList(

    fluidPage(

      # botões de seleção de agência, modalidade e tipo cliente
      fluidRow(
        selectInput("but_agencia", "Agência", c("Todas", sort(unique(gco$agencia)))),
        selectInput("but_modalidade", "Modalidade", c("Todas", sort(unique(gco$modalidade)))),
        selectInput("but_tipo_cli", "Tipo Cliente", c("Todos", sort(unique(gco$tipo_cli))))
      ),

      # caixas de índices de inadimplência, atraso e iiq
      fluidRow(
        bs4ValueBoxOutput("val_ii", 3),
        bs4ValueBoxOutput("val_ia", 3),
        bs4ValueBoxOutput("val_iiq", 3)
      )
    )

  )
}
    
#' cobranca Server Functions
#'
#' @noRd
mod_cobranca_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    # value box índice de inadimplência
    output$val_ii = renderValueBox({

      value_box_ii = ifelse(input$but_agencia == "Todas", gco, subset(gco, agencia == input$but_agencia))
      value_box_ii = ifelse(input$but_modalidade == "Todas", value_box_ii, subset(value_box_ii, modalidade == input$but_modalidade))
      value_box_ii = ifelse(input$but_tp_cli == "Todos", value_box_ii, subset(value_box_ii, tipo_cli == input$but_tipo_cli))

    })

  })
}
    
## To be copied in the UI
# mod_cobranca_ui("cobranca_ui_1")
    
## To be copied in the server
# mod_cobranca_server("cobranca_ui_1")
