# IMPORTAÇÃO DAS RESENHAS

resenhas_fundos = readxl::read_excel("data-raw/resenhas/fundos.xlsx")

usethis::use_data(resenhas_fundos, overwrite = TRUE)
