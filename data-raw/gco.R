# CRIAR DADOS FALSOS PARA A ABA RISCO

# Dados pessoa física
pf = data.frame(
    nome = charlatan::ch_name(10000), tipo_cli = 1,
    modalidade = sample(
        c("Cartão de Crédito", "Empréstimo Pessoal", "Imobiliário", "Cheque Especial", "Consignado"),
        size = 10000,
        replace = TRUE
    ),
    agencia = sample(1L:50L, 10000, replace = TRUE),
    saldo_contabil = sample(100L:50000L, 10000, replace = TRUE),
    dias_atraso = sample(
        0L:365L,
        10000,
        replace = TRUE,
        prob = c(99, seq(from = 1, to = 0, length.out = 365))
    )
)

# Dados pessoa jurídica
pj = data.frame(
    nome = charlatan::ch_company(1000),
    tipo_cli = 2,
    modalidade = sample(c("Capital de Giro", "Desconto de Títulos", "Conta Garantida", "Cartão de Crédito", "Financiamento de Bens"),
        size = 1000,
        replace = TRUE
    ),
    agencia = sample(1L:50L, 1000, replace = TRUE),
    saldo_contabil = sample(100L:50000L, 1000, replace = TRUE),
    dias_atraso = sample(0L:365L, 1000,
        replace = TRUE,
        prob = c(99, seq(from = 1, to = 0, length.out = 365))
    )
)

# Classificação de Risco
class_risco = data.frame(
    "Nivel" = c("A", "B", "C", "D", "E", "F", "G", "H"),
    "Prov" = c(0, 0.01, 0.03, 0.1, 0.3, 0.5, 0.7, 1),
    "Dias_i" = c(0, 16, 31, 61, 91, 121, 151, 181),
    "Dias_f" = c(15, 30, 60, 122, 182, 242, 302, 362)
)

# Classificando dados PF
pf$class_risco = sapply(pf$dias_atraso, function(x) {

    diferenca = ifelse(x - class_risco$Dias_i >= 0, x - class_risco$Dias_i, NA)
    class_risco[which.min(diferenca), ]$Nivel

})

pf$pdd = class_risco[match(pf$class_risco, class_risco$Nivel), ]$Prov * pf$saldo_contabil

pf$class_estimada = sapply(ifelse(pf$dias_atraso > 0, pf$dias_atraso + 30, 0), function(x) {

    diferenca = ifelse(x - class_risco$Dias_i >= 0, x - class_risco$Dias_i, NA)
    class_risco[which.min(diferenca), ]$Nivel

})

pf$pdd_estimado = class_risco[match(pf$class_estimada, class_risco$Nivel), ]$Prov * pf$saldo_contabil

pf$impacto_pdd = pf$pdd_estimado - pf$pdd

# Classificando dados PJ
pj$class_risco = sapply(pj$dias_atraso, function(x) {

    diferenca = ifelse(x - class_risco$Dias_i >= 0, x - class_risco$Dias_i, NA)
    class_risco[which.min(diferenca), ]$Nivel

})

pj$pdd = class_risco[match(pj$class_risco, class_risco$Nivel), ]$Prov * pj$saldo_contabil

pj$class_estimada = sapply(ifelse(pj$dias_atraso > 0, pj$dias_atraso + 30, 0), function(x) {

    diferenca = ifelse(x - class_risco$Dias_i >= 0, x - class_risco$Dias_i, NA)
    class_risco[which.min(diferenca), ]$Nivel

})

pj$pdd_estimado = class_risco[match(pj$class_estimada, class_risco$Nivel), ]$Prov * pj$saldo_contabil

pj$impacto_pdd = pj$pdd_estimado - pj$pdd

# Salvando dados
gco = list(pf, pj)
usethis::use_data(gco, overwrite = TRUE)
