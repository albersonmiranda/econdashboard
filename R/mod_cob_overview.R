#' cob_overview UI Function
#'
#' @description Overview da cobrança com índices de inadimplência.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_cob_overview_ui = function(id) {
  ns = NS(id)

  tagList(
    fluidPage(

      # botões de seleção de agência, modalidade e tipo cliente
      fluidRow(
        selectInput(ns("but_superint"), "Superintendência", c("Todas", sort(unique(gco$superint))), selected = "Todas", multiple = TRUE),
        selectInput(ns("but_agencia"), "Agência", c("Todas", sort(unique(gco$agencia))), selected = "Todas", multiple = TRUE),
        selectInput(ns("but_modalidade"), "Produto", c("Todos", sort(unique(gco$modalidade))), selected = "Todos", multiple = TRUE),
        selectInput(ns("but_tipo_cli"), "Tipo Cliente", c("Todos", sort(unique(gco$tipo_cli))), selected = "Todos", multiple = TRUE)
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
          title = tags$div("MAIORES CLIENTES", class = "box-tit"),
          width = 12,
          status = "warning",
          solidHeader = TRUE,
          background = "yellow",
          label = boxLabel("", "primary"),
          sidebar = boxSidebar(
            id = "treemap_1_sidebar",
            selectInput(
              ns("but_status"), "status", c("todos", "em dia", "atraso", "inadimplente"),
              selected = "todos", multiple = TRUE
            )
          ),
          tags$div("Top 20 clientes", class = "box-subtit"),
          tags$div("Por saldo contábil, mês anterior", class = "box-body"),
          shinycssloaders::withSpinner(
            plotlyOutput(ns("treemap_1"))
          ),
          tags$div("Fonte: GCO | Legenda:",
            tags$div("adimplente", class = "azul"),
            tags$div("em atraso", class = "amarelo"),
            tags$div("inadimplente", class = "vermelho"),
            class = "box-legenda"
          )
        )
      ),
      # treemap impacto PDD
      fluidRow(
        shinydashboardPlus::box(
          title = tags$div("IMPACTO PDD NO MÊS", class = "box-tit"),
          width = 12,
          status = "warning",
          solidHeader = TRUE,
          background = "yellow",
          label = boxLabel("", "primary"),
          sidebar = boxSidebar(
            id = "treemap_2_sidebar",
            selectInput(
              ns("but_classificacao"), "classificação estimada", c("todas", "C", "D", "E", "F", "G", "H"),
              selected = "todas", multiple = TRUE
            )
          ),
          tags$div("Top 20 impactos de provisionamento", class = "box-subtit"),
          tags$div(paste("Por impacto estimado, em", format(Sys.Date(), "%B/%Y")), class = "box-body"),
          shinycssloaders::withSpinner(
            plotlyOutput(ns("treemap_2"))
          ),
          tags$div("Fonte: GCO, simulação | Legenda:",
            tags$div("classificação C e D", class = "amarelo"),
            tags$div("classificação E, F, G e H", class = "vermelho"),
            class = "box-legenda"
          )
        )
      )
    )
  )
}

