load("voegel.rda")

library("tidyverse")
library("ggplot2")
library("fable")
library("tsibble")
library("feasts")
library("urca")

###############
# Predictions - Vögel

#ALL
ts_all_voegel <- ts(voegel$`Bestand repraesentativer Vogelarten, insgesamt`[1:27], start = 1990, frequency = 1)
tsb_all_voegel <- as_tsibble(ts_all_voegel)

gg_all_voegel_arima <- list()
for (i in 1:50) 
{
  gg <- tsb_all_voegel %>% model(ARIMA(value)) %>% forecast(h = i) %>% autoplot(tsb_all_voegel)
  gg <- gg  + ggtitle("Bestand repraesentativer Vogelarten (insgesamt)", subtitle = "Prognose ab 2016")+ theme_minimal() + 
    ylab("Vogelbestandsindex") + xlab("")
  gg_all_voegel_arima[[i]] <- gg
}
save(gg_all_voegel_arima, file = "gg_all_voegel_arima.rda")


gg_all_voegel_ets <- list()
for (i in 1:50) 
{
  gg1 <- tsb_all_voegel %>% model(ETS(value)) %>% forecast(h = i) %>% autoplot(tsb_all_voegel)
  gg1 <- gg1  + ggtitle("Bestand repraesentativer Vogelarten (insgesamt)", subtitle = "Prognose ab 2016")+ theme_minimal() + 
    ylab("Vogelbestandsindex") + xlab("")
  gg_all_voegel_ets[[i]] <- gg1
}
save(gg_all_voegel_ets, file = "gg_all_voegel_ets.rda")


 gg_all_voegel_nnetar <- list()
 for (i in 50:1) 
 {
   gg3 <- tsb_all_voegel %>% model(NNETAR(value)) %>% forecast(h = i) %>% autoplot(tsb_all_voegel)
   gg3 <- gg3  + ggtitle("Bestand repraesentativer Vogelarten (insgesamt)", subtitle = "Prognose ab 2016")+ theme_minimal() + 
     ylab("Vogelbestandsindex") + xlab("")
   gg_all_voegel_nnetar[[i]] <- gg3
   save(gg3, file = paste0("gg_all_voegel_nnetar",i,".rda"))
   print(i)
 }
 save(gg_all_voegel_nnetar, file = "gg_all_voegel_nnetar.rda")

######----------


#Agrar
ts_agrar_voegel <- ts(voegel$`Bestand repraesentativer Vogelarten, Agrarland`[1:27], start = 1990, frequency = 1)
tsb_agrar_voegel <- as_tsibble(ts_agrar_voegel)

gg_agrar_voegel_arima <- list()
for (i in 1:50) 
{
  gg <- tsb_agrar_voegel %>% model(ARIMA(value)) %>% forecast(h = i) %>% autoplot(tsb_agrar_voegel)
  gg <- gg  + ggtitle("Bestand repraesentativer Vogelarten (Agrarland)", subtitle = "Prognose ab 2016")+ theme_minimal() + 
    ylab("Vogelbestandsindex") + xlab("")
  gg_agrar_voegel_arima[[i]] <- gg
}
save(gg_agrar_voegel_arima, file = "gg_agrar_voegel_arima.rda")


gg_agrar_voegel_ets <- list()
for (i in 1:50) 
{
  gg1 <- tsb_agrar_voegel %>% model(ETS(value)) %>% forecast(h = i) %>% autoplot(tsb_agrar_voegel)
  gg1 <- gg1  + ggtitle("Bestand repraesentativer Vogelarten (Agrarland)", subtitle = "Prognose ab 2016")+ theme_minimal() + 
    ylab("Vogelbestandsindex") + xlab("")
  gg_agrar_voegel_ets[[i]] <- gg1
}
save(gg_agrar_voegel_ets, file = "gg_agrar_voegel_ets.rda")


# gg_agrar_voegel_nnetar <- list()
# for (i in 1:50) 
# {
#   gg3 <- tsb_agrar_voegel %>% model(NNETAR(value)) %>% forecast(h = i) %>% autoplot(tsb_agrar_voegel)
#   gg3 <- gg3  + ggtitle("Bestand repraesentativer Vogelarten (Agrarland)", subtitle = "Prognose ab 2016")+ theme_minimal() + 
#     ylab("Vogelbestandsindex") + xlab("")
#   gg_agrar_voegel_nnetar[[i]] <- gg3
# }
# save(gg_agrar_voegel_nnetar, file = "gg_agrar_voegel_nnetar.rda")

