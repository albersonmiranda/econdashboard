# EXPORTANDO DADOS DOS FUNDOS #


# sourcing Python code
reticulate::source_python("data-raw/fundos.py")

# converting to R
fundos = lapply(fundos, reticulate::py_to_r)

fundos = lapply(fundos, function(x){

  x$mes = readr::parse_date(paste0(x$mes, "-01"), "%Y, %B-%d", locale = readr::locale("pt"))
  x$mes[13] = "acumulado"
  x

})

# exporting
usethis::use_data(fundos, overwrite = TRUE)
