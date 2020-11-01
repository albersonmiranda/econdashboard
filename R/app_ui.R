#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinydashboard
#' @import shinydashboardPlus
#' @noRd


app_ui <- function(request) {
  
  data("series")
  
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here 
    dashboardPagePlus(
      dashboardHeaderPlus(title = "Econ Dashboard"),
      dashboardSidebar(width = 150,
                       sidebarMenu(
                         menuItem("Conjuntura", tabName = "conjuntura", icon = icon("chart-bar")),
                         menuItem("Mapas", tabName = "mapas", icon = icon("globe-americas"))
                       )
      ),
      dashboardBody(
        tabItems(
          tabItem(tabName = "conjuntura",
                  mod_titulo_ui("titulo_ui_1"),
                  mod_atividade_economica_ui("atividade_economica_ui_1"),
                  mod_atividade_economica_es_ui("atividade_economica_es_ui_1"),
                  mod_mercados_ui("mercados_ui_1"),
                  mod_inflacao_ui("inflacao_ui_1")
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


golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'econdashboard'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

