# EXPORTANDO DADOS DOS FUNDOS #


# sourcing Python code
reticulate::source_python("data-raw/fundos.py")

# converting to R
fundos = lapply(fundos, reticulate::py_to_r)

# correção formato data

fundos = lapply(fundos, function(x){

  x$mes = format(as.Date(paste0(x$mes, "-01"), "%Y, %B-%d"), "%Y-%m-%d")
  x$mes[13] = "acumulado"
  x

})

# exporting
usethis::use_data(fundos, overwrite = TRUE)
