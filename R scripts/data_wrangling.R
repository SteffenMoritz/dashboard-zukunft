load( file = "data/destatis_international_energie.rda")
load(file = "data/Laender_Mapping.rda")
load(file = "data/regulatory_policies_eummr2020.rda")


load(file = "data/worldbank_climate.rda")
load( file = "data/destatis_deutschland_umwelt_beschaeftigte.rda")
load(file = "data/destatis_deutschland_umwelt_umsatz.rda")
load( file = "data/destatis_international_forst_fischer.rda")
load(file = "data/destatis_international_wirtschaft.rda")
load(file = "data/worldbank_wdi.rda")


library("tidyverse")

energie <- destatis_international_energie 

energie <- energie  %>%  filter(LAND == "Deutschland")  %>%
  filter(KENNZAHL == "Kohlendioxidemissionen je Einwohner") 

energie <- as.data.frame(energie[1,4:32])
co2 <- energie %>% pivot_longer( cols = everything(), names_to = "Jahr", values_to = "Kohlendioxidemissionen je Einwohner")



energie <- destatis_international_energie 

energie <- energie  %>%  filter(LAND == "Deutschland")  %>%
  filter(KENNZAHL == "Primärenergieverbrauch (Rohöleinheiten je Einwoh.)") 

energie <- as.data.frame(energie[1,4:32])
prim <- energie %>% pivot_longer( cols = everything(), names_to = "Jahr", values_to = "Primärenergieverbrauch (Rohöleinheiten je Einwoh.)")

prim[prim ==0] <- NA

ges <- data.frame(prim,co2)

voegel4$'Primärenergieverbrauch..Rohöleinheiten.je.Einwoh..' <- NA
voegel4$'Kohlendioxidemissionen je Einwohner' <- NA

voegel4$`Kohlendioxidemissionen je Einwohner`[1:29] <- ges$Kohlendioxidemissionen.je.Einwohner
voegel4$Primärenergieverbrauch..Rohöleinheiten.je.Einwoh..[1:29] <- ges$Primärenergieverbrauch..Rohöleinheiten.je.Einwoh..

length(voegel4$`Kohlendioxidemissionen je Einwohner`)
length(ges$Primärenergieverbrauch..Rohöleinheiten.je.Einwoh..)
voe


save(energie, file = "energie.rda")

ts_energie <- ts(energie$co2, start = 1990, frequency = 1)
tsb_energie <- as_tsibble(ts_energie)
save(tsb_energie, file = "tsb_energie.rda")


save(voegel4, file = "voegel4.rda")





