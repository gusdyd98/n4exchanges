library(httr)
library(rvest)
library(dplyr)
library(tibble)

tar<-"https://finance.naver.com/marketindex/exchangeList.nhn"

Sys.setlocale("LC_ALL", "C")

read_html(tar, encoding = "euc-kr") %>%
  html_nodes("table.tbl_exchange") %>%
  html_table(fill=T) %>%
  .[[1]] -> exc

Sys.setlocale("LC_ALL", "Korean_Korea.949")

na1 <- names(exc)
na2 <- exc %>% 
  dplyr::rowwise() %>%
  slice(1) %>%
  as.character()
na1
na2

names(exc)[3] <- "현찰 사실 때"
names(exc)[4] <- "현찰 파실 때"
names(exc)[5] <- "송금 보내실 때"
names(exc)[6] <- "송금 보내실 떄"
exc

exc %>%
  slice(-1) -> exc
exc

tar<-"https://finance.naver.com/marketindex/"

read_html(tar, encoding="euc-kr") %>%
  html_nodes("div.exchange_info span") %>%
  html_text() -> dat_data

t_data<-cbind(dat_data[1], dat_data[2], dat_data[3], exc)
t_data
t_data<-tibble(dat_data[1], dat_data[2], dat_data[3], exc)
t_data

names(t_data)[1]<-"date"
names(t_data)[2]<-"고시기준"
names(t_data)[3]<-"고시회차"

head(t_data,2)


