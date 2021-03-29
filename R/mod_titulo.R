#' titulo UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_titulo_ui <- function(id) {
  ns <- NS(id)
  tagList(
    list(
      tags$div(class = "conj-tit",
      "BR & ES: Índices e indicadores econômicos"),
      tags$div(class = "conj-body",
      "A visão geral sobre os principais dados e tendências econômicas do ES e do Brasil, incluindo PIB, inflacão, desemprego, indicadores de atividade e consumo, endividamento e inadimplência"),
      br()
    )
  )
}
    
#' titulo Server Function
#'
#' @noRd
mod_titulo_server <- function(input, output, session) {
  ns <- session$ns

}
    
## To be copied in the UI
# mod_titulo_ui("titulo_ui_1")
    
## To be copied in the server
# callModule(mod_titulo_server, "titulo_ui_1")
