### Dados para o Econ Dashboard ###


# 1. FUNÇÕES
# Function to get series with retries
get_series_with_retries <- function(series_id, max_retries = 5, wait_time = 5, start_date = NULL, end_date = NULL) {
  retry_count <- 0
  success <- FALSE

  while (!success && retry_count < max_retries) {
    try(
      {
        serie <- rbcb::get_series(series_id, start_date = start_date, end_date = end_date)
        success <- TRUE
      },
      silent = TRUE
    )

    if (!success) {
      retry_count <- retry_count + 1
      message(paste("Attempt", retry_count, "failed. Retrying in", wait_time, "seconds..."))
      Sys.sleep(wait_time)
    }
  }

  if (!success) {
    stop("Failed to retrieve series after", max_retries, "attempts.")
  }

  names(serie) <- c("date", "value")

  return(serie)
}

# 2. SERIES ------------------------------------------------------------------


# 2.1 Brasil -----------------------------------------------------------------


# PIB em US$ tri ----
PIB = get_series_with_retries(7324)

# PIB em R$ milhões ----
PIBmensal = get_series_with_retries(4380) # PIB mensal em valores correntes

# taxas de variação anual ----
PIBvar = get_series_with_retries(7326)
PIBvarA = get_series_with_retries(7327) # agropecuaria
PIBvarI = get_series_with_retries(7328) # industria
PIBvarS = get_series_with_retries(7329) # serviços

# PIB trimestral em índice
PIBtriobs = get_series_with_retries(22099)

# PIB trimestral dessazonalizado em índice ----
PIBtri = get_series_with_retries(22109)
PIBtriA = get_series_with_retries(22105) # agropecuaria
PIBtriI = get_series_with_retries(22106) # industria
PIBtriS = get_series_with_retries(22107) # servicos
PIBtriF = get_series_with_retries(22110) # consumo das famílias
PIBtriG = get_series_with_retries(22111) # consumo do governo

# IBC-Br trimestral ----
IBCBr = get_series_with_retries(24363)
IBCBrs = get_series_with_retries(24364)

# Serviços e Comércio ----
Varejos = get_series_with_retries(28473) # índice volume de vendas no varejo dessazonalizado
Varejo = get_series_with_retries(1455) # índice volume de vendas no varejo
Servicos = get_series_with_retries(21637) # índice receita nominal de serviços
Vol.Servicos = get_series_with_retries(23982) # índice volume de serviços
ICC = get_series_with_retries(4393) # índice confiança do consumidor
ICE = get_series_with_retries(4394) # índice de condições econômicas atuais
IEF = get_series_with_retries(4395) # índice de expectativas futuras
ExpBR = get_series_with_retries(22708) # exportação de bens free on board
ConsumoPetro = get_series_with_retries(1398) # consumo de barril de petroleo por dia

# Industria
IndustriaBR = get_series_with_retries(21859) # indicadores de produção industrial mensal

# Mercado de trabalho ----
Emprego = get_series_with_retries(25239) # índice de emprego formal
Empregos = get_series_with_retries(28512) # índice de emprego dessazonalizado
Desemprego = get_series_with_retries(24369) # taxa de desemprego
DesempregoSE = get_series_with_retries(28565) # taxa de desemprego, região sudeste

# Renda ----
Renda = get_series_with_retries(24382) # rendimento médio real habitual das pessoas ocupadas - PNADC
RendaC = get_series_with_retries(24383) # rendimento médio real habitual das pessoas ocupadas - carteira
RendaSC = get_series_with_retries(24384) # rendimento médio real habitual das pessoas ocupadas - sem carteira
RendaPriv = get_series_with_retries(24385) # rendimento médio real habitual das pessoas ocupadas - setor privado
RendaPub = get_series_with_retries(24386) # rendimento médio real habitual das pessoas ocupadas - setor publico
RendaCP = get_series_with_retries(24387) # rendimento médio real habitual das pessoas ocupadas - conta própia

# Preços ----
IPCA = get_series_with_retries(433, end_date = "1995-01-01") # Indice nacional de Preços ao consumidor-Amplo IBGE
IGPM = get_series_with_retries(189, end_date = "1995-01-01") # Indice Geral de Preços do Mercado FGV
IPCBr = get_series_with_retries(191, end_date = "1995-01-01") # Indice de Precos ao Consumidor-Brasil FGV
ICV = get_series_with_retries(194, end_date = "1995-01-01") # Indice Custo de Vida Dieese variação % mensal
CapInst = get_series_with_retries(1344) # Utilização da capacidade instalada % (FGV)
IPCAtransportes = get_series_with_retries(1398, end_date = "1999-08-31") # Subitem transportes de IPCA
IPCA12mes = get_series_with_retries(13522) # Indice nacional de Preços ao consumidor-Amplo dos ultimos 12 meses IBGE

