# IMPORTAÇÃO DE LEGENDA DE GRÁFICOS CONJUNTURA

legenda_conjuntura = readxl::read_excel("data-raw/resenhas/legenda-conjuntura.xlsx")

usethis::use_data(legenda_conjuntura, overwrite = TRUE)