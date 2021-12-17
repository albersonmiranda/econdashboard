# IMPORTANDO DADOS DE RELATORIOS
PIB_capixaba = readxl::read_excel("data-raw/dados_relatorios/PIB-ES.xlsx")

usethis::use_data(PIB_capixaba, overwrite = TRUE)
