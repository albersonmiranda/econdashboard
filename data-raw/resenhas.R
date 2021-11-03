# IMPORTAÇÃO DAS RESENHAS

resenhas_fundos = readxl::read_excel("data-raw/resenhas/fundos.xlsx")
resenhas_conjuntura = readxl::read_excel("data-raw/resenhas/conjuntura.xlsx")

usethis::use_data(resenhas_conjuntura, overwrite = TRUE)
usethis::use_data(resenhas_fundos, overwrite = TRUE)
