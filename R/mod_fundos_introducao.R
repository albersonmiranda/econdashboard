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
      tags$div(class = "conj-tit",br(),
               "Fundos de Investimento Banestes"),
      br(),
      tags$div(class = "fundos-body",
               "Fundos de investimento funcionam como uma aplicação financeira coletiva e são administrados por gestores especializados, para uma tomada de decisão mais assertiva.",
               "Os Fundos Banestes possuem diversas modalidades de investimento, que variam de acordo com o capital aplicado e expectativa de retorno, a curto, médio ou longo prazo."),
      br(),
      tags$div(class = "fundos-body",
               "Aqui você encontra nossa lista completa com opções de Fundos em Renda Fixa, Ações e Multimercado."),
      
      br(),
      
      # Action Button
      
      actionButton(inputId = "<br>fundos_renda_fixa", 
                   label = menuSubItem(HTML("<br>Renda Fixa"),
                                       tabName = "fundos_renda_fixa", 
                                       icon = icon("chart-bar", class = "icon")),
                   class = "button"), 
      
      
      actionButton(inputId = "fundos_acoes", 
                   label = menuSubItem(HTML("<br>Ações"),
                                       tabName = "fundos_acoes", 
                                       icon = icon("chart-line", class = "icon")),
                   class = "button"),
      actionButton(inputId = "fundos_multimercado", 
                   label = menuSubItem(HTML("<br>Multimercado"),
                                       tabName = "fundos_multimercado",
                                       icon = icon("globe-americas", class = "icon")),
                   class = "button"),  
      
      tags$div(class = "fundos-body",  br(),
               "Fundos de Renda Fixa têm uma carteira composta por, pelo menos, 80% dos seus ativos em títulos de renda fixa. São fundos voltados para o investidor com perfil conservador porque os riscos são mais baixos mas, por outro lado, oferecem um potencial menor de retorno."),
      br(),
      
      tags$div(class = "fundos-body",
               "Os Fundos de Ações devem aplicar no mínimo 67% dos seus ativos em ações. São fundos voltados para o investidor com perfil mais arrojado, que tem como objetivo maior rentabilidade, e para isso está disposto a assumir maiores riscos."),
      br(),
      
      tags$div(class = "fundos-body",
               "Os Fundos Multimercados podem aplicar em diferentes ativos, como renda fixa, câmbio, ações, entre outros. Eles funcionam como meio termo, tanto quando o assunto é risco, como também quando é potencial de retorno.")
      
      
      
      
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