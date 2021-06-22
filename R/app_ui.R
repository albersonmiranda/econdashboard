
#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinydashboard
#' @importFrom shinydashboardPlus boxLabel boxSidebar
#' @importFrom bs4Dash descriptionBlock
#' @import plotly
#' @import ggplot2
#' @importFrom magrittr %>%
#' @importFrom tidyr pivot_longer
#' @importFrom dplyr rename
#' @noRd


app_ui <- function(request) {

  # load data
  data("series")
  data("gco")
  data("fundos")

  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here
    dashboardPage(
      dashboardHeader(title = tags$a(
        href = "https://www.banestes.com.br",
        tags$img(
          src = "www/img/Institucional_Outline_Fundo-Azul-cropped.png",
          class = "center"
        )
      ), titleWidth = "150px"),
      dashboardSidebar(
        width = 150,
        sidebarMenu(
          menuItem("Conjuntura", tabName = "conjuntura", icon = icon("chart-bar")),
          menuItem("Cobrança", tabName = "cobranca", icon = icon("building")),
          menuItem("Fundos", tabName = "fundos", icon = icon("money-bill-wave"))
        )
      ),
      dashboardBody(
        tabItems(
          # tab conjuntura
          tabItem(
            tabName = "conjuntura",
            mod_conj_titulo_ui("titulo_ui_1"),
            mod_conj_atividade_economica_ui("atividade_economica_ui_1"),
            mod_conj_atividade_economica_es_ui("atividade_economica_es_ui_1"),
            mod_conj_mercados_ui("mercados_ui_1"),
            mod_conj_inflacao_ui("inflacao_ui_1"),
            mod_conj_consumo_ui("consumo_ui_1"),
            mod_conj_credito_ui("credito_ui_1"),
            mod_conj_setor_publico_ui("setor_publico_ui_1")
          ),
          # tab cobrança
          tabItem(
            tabName = "cobranca",
            mod_fundos_institucional_ui("cob_institucional_ui_1")
          ),
          # tab fundos
          tabItem(
            tabName = "fundos",
            mod_fundos_institucional_ui("fundos_institucional_ui_1"),
            mod_fundos_investidor_ui("fundos_investidor_ui_1")
          )
        )
      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd


golem_add_external_resources <- function() {
  add_resource_path(
    "www", app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "Banestes Dashboard"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}