# Understanding the Characteristics of Factors

Este projeto script tem como objetivo processar dados financeiros e gerar gráficos para análise. Ele usa a biblioteca lubridate para trabalhar com data e hora. Pode ser usado para tratar outros volume dados especificos em R

## Etapa 1: Carregamento da Biblioteca

```bash
library(lubridate)
```

## Etapa 2: Seleção e Formatação do Dataframe

O código seleciona as primeiras 690 linhas do dataframe FF_factors, renomeia as colunas e converte algumas colunas para o formato apropriado.

```bash
df <- FF_factors[1:690, ]
colnames(df) <- c("date", "Mkt_RF", "SMB", "HML", "RMW", "CMA")
df$date <- ymd(df$date)
```

## Etapa 3: Filtro de Datas

O código define duas datas: start_date e end_date, que são usadas para filtrar as linhas de FF_factors com datas entre as duas datas definidas.

```bash
start_date <- ymd("1996-01-01")
end_date <- ymd("2018-12-31")
df <- df[df$date >= start_date & df$date <= end_date, ]
```

## Etapa 4: Resumo Estatístico

O resumo estatístico é exibido para o dataframe.

```bash
summary(df)
```

## Etapa 5: Gráficos

O código gera um gráfico de linha com as médias dos dados agrupados por ano e chave.

```bash
df_grouped <- group_by(df, year(date))
df_mean <- summarize(df_grouped, mean_Mkt_RF = mean(Mkt_RF), mean_SMB = mean(SMB), mean_HML = mean(HML), mean_RMW = mean(RMW), mean_CMA = mean(CMA))
ggplot(df_mean, aes(x = year(date))) + geom_line(aes(y = mean_Mkt_RF), color = "red") + geom_line(aes(y = mean_SMB), color = "blue") + geom_line(aes(y = mean_HML), color = "green") + geom_line(aes(y = mean_RMW), color = "yellow") + geom_line(aes(y = mean_CMA), color = "purple") + labs(x = "Ano", y = "Média") + ggtitle("Média dos Dados Agrupados por Ano")

```

O código também calcula o retorno cumulativo para as colunas Mkt_RF, SMB, HML, RMW e CMA e plota um gráfico de linha para as colunas `cum`.

## Resultado

O resultado você pode ver na imagem abaixo.

![resultado_in_R](https://github.com/aragonxpd154/regression-algorithm-in-R/blob/main/1.%20Understanding%20the%20Characteristics%20of%20Factors/Result.png)