#' cob_overview Server Function
#'
#' @noRd
mod_cob_overview_server = function(id) {
  moduleServer(id, function(input, output, session) {
    ns = session$ns

    value_box_i = reactive({
      value_box_i = if ("Todas" %in% input$but_superint) {
        gco
      } else {
        subset(gco, superint %in% input$but_superint)
      }

      value_box_i = if ("Todas" %in% input$but_agencia) {
        value_box_i
      } else {
        subset(value_box_i, agencia %in% input$but_agencia)
      }

      value_box_i = if ("Todos" %in% input$but_modalidade) {
        value_box_i
      } else {
        subset(value_box_i, modalidade %in% input$but_modalidade)
      }

      value_box_i = if ("Todos" %in% input$but_tipo_cli) {
        value_box_i
      } else {
        subset(value_box_i, tipo_cli %in% input$but_tipo_cli)
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

      value_box_i = if ("todos" %in% input$but_status) {
        value_box_i
      } else {
        subset(value_box_i, status %in% input$but_status)
      }

      top20_cli = aggregate(saldo_contabil ~ nome, data = value_box_i, sum)
      top20_cli = head(top20_cli[order(-top20_cli$saldo_contabil), ], 20)

      value_box_i = subset(value_box_i, nome %in% top20_cli$nome)

      value_box_i$label = paste(
        paste("cpf/cnpj", value_box_i$cpfcnpj),
        paste("produto", value_box_i$modalidade),
        paste("contrato", value_box_i$contrato),
        paste("saldo de R$", format(
          round(value_box_i$saldo_contabil, 0),
          nsmall = 0,
          big.mark = ".",
          decimal.mark = ","
        )), paste(value_box_i$dias_atraso, "dias de atraso"),
        sep = "\r\n"
      )

      value_box_i = within(value_box_i, {
        cores = NA
        cores[status == "em dia"] = "#004b8d"
        cores[status == "atraso"] = "orange"
        cores[status == "inadimplente"] = "firebrick"
      })

      plot_ly(
        type = "treemap",
        labels = c(top20_cli$nome, value_box_i$label),
        parents = c(rep("top 20", length(unique(value_box_i$nome))), value_box_i$nome),
        values = c(rep(0, length(unique(value_box_i$nome))), value_box_i$saldo_contabil),
        textinfo = "label+text+percent entry",
        hoverinfo = "label+text+percent entry",
        marker = list(
          colors = c(rep("#004b8d", length(unique(value_box_i$nome))), value_box_i$cores)
        ),
        outsidetextfont = list(size = 20, color = "white"),
      ) %>%
        layout(
          margin = list(
            r = 0,
            t = 0,
            b = 0,
            l = 0
          )
        )
    })

    # treemap impacto PDD
    output$treemap_2 = renderPlotly({
      value_box_i = value_box_i()

      value_box_i = if ("todas" %in% input$but_classificacao) {
        value_box_i
      } else {
        subset(value_box_i, class_usada %in% input$but_classificacao)
      }

      top20_cli = aggregate(impacto_pdd ~ nome, data = value_box_i, sum)
      top20_cli = head(top20_cli[order(-top20_cli$impacto_pdd), ], 20)

      value_box_i = subset(value_box_i, nome %in% top20_cli$nome)

      value_box_i$label = paste(
        paste("cpf/cnpj", value_box_i$cpfcnpj),
        paste("produto", value_box_i$modalidade),
        paste("contrato", value_box_i$contrato),
        paste("impacto de", "R$", format(
          round(value_box_i$impacto_pdd, 0),
          nsmall = 0,
          big.mark = ".",
          decimal.mark = ","
        )),
        paste(value_box_i$dias_atraso, "dias de atraso"),
        paste("classificação de", value_box_i$class_risco, "para", value_box_i$class_usada),
        sep = "\r\n"
      )

      value_box_i = within(value_box_i, {
        cores = NA
        cores[class_usada %in% c("AA", "A")] = "#004b8d"
        cores[class_usada %in% c("B", "C", "D")] = "orange"
        cores[class_usada %in% c("E", "F", "G", "H")] = "firebrick"
      })

      plot_ly(
        type = "treemap",
        labels = c(top20_cli$nome, value_box_i$label),
        parents = c(rep("top 20", length(unique(value_box_i$nome))), value_box_i$nome),
        values = c(rep(0, length(unique(value_box_i$nome))), value_box_i$impacto_pdd),
        textinfo = "label+text+percent entry",
        hoverinfo = "label+text+percent entry",
        marker = list(
          colors = c(rep("#004b8d", length(unique(value_box_i$nome))), value_box_i$cores)
        ),
        outsidetextfont = list(size = 20, color = "white"),
      ) %>%
        layout(
          margin = list(
            r = 0,
            t = 0,
            b = 0,
            l = 0
          )
        )
    })
  })
}

## To be copied in the UI
# mod_cob_overview_ui("cob_overview_ui_1")

## To be copied in the server
# callModule(mod_cob_overview_server, "cob_overview_ui_1")