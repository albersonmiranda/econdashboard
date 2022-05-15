#' fundos_introducao UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_fundos_introducao_ui <- function(id) {
  ns <- NS(id)
  tagList(
    list(
      tags$div(
        class = "conj-tit", br(),
        "Fundos de Investimento Banestes"
      ),
      br(),
      tags$div(
        class = "fundos-body",
        ""
      ),
      
      # Action Button
      
      actionButton(
        inputId = "<br>fundos_renda_fixa",
        label = menuSubItem(HTML("<br>Renda Fixa"),
                            tabName = "fundos_renda_fixa",
                            icon = icon("chart-bar", class = "icon")
        ),
        class = "button"
      ),
      actionButton(
        inputId = "fundos_acoes",
        label = menuSubItem(HTML("<br>Ações"),
                            tabName = "fundos_acoes",
                            icon = icon("chart-line", class = "icon")
        ),
        class = "button"
      ),
      actionButton(
        inputId = "fundos_multimercado",
        label = menuSubItem(HTML("<br>Multimercado"),
                            tabName = "fundos_multimercado",
                            icon = icon("globe-americas", class = "icon")
        ),
        class = "button"
      )
    ),
  )
}

#' fundos_introducao Server Functions
#'
#' @noRd
mod_fundos_introducao_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
  })
}

## To be copied in the UI
# mod_fundos_introducao_ui("fundos_introducao_ui_1")

## To be copied in the server
# mod_fundos_introducao_server("fundos_introducao_ui_1")