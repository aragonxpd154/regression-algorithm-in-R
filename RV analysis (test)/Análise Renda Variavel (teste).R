# Carregar biblioteca tidyr para manipulação de dados
library(tidyr)

# Carregar dados do arquivo CSV para o data frame "stocks"
stocks <- read.csv("dados_acoes.csv")

# Transformar data em formato de data
stocks$date <- as.Date(stocks$date, format = "%Y-%m-%d")

# Agrupar dados por símbolo de ação e data
stocks_grouped <- stocks %>% 
  group_by(symbol, date) %>% 
  summarise(mean_price = mean(price))

# Plotar gráfico de linha para a média de preços por símbolo de ação e data
ggplot(stocks_grouped, aes(x = date, y = mean_price, color = symbol)) +
  geom_line() +
  ggtitle("Gráfico de Preços Médios por Símbolo de Ação e Data")

#Verificação gráfico de linha para tirar a mediana por símbolo de ação e data (Para Teste)
ggplot(strocks_grouped, aes (x=date, y= mean_pricem color= symbol))+
geom_linha() +
ggtitle("Grafico mediana")