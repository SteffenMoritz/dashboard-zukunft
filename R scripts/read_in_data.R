library(readr)
# read in worldbank climate
worldbank_climate <- read_delim("data/worldbank_climate.csv", ";", escape_double = FALSE, locale = locale(
  decimal_mark = ",",
  grouping_mark = ""
), trim_ws = TRUE)
save(worldbank_climate, file = "data/worldbank_climate.rda")


library(readr)
destatis_deutschland_umwelt_beschaeftigte <- read_delim("data/destatis_deutschland_umwelt_beschaeftigte.csv",
  ";",
  escape_double = FALSE, locale = locale(
    decimal_mark = ",",
    grouping_mark = ""
  ), trim_ws = TRUE
)
save(destatis_deutschland_umwelt_beschaeftigte, file = "data/destatis_deutschland_umwelt_beschaeftigte.rda")



library(readr)
destatis_deutschland_umwelt_umsatz <- read_delim("data/destatis_deutschland_umwelt_umsatz.csv",
  ";",
  escape_double = FALSE, locale = locale(
    decimal_mark = ",",
    grouping_mark = ""
  ), trim_ws = TRUE
)
save(destatis_deutschland_umwelt_umsatz, file = "data/destatis_deutschland_umwelt_umsatz.rda")



library(readr)
destatis_international_energie <- read_delim("data/destatis_international_energie.csv",
  ";",
  escape_double = FALSE, locale = locale(
    decimal_mark = ",",
    grouping_mark = ""
  ), trim_ws = TRUE
)
save(destatis_international_energie, file = "data/destatis_international_energie.rda")


library(readr)
destatis_international_forst_fischer <- read_delim("data/destatis_international_forst_fischer.csv",
  ";",
  escape_double = FALSE, locale = locale(
    decimal_mark = ",",
    grouping_mark = ""
  ), trim_ws = TRUE
)
save(destatis_international_forst_fischer, file = "data/destatis_international_forst_fischer.rda")



library(readr)
destatis_international_wirtschaft <- read_delim("data/destatis_international_wirtschaft.csv",
  ";",
  escape_double = FALSE, locale = locale(
    decimal_mark = ",",
    grouping_mark = ""
  ), trim_ws = TRUE
)
save(destatis_international_wirtschaft, file = "data/destatis_international_wirtschaft.rda")


library(readr)
regulatory_policies_eummr2020 <- read_delim("data/regulatory_policies_eummr2020.csv",
  ";",
  escape_double = FALSE, trim_ws = TRUE
)
save(regulatory_policies_eummr2020, file = "data/regulatory_policies_eummr2020.rda")


library(readr)
worldbank_wdi <- read_delim("data/worldbank_wdi.csv",
  ";",
  escape_double = FALSE, locale = locale(
    decimal_mark = ",",
    grouping_mark = ""
  ), trim_ws = TRUE
)
save(worldbank_wdi, file = "data/worldbank_wdi.rda")


library(readxl)
Laender_Mapping <- read_excel("data/Laender_Mapping.xlsx")
save(Laender_Mapping, file = "data/Laender_Mapping.rda")



library(readxl)
Datensatz_vs1 <- read_excel("~/Dropbox/dashboard-zukunft/Datensatz_vs1.xlsx", 
                                  skip = 7)
voegel <- Datensatz_vs1

save(voegel, file = "voegel.rda")
