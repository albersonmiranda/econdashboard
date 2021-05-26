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
      ),
      # treemap maiores contratos
      fluidRow(
        shinydashboardPlus::box(
          title = tags$div("MAIORES CONTRATOS", class = "box-tit"),
          width = 12,
          status = "warning",
          solidHeader = TRUE,
          background = "yellow",
          maximizable = TRUE,
          label = boxLabel("", "primary"),
          sidebar = boxSidebar(
            width = 25
          ),
          tags$div("Top 20 contratos", class = "box-subtit"),
          tags$div("Por saldo contábil, mês anterior", class = "box-body"),
          plotlyOutput(ns("treemap_1")),
          tags$div("Fonte: GCO", class = "box-legenda")
        )
      )
    )
  )
}

#' cob_overview Server Function
#'
#' @noRd
mod_cob_overview_server <- function(input, output, session) {
  ns <- session$ns

  value_box_i = reactive({
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
  })

  # índice de inadimplência
  output$val_ii = renderValueBox({
    value_box_i = value_box_i()

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
    value_box_i = value_box_i()

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
    value_box_i = value_box_i()

    value_box_iq = sum(ifelse(value_box_i$dias_atraso > 90, 1, 0)) / nrow(value_box_i)

    valueBox(
      scales::percent(value_box_iq, 0.1),
      "índice de inadimplência por quantidade",
      icon = icon("dollar-sign"),
      color = "yellow"
    )
  })

  # treemap maiores contratos
  output$treemap_1 = renderPlotly({

    value_box_i = value_box_i()

    #value_box_i = head(value_box_i[order(-value_box_i$saldo_contabil), ], 20)
    value_box_i = head(value_box_i, 20)

    value_box_i$nome = paste(
      value_box_i$nome,
      paste("R$", format(
        round(value_box_i$saldo_contabil, 0),
        nsmall = 0,
        big.mark = ".",
        decimal.mark = ","
      )), paste(value_box_i$dias_atraso, "dias de atraso"),
      sep = "\r\n"
    )

    value_box_i = within(value_box_i, {
      cores = NA
      cores[status == "em dia"] = "navy"
      cores[status == "atraso"] = "orange"
      cores[status == "inadimplente"] = "firebrick"
    })

    plot_ly(
      type = "treemap",
      labels = value_box_i$nome,
      parents = "top 20",
      values = value_box_i$saldo_contabil,
      text = value_box_i$modalidade,
      textinfo = "label+text+percent entry",
      hoverinfo = "label+text+percent entry",
      marker = list(
        colors = value_box_i$cores
      ),
      outsidetextfont = list(size = 20, color = "white"),
    )

  })
}

## To be copied in the UI
# mod_cob_overview_ui("cob_overview_ui_1")

## To be copied in the server
# callModule(mod_cob_overview_server, "cob_overview_ui_1")