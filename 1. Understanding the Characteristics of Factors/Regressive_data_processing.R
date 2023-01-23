library(lubridate) # Carrega a biblioteca lubridate que permite trabalhar com data e hora
FF_factors <- FF_factors[1:690,] %>% # Seleciona as primeiras 690 linhas do dataframe FF_factors
rename(date = ...1, Mkt_RF = 'Mkt-RF') %>% # Renomeia a coluna ...1 para "date" e "Mkt-RF" para "Mkt_RF"
mutate(date = ymd(paste(substr(date,1,4),"-",substr(date,5,6),"-01"))) %>% # Converte a coluna date para o formato date (yyyy-mm-dd)
mutate(date = rollback(date+months(1))) %>% # Decrementa a data em 1 mês
mutate_at(vars(-date), as.numeric) # Converte todas as variáveis, exceto a data, para numéricas

start_date <- "1979-12-01" # Define a data inicial como 1979-12-01
end_date <- "2020-12-31" # Define a data final como 2020-12-31

FF_factors <- FF_factors %>% # Seleciona as linhas de FF_factors com data entre start_date e end_date
filter(date >= start_date, date <= end_date)

summary(FF_factors) # Exibe um resumo estatístico do dataframe

FF_factors %>%
mutate(date = year(date)) %>% # Converte a coluna date para o formato ano
filter(date > 1979) %>% # Filtra as linhas com ano maior que 1979
gather(key=key, value = value,-date) %>% # Transforma as colunas em linhas
group_by(date, key) %>% # Agrupa as linhas por ano e chave
summarise(value=mean(value)) %>% # Calcula a média dos valores agrupados
ggplot(aes(x = date,y = value, color = key)) +
geom_line() # Plota as médias agrupadas por ano e chave

FF_factors_Return <- FF_factors %>% filter(year(date)>1979) # Seleciona as linhas de FF_factors com ano maior que 1979

per.to.dec <- function(x) {x/100} # Define uma função para converter porcentagem para decimal

FF_factors_CumReturn <- FF_factors_Return %>% mutate_at(vars(-date), per.to.dec)%>% # é usada para aplicar a função per.to.dec (que divide por 100) a todas as variáveis da tabela FF_factors_Return exceto a coluna date.
  mutate(cum_Mkt_RF = cumprod(1+Mkt_RF)-1)%>% # calcula o retorno cumulativo para a coluna Mkt_RF usando a função cumprod (que calcula o produto cumulativo) e subtrai 1 do resultado final.
  mutate(cum_SMB = cumprod(1+SMB)-1)%>% # fazem o mesmo cálculo cima para as colunas SMB, HML, RMW e CMA, respectivamente.
  mutate(cum_HML = cumprod(1+HML)-1)%>% 
  mutate(cum_RMW = cumprod(1+RMW)-1)%>% 
  mutate(cum_CMA = cumprod(1+CMA)-1)

FF_factors_CumReturn %>% select(date, cum_SMB, cum_HML) %>% # seleciona as colunas date, cum_SMB, cum_HML da tabela FF_factors_CumReturn
  gather(key = key, value = value, -date) %>% # agrupa as colunas selecionadas em uma única coluna chamada value e uma coluna chave key
  ggplot(aes(x=date, y=value, color=key))+ # plota um gráfico de linha com a coluna date no eixo x, coluna value no eixo y e key como a cor da linha.
  geom_line()
  
  
