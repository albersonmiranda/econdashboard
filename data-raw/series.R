### Dados para o Econ Dashboard ###


# 2. SERIES ------------------------------------------------------------------


# 2.1 Brasil -----------------------------------------------------------------


# PIB em US$ tri ----
PIB = get_series_with_retries(7324, max_retries = 10, wait_time = 20)

# PIB em R$ milhões ----
PIBmensal = get_series_with_retries(4380, max_retries = 10, wait_time = 20) # PIB mensal em valores correntes

# taxas de variação anual ----
PIBvar = get_series_with_retries(7326, max_retries = 10, wait_time = 20)
PIBvarA = get_series_with_retries(7327, max_retries = 10, wait_time = 20) # agropecuaria
PIBvarI = get_series_with_retries(7328, max_retries = 10, wait_time = 20) # industria
PIBvarS = get_series_with_retries(7329, max_retries = 10, wait_time = 20) # serviços

# PIB trimestral em índice
PIBtriobs = get_series_with_retries(22099, max_retries = 10, wait_time = 20)

# PIB trimestral dessazonalizado em índice ----
PIBtri = get_series_with_retries(22109, max_retries = 10, wait_time = 20)
PIBtriA = get_series_with_retries(22105, max_retries = 10, wait_time = 20) # agropecuaria
PIBtriI = get_series_with_retries(22106, max_retries = 10, wait_time = 20) # industria
PIBtriS = get_series_with_retries(22107, max_retries = 10, wait_time = 20) # servicos
PIBtriF = get_series_with_retries(22110, max_retries = 10, wait_time = 20) # consumo das famílias
PIBtriG = get_series_with_retries(22111, max_retries = 10, wait_time = 20) # consumo do governo

# IBC-Br trimestral ----
IBCBr = get_series_with_retries(24363, max_retries = 10, wait_time = 20)
IBCBrs = get_series_with_retries(24364, max_retries = 10, wait_time = 20)

# Serviços e Comércio ----
Varejos = get_series_with_retries(28473, max_retries = 10, wait_time = 20) # índice volume de vendas no varejo dessazonalizado
Varejo = get_series_with_retries(1455, max_retries = 10, wait_time = 20) # índice volume de vendas no varejo
Servicos = get_series_with_retries(21637, max_retries = 10, wait_time = 20) # índice receita nominal de serviços
Vol.Servicos = get_series_with_retries(23982, max_retries = 10, wait_time = 20) # índice volume de serviços
ICC = get_series_with_retries(4393, max_retries = 10, wait_time = 20) # índice confiança do consumidor
ICE = get_series_with_retries(4394, max_retries = 10, wait_time = 20) # índice de condições econômicas atuais
IEF = get_series_with_retries(4395, max_retries = 10, wait_time = 20) # índice de expectativas futuras
ExpBR = get_series_with_retries(22708, max_retries = 10, wait_time = 20) # exportação de bens free on board
ConsumoPetro = get_series_with_retries(1398, max_retries = 10, wait_time = 20) # consumo de barril de petroleo por dia

# Industria
IndustriaBR = get_series_with_retries(21859, max_retries = 10, wait_time = 20) # indicadores de produção industrial mensal

# Mercado de trabalho ----
Emprego = get_series_with_retries(25239, max_retries = 10, wait_time = 20) # índice de emprego formal
Empregos = get_series_with_retries(28512, max_retries = 10, wait_time = 20) # índice de emprego dessazonalizado
Desemprego = get_series_with_retries(24369, max_retries = 10, wait_time = 20) # taxa de desemprego
DesempregoSE = get_series_with_retries(28565, max_retries = 10, wait_time = 20) # taxa de desemprego, região sudeste

# Renda ----
Renda = get_series_with_retries(24382, max_retries = 10, wait_time = 20) # rendimento médio real habitual das pessoas ocupadas - PNADC
RendaC = get_series_with_retries(24383, max_retries = 10, wait_time = 20) # rendimento médio real habitual das pessoas ocupadas - carteira
RendaSC = get_series_with_retries(24384, max_retries = 10, wait_time = 20) # rendimento médio real habitual das pessoas ocupadas - sem carteira
RendaPriv = get_series_with_retries(24385, max_retries = 10, wait_time = 20) # rendimento médio real habitual das pessoas ocupadas - setor privado
RendaPub = get_series_with_retries(24386, max_retries = 10, wait_time = 20) # rendimento médio real habitual das pessoas ocupadas - setor publico
RendaCP = get_series_with_retries(24387, max_retries = 10, wait_time = 20) # rendimento médio real habitual das pessoas ocupadas - conta própia

