library(tidyr)
library(sf)
library(geobr)
library(dplyr)
library(leaflet)
library(RColorBrewer)
library(stringi)

exames<-read.csv("exames_e_pacientes.csv", encoding = "UTF-8")
pacientes<-read.csv("amostra_pacientes.csv", encoding = "UTF-8")
tabela_exames_por_paciente<-read.csv("exames_por_paciente.csv", encoding = "UTF-8")

UF<-pacientes%>%
  group_by(CD_UF)%>%
  summarise(total = n())%>%
  arrange(desc(total))
names(UF)[1] <- "SIGLA_UF"
map1 <- st_read("BRDF/BR_UF_2020.shp", quiet = TRUE)
map1 <- st_transform(map1, 4326)
map1<-map1%>%left_join(UF, by= "SIGLA_UF")

pal <- colorNumeric("YlOrRd", domain = map1$total)


MUNICIPIO<-pacientes%>%
  group_by(CD_MUNICIPIO)%>%
  summarise(total = n())%>%
  arrange(desc(total))
names(MUNICIPIO)[1] <- "NM_MUN"
map2<- st_read("SPBR/SP_Municipios_2020.shp", quiet = TRUE)
map2 <- st_transform(map2, 4326)
map2$NM_MUN<-stri_trans_general(toupper(map2$NM_MUN),"Latin-ASCII")
map2<-map2%>%left_join(MUNICIPIO, by= "NM_MUN")

pal2 <- colorNumeric("YlOrRd", domain = map2$total)