######----------





##Binnen
ts_binnen_voegel <- ts(voegel$`Bestand repraesentativer Vogelarten, Binnengewaesser`[1:27], start = 1990, frequency = 1)
tsb_binnen_voegel <- as_tsibble(ts_binnen_voegel)

gg_binnen_voegel_arima <- list()
for (i in 1:50) 
{
  gg <- tsb_binnen_voegel %>% model(ARIMA(value)) %>% forecast(h = i) %>% autoplot(tsb_binnen_voegel)
  gg <- gg  + ggtitle("Bestand repraesentativer Vogelarten (Binnengewässer)", subtitle = "Prognose ab 2016")+ theme_minimal() + 
    ylab("Vogelbestandsindex") + xlab("")
  gg_binnen_voegel_arima[[i]] <- gg
}
save(gg_binnen_voegel_arima, file = "gg_binnen_voegel_arima.rda")


gg_binnen_voegel_ets <- list()
for (i in 1:50) 
{
  gg1 <- tsb_binnen_voegel %>% model(ETS(value)) %>% forecast(h = i) %>% autoplot(tsb_binnen_voegel)
  gg1 <- gg1  + ggtitle("Bestand repraesentativer Vogelarten (Binnengewässer)", subtitle = "Prognose ab 2016")+ theme_minimal() + 
    ylab("Vogelbestandsindex") + xlab("")
  gg_binnen_voegel_ets[[i]] <- gg1
}
save(gg_binnen_voegel_ets, file = "gg_binnen_voegel_ets.rda")


# gg_binnen_voegel_nnetar <- list()
# for (i in 1:50) 
# {
#   gg3 <- tsb_binnen_voegel %>% model(NNETAR(value)) %>% forecast(h = i) %>% autoplot(tsb_binnen_voegel)
#   gg3 <- gg3  + ggtitle("Bestand repraesentativer Vogelarten (Binnengewässer)", subtitle = "Prognose ab 2016")+ theme_minimal() + 
#     ylab("Vogelbestandsindex") + xlab("")
#   gg_binnen_voegel_nnetar[[i]] <- gg3
# }
# save(gg_binnen_voegel_nnetar, file = "gg_binnen_voegel_nnetar.rda")

######----------







##meer
ts_meer_voegel <- ts(voegel$`Bestand repraesentativer Vogelarten, Kuesten/Meere`[1:27], start = 1990, frequency = 1)
tsb_meer_voegel <- as_tsibble(ts_meer_voegel)

gg_meer_voegel_arima <- list()
for (i in 1:50) 
{
  gg <- tsb_meer_voegel %>% model(ARIMA(value)) %>% forecast(h = i) %>% autoplot(tsb_meer_voegel)
  gg <- gg  + ggtitle("Bestand repraesentativer Vogelarten (Küsten/Meere)", subtitle = "Prognose ab 2016")+ theme_minimal() + 
    ylab("Vogelbestandsindex") + xlab("")
  gg_meer_voegel_arima[[i]] <- gg
}
save(gg_meer_voegel_arima, file = "gg_meer_voegel_arima.rda")


gg_meer_voegel_ets <- list()
for (i in 1:50) 
{
  gg1 <- tsb_meer_voegel %>% model(ETS(value)) %>% forecast(h = i) %>% autoplot(tsb_meer_voegel)
  gg1 <- gg1  + ggtitle("Bestand repraesentativer Vogelarten (Küsten/Meere)", subtitle = "Prognose ab 2016")+ theme_minimal() + 
    ylab("Vogelbestandsindex") + xlab("")
  gg_meer_voegel_ets[[i]] <- gg1
}
save(gg_meer_voegel_ets, file = "gg_meer_voegel_ets.rda")


# gg_meer_voegel_nnetar <- list()
# for (i in 1:50) 
# {
#   gg3 <- tsb_meer_voegel %>% model(NNETAR(value)) %>% forecast(h = i) %>% autoplot(tsb_meer_voegel)
#   gg3 <- gg3  + ggtitle("Bestand repraesentativer Vogelarten (Küsten/Meere)", subtitle = "Prognose ab 2016")+ theme_minimal() + 
#     ylab("Vogelbestandsindex") + xlab("")
#   gg_meer_voegel_nnetar[[i]] <- gg3
# }
# save(gg_meer_voegel_nnetar, file = "gg_meer_voegel_nnetar.rda")

