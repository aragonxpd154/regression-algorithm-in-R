# Bibliotecas uteis
library(tidyverse)
library(quantmod)
library(lubridate)

# Criando variavel "macro" e armazendo tickers nessa variavel
# S??o noves tickers usado no site da FRED
# 1. PIB
# 2. CPI
# 3. LETRA DO TESOURO DE TR??S MESES
# 4. NOTA DO TESOURO DE DEZ ANOS
# 5. TAXA DE T??TULOS AAA
# 6. TAXA DE T??TULOS BAA
# 7. TAXA DE DESEMPREGO
# 8. PRODU????O INDUSTRIAL
# 9. PRE??O DO PETR??LEO BRUTO

macro <- c ("GDPC1", "CPIAUCSL","DTB3", "DGS10", "DAAA", "UNRATE", "UNRATE", "INDPRO", "DCOILWTICO")

rm(macro_factors)
# Baixando os dados com o loop "for" e usando metodo getSymbols
for (i in 1:length(macro)) {
  getSymbols(macro[i], src='FRED')
  # Renomeando data
  data <- as.data.frame(get(macro[i]))
  #Fazendo coluna de dados usando as.POSIXt
  # as.POSIXit ?? uma fun????o que vem com o R
  data$date <- as.POSIXlt.character(rownames(data))
  # Lembrando que a coluna data
  rownames(data) <- NULL
  colnames(data)[1] <- "macro_value"
  
  # Usando a fun????o "as.yearqtr" para exibir o ano e o trimestre em que cada data pertence
  data$quarter <- as.yearqtr(data$date)
  # ?? um dataframe para trazer informa????es macro difererente dados e fazer a leitura
  data$macro_ticker <- rep(macro[i], dim(data)[1])
  
  # Usandos a fun????o "ymd" para a coluna data para reconhecer como formato de pacote do cleanverse
  data <- data %>%
    mutate(date = ymd(date)) %>%
    # Usando o "group_by para criar grupo de dados trimestrais e anuais
    group_by(quarter)%>%
    # Aplicamos a fun????o "top_n" aos dados do grupo especifico
    top_n(1,date) %>%
    # Filtrando datas
    filter(date >= "1980-01-01", date <= "2019-12-31") %>%
    select(-date)
    
    if(i == 1){macro_factors <- data} else{macro_factors <- rbird(macro_factors, data)}
}

getSymbols("^GSPC", from = "1979-12-01", to = "2019-12-31", periodicity = "monthly")
SP500_returns <-  as.data.frame(quarterlyReturn(GSPC[,6]))

SP500_returns$date <- rownames(SP500_returns)

# Agora, a data ?? reconhecida ----
SP500_returns$ticker <- rep("GSPC", dim(SP500_returns)[1])
SP500_returns <- SP500_returns %>%
  mutate(date = ymd(date)) %>%
  mutate(quarter = as.yearqtr(date)) %>%
  select(-date)

data_MacroModel <- left_join(macro_factors, SP500_returns, by="quarter") %>%
  na.omit() %>%
  spread(key=macro_ticker, value=macro_value)

MacroModel <- lm(quarterly.returns ~ GDPC1+CPIAUCSL+DTB3+DGS10+DAAA+DBAA+UNRATE+INDPRO+DCOILWTICO, 
                 data=data_MacroModel, na.action = "na.exclude") %>%
  
  broom::tidy()
  knitr::kable(caption = "Resultado do Modelo Macro")
  
}