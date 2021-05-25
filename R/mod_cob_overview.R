#' cob_overview UI Function
#'
#' @description Overview da cobrança com índices de inadimplência.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_cob_overview_ui <- function(id) {
  ns <- NS(id)

  tagList(
    fluidPage(

      # botões de seleção de agência, modalidade e tipo cliente
      fluidRow(
        selectInput(ns("but_agencia"), "Agência", c("Todas", sort(unique(gco$agencia)))),
        selectInput(ns("but_modalidade"), "Modalidade", c("Todas", sort(unique(gco$modalidade)))),
        selectInput(ns("but_tipo_cli"), "Tipo Cliente", c("Todos", sort(unique(gco$tipo_cli))))
      ),

      # caixas de índices de inadimplência, atraso e iiq
      fluidRow(
        valueBoxOutput(ns("val_ii"), 3),
        valueBoxOutput(ns("val_ia"), 3),
        valueBoxOutput(ns("val_iq"), 3)
      )
    )
  )
}

#' cob_overview Server Function
#'
#' @noRd
mod_cob_overview_server <- function(input, output, session) {
  ns <- session$ns

  # índice de inadimplência
  output$val_ii = renderValueBox({

    value_box_i = if (input$but_agencia == "Todas") {
      gco
    } else {
      subset(gco, agencia == input$but_agencia)
    }

    value_box_i = if (input$but_modalidade == "Todas") {
      value_box_i
    } else {
      subset(value_box_i, modalidade == input$but_modalidade)
    }

    value_box_i = if (input$but_tipo_cli == "Todos") {
      value_box_i
    } else {
      subset(value_box_i, tipo_cli == input$but_tipo_cli)
    }

    value_box_ii = sum(ifelse(value_box_i$dias_atraso > 90, value_box_i$saldo_contabil, 0)) / sum(value_box_i$saldo_contabil)

    valueBox(
      scales::percent(value_box_ii, 0.1),
      "índice de inadimplência",
      icon = icon("dollar-sign"),
      color = "yellow"
    )
  })

  # índice de atraso
  output$val_ia = renderValueBox({

    value_box_i = if (input$but_agencia == "Todas") {
      gco
    } else {
      subset(gco, agencia == input$but_agencia)
    }

    value_box_i = if (input$but_modalidade == "Todas") {
      value_box_i
    } else {
      subset(value_box_i, modalidade == input$but_modalidade)
    }

    value_box_i = if (input$but_tipo_cli == "Todos") {
      value_box_i
    } else {
      subset(value_box_i, tipo_cli == input$but_tipo_cli)
    }

    value_box_ia = sum(ifelse(value_box_i$dias_atraso > 60, value_box_i$saldo_contabil, 0)) / sum(value_box_i$saldo_contabil)

    valueBox(
      scales::percent(value_box_ia, 0.1),
      "índice de atraso",
      icon = icon("dollar-sign"),
      color = "yellow"
    )
  })

  # índice de inadimplência por quantidade
  output$val_iq = renderValueBox({

    value_box_i = if (input$but_agencia == "Todas") {
      gco
    } else {
      subset(gco, agencia == input$but_agencia)
    }

    value_box_i = if (input$but_modalidade == "Todas") {
      value_box_i
    } else {
      subset(value_box_i, modalidade == input$but_modalidade)
    }

    value_box_i = if (input$but_tipo_cli == "Todos") {
      value_box_i
    } else {
      subset(value_box_i, tipo_cli == input$but_tipo_cli)
    }

    value_box_iq = sum(ifelse(value_box_i$dias_atraso > 90, 1, 0)) / nrow(value_box_i)

    valueBox(
      scales::percent(value_box_iq, 0.1),
      "índice de inadimplência por quantidade",
      icon = icon("dollar-sign"),
      color = "yellow"
    )
  })
}

## To be copied in the UI
# mod_cob_overview_ui("cob_overview_ui_1")

## To be copied in the server
# callModule(mod_cob_overview_server, "cob_overview_ui_1")