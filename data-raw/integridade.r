# teste de integridade das séries


# realizar teste de NA em todas as séries
teste = lapply(series, function(x) {
    any(is.na(x))
})

# escolher as séries que devem ser refeitas
series_redo = names(which(teste == TRUE))

# obter o script para executar as séries
script = readLines("data-raw/series.R")

# loop para refazer as séries
for (i in series_redo) {
    eval(
        parse(
            text = script[grepl(i, script)]
        )
    )
}

# remover objeto series e remontar
remove(series)
series = mget(ls())

# gravar data
usethis::use_data(series, overwrite = TRUE)
