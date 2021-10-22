#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd

app_server <- function(input, output, session) {

  # List the first level callModules here
  callModule(mod_conj_atividade_economica_server, "atividade_economica_ui_1")
  callModule(mod_conj_atividade_economica_es_server, "atividade_economica_es_ui_1")
  callModule(mod_conj_mercados_server, "mercados_ui_1")
  callModule(mod_conj_inflacao_server, "inflacao_ui_1")
  callModule(mod_conj_consumo_server, "consumo_ui_1")
  callModule(mod_conj_credito_server, "credito_ui_1")
  callModule(mod_conj_setor_publico_server, "setor_publico_ui_1")
  mod_setor_publico_br_server("setor_publico_br_ui_1")
  callModule(mod_cob_overview_server, "cob_overview_ui_1")
  mod_fundos_institucional_server("fundos_institucional_ui_1")
  mod_fundos_investidor_server("fundos_investidor_ui_1")
}
