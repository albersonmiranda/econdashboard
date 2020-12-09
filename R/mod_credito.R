#' credito UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' @import shinydashboardPlus
#' @import magrittr
#' @import plotly



mod_inflacao_ui = function(id){
  ns = NS(id)
  tagList(
    
    fluidPage(
      fluidRow(
        
        # Resenha
        boxPlus(title = tags$b("INFLAÇÃO", style = ''),
                closable = FALSE, 
                width = 4,
                height = 855,
                status = NULL,
                background = "red",
                solidHeader = TRUE,
                collapsible = FALSE,
                enable_dropdown = FALSE,
                h4(style = 'text-align: justify;',
                   "O Índice Nacional de Preços ao Consumidor Amplo (IPCA) teve queda de 0,21% em novembro, conforme divulgado pelo IBGE. O resultado foi o menor desde julho de 2017, quando houve queda de 0,23%. Entre os meses de novembro, a queda é a menor desde o início do Plano Real em 1994. Em 12 meses, a inflação acumula 4,05% enquanto a taxa acumulada de 2018 é de 3,59%.",
                   br(),br(),
                   "A comportamento brando dos índices de inflação é essencial para a recuperação do consumo das famílias e do crédito, uma vez que os últimos dados mostram contração da renda média familiar durante o período de recessão.",
                   br(),br(),
                   "Para 2019, os economistas das instituições financeiras diminuíram a expectativa de inflação de 4,03% para 4,01%. A meta central do próximo ano é de 4,25%, e o intervalo de tolerância do sistema de metas varia de 2,75% a 5,75%."
                )),
        
        # Inflação
 
      )
    )
  )
}
    
#' credito Server Function
#'
#' @noRd 
mod_credito_server <- function(input, output, session){
  ns <- session$ns
 
}
    
## To be copied in the UI
# mod_credito_ui("credito_ui_1")
    
## To be copied in the server
# callModule(mod_credito_server, "credito_ui_1")
 
