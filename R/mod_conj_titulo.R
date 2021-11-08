#' titulo UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_conj_titulo_ui <- function(id) {
  ns <- NS(id)
  tagList(
    list(
      tags$div(class = "conj-tit",
      "BR & ES: Índices e indicadores econômicos"),
      tags$div(class = "conj-body",
      "A visão geral sobre os principais dados e tendências econômicas do ES e do Brasil, incluindo PIB, inflacão, desemprego, indicadores de atividade e consumo, endividamento e inadimplência"),
      br()
      ),
    
    # Action Button
     actionButton(inputId = "atividade_economica", 
                 label = menuSubItem(HTML("<br>Atividade<br>Econômica"),
                                     tabName = "atividade_economica", 
                                     icon = icon("chart-line", class = "icon")),
                 class = "button"
                 ),
     actionButton(inputId = "consumo", 
                 label = menuSubItem(HTML("<br>Consumo"),
                                     tabName = "consumo", 
                                     icon = icon("users", class = "icon")),
                 class = "button"), 
    actionButton(inputId = "credito", 
                 label = menuSubItem(HTML("<br>Crédito"),
                                     tabName = "credito",
                                     icon = icon("credit-card", class = "icon")),
                 class = "button"),
    actionButton(inputId = "inflacao", 
                 label =  menuSubItem(HTML("<br>Inflação"),
                                      tabName = "inflacao", 
                                      icon = icon("coins", class = "icon")),
                 class = "button"),
    actionButton(inputId = "mercados", 
                 label = menuSubItem(HTML("<br>Mercados"),
                                     tabName = "mercados", 
                                    icon = icon("comments-dollar", class = "icon")),
                 class = "button"),
    actionButton(inputId = "setor_publico", 
                 label = menuSubItem(HTML("<br>Setor Público"),
                                     tabName = "setor_publico",
                                     icon = icon("city", class = "icon")),
                 class = "button") 
    )
}
    
#' titulo Server Function
#'
#' @noRd
mod_conj_titulo_server <- function(input, output, session) {
  ns <- session$ns

}
    
## To be copied in the UI
# mod_titulo_ui("titulo_ui_1")
    
## To be copied in the server
# callModule(mod_titulo_server, "titulo_ui_1")
