# Googlesheets exercise
#https://cran.r-project.org/web/packages/googlesheets/vignettes/basic-usage.html
library(googlesheets)
library(dplyr)
my_sheets <- gs_ls()
glimpse(my_sheets)
gs_gap() %>% 
  gs_copy(to = "Gapminder")
gs_ls('Gapminder')
gap <- gs_title("Gapminder")
gap
(GAP_KEY <- gs_gap_key())
third_party_gap <- GAP_KEY %>% 
  gs_key()
(GAP_URL <- gs_gap_url())
third_party_gap <- GAP_KEY %>% 
  gs_key()
extract_key_from_url(GAP_URL)
gap <- gap %>% gs_gs()
#======================
gap %>% gs_browse()
gap %>% gs_browse(ws = 1)
gap %>% gs_browse(ws = "Europe")
#==============================
oceania <- gap %>% 
  gs_read(ws = "Oceania")
oceania
str(oceania)
glimpse(oceania)
