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
        valueBoxOutput("val_ii", 3),
        bs4ValueBox("val_ia", 3),
        bs4ValueBox("val_iiq", 3)
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

      value_box_ii = if (input$but_agencia == "Todas") {
        gco
      } else {
        subset(gco, agencia == input$but_agencia)
      }

      value_box_ii = if (input$but_modalidade == "Todas") {
        value_box_ii
      } else {
        subset(value_box_ii, modalidade == input$but_modalidade)
      }

      value_box_ii = if (input$but_tp_cli == "Todos") {
        value_box_ii
      } else {
        subset(value_box_ii, tipo_cli == input$but_tipo_cli)
      }

      value_box_ii = sum(ifelse(value_box_ii$dias_atraso > 90, value_box_ii$saldo_contabil, 0)) / sum(value_box_ii$saldo_contabil)

      valueBox(value_box_ii)
    })
  })
}

## To be copied in the UI
# mod_cobranca_ui("cobranca_ui_1")

## To be copied in the server
# mod_cobranca_server("cobranca_ui_1")