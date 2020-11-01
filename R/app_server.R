#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd

app_server <- function( input, output, session ) {
  
  # List the first level callModules here
  callModule(mod_atividade_economica_server, "atividade_economica_ui_1")
  callModule(mod_atividade_economica_es_server, "atividade_economica_es_ui_1")
  callModule(mod_mercados_server, "mercados_ui_1")
  callModule(mod_inflacao_server, "inflacao_ui_1")
  
}
