# FUNDOS DE INVESTIMENTO BANESTES #


# %% URLs dos demonstrativos
url = [
    #"https://www.banestes.com.br/investimentos/pdf/lamina_Vitoria_500.pdf",
    "https://www.banestes.com.br/investimentos/pdf/lamina_Institucional.pdf",
    "https://www.banestes.com.br/investimentos/pdf/lamina_Investidor.pdf",
    "https://www.banestes.com.br/investimentos/pdf/lamina_Invest_Money.pdf",
    "https://www.banestes.com.br/investimentos/pdf/lamina_Invest_Public.pdf",
    "https://www.banestes.com.br/investimentos/pdf/lamina_Previdenciario.pdf",
    #"https://www.banestes.com.br/investimentos/pdf/lamina_VIP_DI.pdf",
    "https://www.banestes.com.br/investimentos/pdf/lamina_Solidez.pdf",
    #"https://www.banestes.com.br/investimentos/pdf/lamina_Valores.pdf",
    "https://www.banestes.com.br/investimentos/pdf/lamina_Liquidez.pdf",
    #"https://www.banestes.com.br/investimentos/pdf/lamina_IRF_M1.pdf",
    #"https://www.banestes.com.br/investimentos/pdf/lamina_BTG_Pactual_Absoluto.pdf",
    #"https://www.banestes.com.br/investimentos/pdf/lamina_Debentures.pdf",
    "https://www.banestes.com.br/investimentos/pdf/lamina_Estrategia.pdf"
    #"https://www.banestes.com.br/investimentos/pdf/lamina_Dividendos.pdf"
    #"https://www.banestes.com.br/investimentos/pdf/lamina_Green_Stone.pdf"
    ]

# %% scrap das tabelas
import tabula
tabela_temp = []

for i, x in enumerate(url):
    tabela_temp.append(tabula.read_pdf(url[i], pages = 2, multiple_tables = True, lattice = True))

# %% limpar e formatar tabelas
tabela_pre_rename = []
for i, x in enumerate(tabela_temp):
    tabela_pre_rename.append(tabela_temp[i][2])

tabela = []
for i in tabela_pre_rename:
    tabela.append(i.rename(columns = dict(zip(i.columns, ["mes", "rentabilidade", "variacao_cdi", "desempenho_cdi"]))))

# %% tabela de nomes
names = []
for i in url:
    names.append(i[i.find("_") + 1:i.find(".pdf")])

# %% criando tabela completa
fundos = dict(zip(names, tabela))

# %% limpando demais
del [i, names, tabela, tabela_temp, tabela_pre_rename, url, x]