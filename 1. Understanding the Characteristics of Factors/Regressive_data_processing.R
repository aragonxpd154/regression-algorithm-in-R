
library(lubridate)
FF_factors <- FF_factors[1:690,] %>% 
  rename(date = ...1, Mkt_RF = 'Mkt-RF') %>%
  mutate(date = ymd(paste(substr(date,1,4),"-",substr(date,5,6),"-01"))) %>%
  mutate(date = rollback(date+months(1))) %>%
  mutate_at(vars(-date), as.numeric)

start_date <- "1979-12-01"
end_date <- "2020-12-31"

FF_factors <- FF_factors %>%
  filter(date >= start_date, date <= end_date)

summary(FF_factors)

FF_factors %>%
  mutate(date = year(date)) %>%
  filter(date > 1979) %>%
  gather(key=key, value = value,-date) %>%
  group_by(date, key) %>%
  summarise(value=mean(value)) %>%
  ggplot(aes(x = date,y = value, color = key)) + 
  geom_line()

FF_factors_Return <- FF_factors %>% filter(year(date)>1979)

per.to.dec <- function(x) {x/100}

FF_factors_CumReturn <- FF_factors_Return %>% mutate_at(vars(-date), per.to.dec)%>%
  mutate(cum_Mkt_RF = cumprod(1+Mkt_RF)-1)%>%
  mutate(cum_SMB = cumprod(1+SMB)-1)%>%
  mutate(cum_HML = cumprod(1+HML)-1)%>%
  mutate(cum_RMW = cumprod(1+RMW)-1)%>%
  mutate(cum_CMA = cumprod(1+CMA)-1)

FF_factors_CumReturn %>% select(date, cum_SMB, cum_HML) %>%
  gather(key = key, value = value, -date) %>%
  ggplot(aes(x=date, y=value, color=key))+
  geom_line()
  
  
