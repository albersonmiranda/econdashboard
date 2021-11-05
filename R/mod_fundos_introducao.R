#' fundos_introducao UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_fundos_introducao_ui <- function(id){
  ns <- NS(id)
  tagList(
      list(
        tags$div(class = "conj-tit",
                 "Fundos de Investimento Banestes"),
        tags$div(class = "conj-body",
                 "Os Fundos de investimento atuam como uma aplicação financeira coletiva e são administrados por gestores profissionais, aqui você encontra nossa lista completa com opções de Fundos em Renda Fixa, Ações e Multimercado, para você investir e diversificar sua carteira!"),
        br()
      ),

  )
}


#' fundos_introducao Server Functions
#'
#' @noRd 
mod_fundos_introducao_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_fundos_introducao_ui("fundos_introducao_ui_1")
    
## To be copied in the server
# mod_fundos_introducao_server("fundos_introducao_ui_1")
