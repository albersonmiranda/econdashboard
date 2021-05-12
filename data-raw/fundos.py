# FUNDOS DE INVESTIMENTO BANESTES


# URLs dos demonstrativos
url = [
    "https://www.banestes.com.br/investimentos/pdf/desempenho_VITORIA500.pdf",
    "https://www.banestes.com.br/investimentos/pdf/desempenho_DD_INSTITUCIONAL.pdf"
    ]

# função para baixar PDF (opcional)
import urllib.request as rq
caminho = ""

def download_pdf(url, nome_do_arquivo):
    response = rq.urlopen(url)
    arquivo = open(nome_do_arquivo + ".pdf", "wb")
    arquivo.write(response.read())
    arquivo.close()

# downloading PDFs (opcional)
for i in url:
    download_pdf(i, "data-raw/demonstrativos/" + i[i.find("_") + 1:i.find(".pdf")])

# scrap das tabelas
import tabula
tabela = []

for i, x in enumerate(url):
    tabela.append(tabula.read_pdf(url[i], pages = 1, multiple_tables = True, lattice = True))