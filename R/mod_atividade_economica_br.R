#' atividade_economica_br UI Function
#'
#' @description Modulo da atividade economica nacional.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_atividade_economica_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' atividade_economica Server Function
#'
#' @noRd 
mod_atividade_economica_server <- function(input, output, session){
  ns <- session$ns
 
}
    
## To be copied in the UI
# mod_atividade_economica_ui("atividade_economica_ui_1")
    
## To be copied in the server
# callModule(mod_atividade_economica_server, "atividade_economica_ui_1")
 