# Setor público ----
ResultadoBR = get_series_with_retries(4792) # NFSP sem desvalorização cambial - Fluxo acumulado no ano - Resultado primário
ResultadoBR.PIB = get_series_with_retries(5507, end_date = "2001-12-01") # NFSP sem desvalorização cambial - Fluxo acumulado no ano - Resultado primário (%PIB)
PrimarioBR = get_series_with_retries(4782) # NFSP sem desvalorização cambial - Governo federal e Banco central - Fluxo acumulado no ano
DividaLiqBR = get_series_with_retries(4478) # Dívida Líquida do Setor Público - Saldos em R$ milhões
DividaLiqBR.PIB = get_series_with_retries(4513) # Dívida Líquida do Setor pÚBLICO - % do PIB
DividaBrutaBR = get_series_with_retries(13761) # Divida bruta do Governo Geral - Saldo em R$ mi
DividaBrutaBR.PIB = get_series_with_retries(13762, end_date = "2006-12-01") # Dívida bruta do Governo Geral - % do PIB

# Mercado financeiro ----
Selic = get_series_with_retries(432) # 	Meta definida pelo Copom
Dolar = get_series_with_retries(10813) # 	Taxa de Cambio Livre, Dolar, Compra
InadBR = get_series_with_retries(21085)
InadBRPF = get_series_with_retries(21112)
InadBRPJ = get_series_with_retries(21086)
Endi = get_series_with_retries(19882) # Endividamento das familias com o Sistema Financeiro Nacional em relacao a renda acumulada dos ultimos doze meses
End = get_series_with_retries(20400) # Endividamento das familias com o Sistema Financeiro Nacional exceto credito habitacional em relacao a renda acumulada dos ultimos doze meses
PTCC_grandes = get_series_with_retries(21397) # Pesquisa Trimestral de Condições de Crédito - Grandes Empresas - Aprovações observadas
PTCC_mpme = get_series_with_retries(21399) # Pesquisa Trimestral de Condições de Crédito - Micro, Pequenas e Médias Empresas - Aprovações observadas
PTCC_consumo = get_series_with_retries(21401) # Pesquisa Trimestral de Condições de Crédito - Crédito para consumo - Aprovações observadas
PTCC_habitacao = get_series_with_retries(21403) # Pesquisa Trimestral de Condições de Crédito - Crédito habitacional - Aprovações observadas


# 2.2 Espírito Santo ---------------------------------------------------------


# PIB ----
PIBES = get_series_with_retries(24093) # PIB corrente a preços de mercado (Ref. 2010)
PIBvarES = get_series_with_retries(24094) # variação anual real

# Índice de Atividade Econômica Regional ----
IBCRES = get_series_with_retries(25398) # dessazonalizado
IBCRESs = get_series_with_retries(25399) # dessazonalizado

# Serviços e Comércio ----
VarejoES = get_series_with_retries(1473) # índice volume de vendas no varejo
ServicosES = get_series_with_retries(28134) # índice pesquisa mensal serviços
ServicosESs = get_series_with_retries(28033) # índice pesquisa mensal serviços
ExpES = get_series_with_retries(13386) # exportação de bens em US$ milhares
PIM.ES = get_series_with_retries(21926) # produção industrial mensal

# Mercado de Trabalho ----
EmpregoES = get_series_with_retries(28308) # índice de emprego formal
EmpregoGES = get_series_with_retries(12985) # empregos formais gerados em unidade

# Preços ----
CestaES = get_series_with_retries(7494) # custo da cesta básica de Vitória

# Setor Público ----
ResultadoES = get_series_with_retries(14923) # resultado primário do ES (Estado e municípios) acumulado no ano em milhões
ResultadotriES = get_series_with_retries(14819) # resultado primário do ES (Estado e municípios) no trimestre em milhões
DividaES = get_series_with_retries(15141) # dívida líquida do ES (Estado e municípios)

# Mercado Financeiro ----
SaldoESPF = get_series_with_retries(14009) # saldo das operações de crédito em milhões
SaldoESPJ = get_series_with_retries(14036)
SaldoES = get_series_with_retries(14063)
InadESPF = get_series_with_retries(15868) # inadimplência %
InadESPJ = get_series_with_retries(15900)
InadES = get_series_with_retries(15932)
CreditoPIB = get_series_with_retries(20622) # Saldo das operações de crédito em % em relação ao PIB
saldocredito = get_series_with_retries(20539) # Saldo todas das operações de crédito
creditolivrepj = get_series_with_retries(20635) # saldo de credito livre a pj
creditolivrepf = get_series_with_retries(20662) # saldo de credito livre a pf
creditodirecionapj = get_series_with_retries(20686) # saldo de credito livre a pj
creditodirecionadopf = get_series_with_retries(20698) # saldo de credito livre a pf
novasconcessoespj = get_series_with_retries(20632) # novas contratações de crédito por pj
novasconcessoespf = get_series_with_retries(20633) # novas contratações de crédito por pf

# 2.3 Outros -----------------------------------------------------------------
series = mget(ls())

# gravar data
usethis::use_data(series, overwrite = TRUE)