# Preços ----
IPCA = get_series_with_retries(433, max_retries = 10, wait_time = 20, start_date = "1995-01-01") # Indice nacional de Preços ao consumidor-Amplo IBGE
IGPM = get_series_with_retries(189, max_retries = 10, wait_time = 20, start_date = "1995-01-01") # Indice Geral de Preços do Mercado FGV
IPCBr = get_series_with_retries(191, max_retries = 10, wait_time = 20, start_date = "1995-01-01") # Indice de Precos ao Consumidor-Brasil FGV
ICV = get_series_with_retries(194, max_retries = 10, wait_time = 20, start_date = "1995-01-01") # Indice Custo de Vida Dieese variação % mensal
CapInst = get_series_with_retries(1344, max_retries = 10, wait_time = 20) # Utilização da capacidade instalada % (FGV)
IPCAtransportes = get_series_with_retries(1398, max_retries = 10, wait_time = 20, start_date = "1999-08-31") # Subitem transportes de IPCA
IPCA12mes = get_series_with_retries(13522, max_retries = 10, wait_time = 20) # Indice nacional de Preços ao consumidor-Amplo dos ultimos 12 meses IBGE

# Setor público ----
ResultadoBR = get_series_with_retries(4792, max_retries = 10, wait_time = 20) # NFSP sem desvalorização cambial - Fluxo acumulado no ano - Resultado primário
ResultadoBR.PIB = get_series_with_retries(5507, max_retries = 10, wait_time = 20, start_date = "2001-12-01") # NFSP sem desvalorização cambial - Fluxo acumulado no ano - Resultado primário (%PIB)
PrimarioBR = get_series_with_retries(4782, max_retries = 10, wait_time = 20) # NFSP sem desvalorização cambial - Governo federal e Banco central - Fluxo acumulado no ano
DividaLiqBR = get_series_with_retries(4478, max_retries = 10, wait_time = 20) # Dívida Líquida do Setor Público - Saldos em R$ milhões
DividaLiqBR.PIB = get_series_with_retries(4513, max_retries = 10, wait_time = 20) # Dívida Líquida do Setor pÚBLICO - % do PIB
DividaBrutaBR = get_series_with_retries(13761, max_retries = 10, wait_time = 20) # Divida bruta do Governo Geral - Saldo em R$ mi
DividaBrutaBR.PIB = get_series_with_retries(13762, max_retries = 10, wait_time = 20, start_date = "2006-12-01") # Dívida bruta do Governo Geral - % do PIB

# Mercado financeiro ----
Selic = get_series_with_retries(432, max_retries = 10, wait_time = 20) # 	Meta definida pelo Copom
Dolar = get_series_with_retries(10813, max_retries = 10, wait_time = 20) # 	Taxa de Cambio Livre, Dolar, Compra
InadBR = get_series_with_retries(21085, max_retries = 10, wait_time = 20)
InadBRPF = get_series_with_retries(21112, max_retries = 10, wait_time = 20)
InadBRPJ = get_series_with_retries(21086, max_retries = 10, wait_time = 20)
Endi = get_series_with_retries(19882, max_retries = 10, wait_time = 20) # Endividamento das familias com o Sistema Financeiro Nacional em relacao a renda acumulada dos ultimos doze meses
End = get_series_with_retries(20400, max_retries = 10, wait_time = 20) # Endividamento das familias com o Sistema Financeiro Nacional exceto credito habitacional em relacao a renda acumulada dos ultimos doze meses
PTCC_grandes = get_series_with_retries(21397, max_retries = 10, wait_time = 20) # Pesquisa Trimestral de Condições de Crédito - Grandes Empresas - Aprovações observadas
PTCC_mpme = get_series_with_retries(21399, max_retries = 10, wait_time = 20) # Pesquisa Trimestral de Condições de Crédito - Micro, Pequenas e Médias Empresas - Aprovações observadas
PTCC_consumo = get_series_with_retries(21401, max_retries = 10, wait_time = 20) # Pesquisa Trimestral de Condições de Crédito - Crédito para consumo - Aprovações observadas
PTCC_habitacao = get_series_with_retries(21403, max_retries = 10, wait_time = 20) # Pesquisa Trimestral de Condições de Crédito - Crédito habitacional - Aprovações observadas