######----------





##Stadt
ts_stadt_voegel <- ts(voegel$`Bestand repraesentativer Vogelarten, Siedlungen`[1:27], start = 1990, frequency = 1)
tsb_stadt_voegel <- as_tsibble(ts_stadt_voegel)

gg_stadt_voegel_arima <- list()
for (i in 1:50) 
{
  gg <- tsb_stadt_voegel %>% model(ARIMA(value)) %>% forecast(h = i) %>% autoplot(tsb_stadt_voegel)
  gg <- gg  + ggtitle("Bestand repraesentativer Vogelarten (Siedlungen)", subtitle = "Prognose ab 2016")+ theme_minimal() + 
    ylab("Vogelbestandsindex") + xlab("")
  gg_stadt_voegel_arima[[i]] <- gg
}
save(gg_stadt_voegel_arima, file = "gg_stadt_voegel_arima.rda")


gg_stadt_voegel_ets <- list()
for (i in 1:50) 
{
  gg1 <- tsb_stadt_voegel %>% model(ETS(value)) %>% forecast(h = i) %>% autoplot(tsb_stadt_voegel)
  gg1 <- gg1  + ggtitle("Bestand repraesentativer Vogelarten (Siedlungen)", subtitle = "Prognose ab 2016")+ theme_minimal() + 
    ylab("Vogelbestandsindex") + xlab("")
  gg_stadt_voegel_ets[[i]] <- gg1
}
save(gg_stadt_voegel_ets, file = "gg_stadt_voegel_ets.rda")


# gg_stadt_voegel_nnetar <- list()
# for (i in 1:50) 
# {
#   gg3 <- tsb_stadt_voegel %>% model(NNETAR(value)) %>% forecast(h = i) %>% autoplot(tsb_stadt_voegel)
#   gg3 <- gg3  + ggtitle("Bestand repraesentativer Vogelarten (Siedlungen)", subtitle = "Prognose ab 2016")+ theme_minimal() + 
#     ylab("Vogelbestandsindex") + xlab("")
#   gg_stadt_voegel_nnetar[[i]] <- gg3
# }
# save(gg_stadt_voegel_nnetar, file = "gg_stadt_voegel_nnetar.rda")

######----------






##Wald
ts_wald_voegel <- ts(voegel$`Bestand repraesentativer Vogelarten, Waelder`[1:27], start = 1990, frequency = 1)
tsb_wald_voegel <- as_tsibble(ts_wald_voegel)

gg_wald_voegel_arima <- list()
for (i in 1:50) 
{
  gg <- tsb_wald_voegel %>% model(ARIMA(value)) %>% forecast(h = i) %>% autoplot(tsb_wald_voegel)
  gg <- gg  + ggtitle("Bestand repraesentativer Vogelarten (Wälder)", subtitle = "Prognose ab 2016")+ theme_minimal() + 
    ylab("Vogelbestandsindex") + xlab("")
  gg_wald_voegel_arima[[i]] <- gg
}
save(gg_wald_voegel_arima, file = "gg_wald_voegel_arima.rda")


gg_wald_voegel_ets <- list()
for (i in 1:50) 
{
  gg1 <- tsb_wald_voegel %>% model(ETS(value)) %>% forecast(h = i) %>% autoplot(tsb_wald_voegel)
  gg1 <- gg1  + ggtitle("Bestand repraesentativer Vogelarten (Wälder)", subtitle = "Prognose ab 2016")+ theme_minimal() + 
    ylab("Vogelbestandsindex") + xlab("")
  gg_wald_voegel_ets[[i]] <- gg1
}
save(gg_wald_voegel_ets, file = "gg_wald_voegel_ets.rda")


# gg_wald_voegel_nnetar <- list()
# for (i in 1:50) 
# {
#   gg3 <- tsb_wald_voegel %>% model(NNETAR(value)) %>% forecast(h = i) %>% autoplot(tsb_wald_voegel)
#   gg3 <- gg3  + ggtitle("Bestand repraesentativer Vogelarten (Wälder)", subtitle = "Prognose ab 2016")+ theme_minimal() + 
#     ylab("Vogelbestandsindex") + xlab("")
#   gg_wald_voegel_nnetar[[i]] <- gg3
# }
# save(gg_wald_voegel_nnetar, file = "gg_wald_voegel_nnetar.rda")

######----------



