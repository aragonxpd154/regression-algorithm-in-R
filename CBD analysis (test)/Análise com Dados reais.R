# Carregar os dados de investimentos de CDB
#cdb <- read.csv("cdb.csv")

# Ordenar os dados pelo retorno de investimento
#cdb_ordenado <- cdb[order(cdb$retorno, decreasing = TRUE),]

# Selecionar o investimento de CDB com o maior retorno
#investimento_mais_rentavel <- head(cdb_ordenado, 1)

# Imprimir o resultado
#print(investimento_mais_rentavel)

# Carregar os dados de investimentos de CDB
cdb <- read.csv("cdb.csv")

# Calcular o retorno anualizado de cada investimento de CDB
cdb$retorno_anualizado <- (1 + cdb$retorno) ^ (1 / cdb$prazo) - 1

# Ordenar os dados pelo retorno anualizado
cdb_ordenado <- cdb[order(cdb$retorno_anualizado, decreasing = TRUE),]

# Selecionar o investimento de CDB com o maior retorno anualizado
investimento_mais_rentavel <- head(cdb_ordenado, 1)

# Imprimir o resultado
print(investimento_mais_rentavel)