# 2.2 Espírito Santo ---------------------------------------------------------


# PIB ----
PIBES = get_series_with_retries(24093, max_retries = 10, wait_time = 20) # PIB corrente a preços de mercado (Ref. 2010)
PIBvarES = get_series_with_retries(24094, max_retries = 10, wait_time = 20) # variação anual real

# Índice de Atividade Econômica Regional ----
IBCRES = get_series_with_retries(25398, max_retries = 10, wait_time = 20) # dessazonalizado
IBCRESs = get_series_with_retries(25399, max_retries = 10, wait_time = 20) # dessazonalizado

# Serviços e Comércio ----
VarejoES = get_series_with_retries(1473, max_retries = 10, wait_time = 20) # índice volume de vendas no varejo
ServicosES = get_series_with_retries(28134, max_retries = 10, wait_time = 20) # índice pesquisa mensal serviços
ServicosESs = get_series_with_retries(28033, max_retries = 10, wait_time = 20) # índice pesquisa mensal serviços
ExpES = get_series_with_retries(13386, max_retries = 10, wait_time = 20) # exportação de bens em US$ milhares
PIM.ES = get_series_with_retries(21926, max_retries = 10, wait_time = 20) # produção industrial mensal

# Mercado de Trabalho ----
EmpregoES = get_series_with_retries(28308, max_retries = 10, wait_time = 20) # índice de emprego formal
EmpregoGES = get_series_with_retries(12985, max_retries = 10, wait_time = 20) # empregos formais gerados em unidade

# Preços ----
CestaES = get_series_with_retries(7494, max_retries = 10, wait_time = 20) # custo da cesta básica de Vitória

# Setor Público ----
ResultadoES = get_series_with_retries(14923, max_retries = 10, wait_time = 20) # resultado primário do ES (Estado e municípios) acumulado no ano em milhões
ResultadotriES = get_series_with_retries(14819, max_retries = 10, wait_time = 20) # resultado primário do ES (Estado e municípios) no trimestre em milhões
DividaES = get_series_with_retries(15141, max_retries = 10, wait_time = 20) # dívida líquida do ES (Estado e municípios)

# Mercado Financeiro ----
SaldoESPF = get_series_with_retries(14009, max_retries = 10, wait_time = 20) # saldo das operações de crédito em milhões
SaldoESPJ = get_series_with_retries(14036, max_retries = 10, wait_time = 20)
SaldoES = get_series_with_retries(14063, max_retries = 10, wait_time = 20)
InadESPF = get_series_with_retries(15868, max_retries = 10, wait_time = 20) # inadimplência %
InadESPJ = get_series_with_retries(15900, max_retries = 10, wait_time = 20)
InadES = get_series_with_retries(15932, max_retries = 10, wait_time = 20)
CreditoPIB = get_series_with_retries(20622, max_retries = 10, wait_time = 20) # Saldo das operações de crédito em % em relação ao PIB
saldocredito = get_series_with_retries(20539, max_retries = 10, wait_time = 20) # Saldo todas das operações de crédito
creditolivrepj = get_series_with_retries(20635, max_retries = 10, wait_time = 20) # saldo de credito livre a pj
creditolivrepf = get_series_with_retries(20662, max_retries = 10, wait_time = 20) # saldo de credito livre a pf
creditodirecionapj = get_series_with_retries(20686, max_retries = 10, wait_time = 20) # saldo de credito livre a pj
creditodirecionadopf = get_series_with_retries(20698, max_retries = 10, wait_time = 20) # saldo de credito livre a pf
novasconcessoespj = get_series_with_retries(20632, max_retries = 10, wait_time = 20) # novas contratações de crédito por pj
novasconcessoespf = get_series_with_retries(20633, max_retries = 10, wait_time = 20) # novas contratações de crédito por pf

# 2.3 Outros -----------------------------------------------------------------
series = mget(ls())

# gravar data
usethis::use_data(series, overwrite = TRUE)
