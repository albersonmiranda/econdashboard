# IMPORTAÇÃO DE RESENHAS

resenhas_conjuntura = readxl::read_excel("data-raw/resenhas/resenha-conjuntura.xlsx")

usethis::use_data(resenhas_conjuntura, overwrite = TRUE)