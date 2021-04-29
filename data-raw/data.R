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
    "Nivel" = c("B", "C", "D", "E", "F", "G", "H"),
    "Prov" = c(0.01, 0.03, 0.1, 0.3, 0.5, 0.7, 1),
    "Diasi" = c(16, 31, 61, 91, 121, 151, 181),
    "Dias2" = c(30, 60, 122, 182, 242, 302, 362)
)