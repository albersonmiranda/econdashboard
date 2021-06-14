# EXPORTANDO DADOS DOS FUNDOS #


# sourcing Python code
reticulate::source_python("data-raw/fundos.py")

# converting to R
fundos = lapply(fundos, reticulate::py_to_r)

# exporting
usethis::use_data(fundos, overwrite = TRUE)
