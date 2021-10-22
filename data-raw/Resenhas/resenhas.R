# Importando resenhas 

resenhas_conjuntura = readxl::read_excel("data-raw/Resenhas/resenha-conjuntura.xlsx")

usethis::use_data(resenhas_conjuntura, overwrite = TRUE)