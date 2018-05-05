##-------------------------------------------------------------------------------------##
##    Anamorfismo para SER                                                             ##
##    http://www.tesouro.fazenda.gov.br/pt_PT/indicadores-fiscais-e-de-endividamento   ##
##                                                                                     ##
##    Steven Dutt-Ross                                                                 ##
##    UNIRIO                                                                           ##
##-------------------------------------------------------------------------------------##

# store the current directory
initial.dir<-getwd()
# change to the new directory
setwd("C:/Users/Hp/Documents/DIRETORIO DE TRABALHO DO R/")


library(readr)
divida <- read_delim("indicadores-e-operacoes-de-credito-2018-01/estados-DCL-e-RCL.csv", 
                     ";", escape_double = FALSE, locale = locale(encoding = "latin1"), 
                     trim_ws = TRUE, skip = 3)
head(divida)
names(divida)
nomes<-c("UF","Tipo","Ente","Cod_IBGE","DCL","RCL","Perc_DCL_RCL","Periodo","Limite_DCL_RCL")
colnames(divida)<-nomes
names(divida)
divida <- within(divida, {  Perc_DCL_RCL <- Perc_DCL_RCL/100})
summary(divida$Perc_DCL_RCL)

# library(brmap)
# brmap_estado
# base <- merge(brmap_estado,divida,by.x="cod_estado",by.y="Cod_IBGE")
# dim(base)
# str(base)

library(brazilmaps)
Mapa_brasil <- get_brmap(geo = "State",
                         geo.filter = NULL,
                         class = "SpatialPolygonsDataFrame")
divida$State<-divida$Cod_IBGE
invisible(Mapa_basededados <- merge(Mapa_brasil, divida, by.x = "State", by.y = "Cod_IBGE", all = TRUE))

library(tmap)
tm_shape(Mapa_basededados) + tm_fill("Perc_DCL_RCL", style="jenks") +
  tm_borders() + tm_layout(frame=F)

library(cartogram)
library(maptools)
dividapublica <- cartogram(Mapa_basededados, "Perc_DCL_RCL", itermax=30)

tm1<-tm_shape(Mapa_basededados) + tm_borders() + 
  tm_shape(dividapublica) + tm_fill("Perc_DCL_RCL", style="jenks") +
  tm_borders() + tm_layout(frame=F)
tm2<-tm_shape(dividapublica) + tm_fill("Perc_DCL_RCL", style="jenks") +
  tm_borders() + tm_layout(frame=F)
tmap_arrange(tm1, tm2, asp = NA)


tm1<-tm_shape(Mapa_basededados) + tm_borders() + 
  tm_shape(dividapublica) + tm_fill("Perc_DCL_RCL", style="jenks") +
  tm_borders() + tm_layout(frame=F)+
  tm_text("UF", size="Perc_DCL_RCL", scale=1, root=4, size.lowerbound = .6, 
          bg.color="white", bg.alpha = .75, 
          auto.placement = 1, legend.size.show = FALSE) 
tmap_mode("view")
tm1
save_tmap(tm1, "index.html")
# Referências:
#   https://leobastos.wordpress.com/2016/10/14/visualizando-informacao-espacial-de-uma-forma-diferente/
# Dougenik, Chrisman, Niemeyer (1985): An Algorithm To Construct Continuous Area Cartograms. In: Professional Geographer, 37(1), 75-81.
# Gastner, Michael T. and Newman, M. E. J. (2004) Diffusion-based method for producing density equalizing maps Proc. Natl. Acad. Sci. USA 101, 7499-7504.
# Olson, J. M. (1976), Noncontiguous Area Cartograms. The Professional Geographer, 28: 371–380. doi:10.1111/j.0033-0124.1976.00371.x
# 






# load the necessary libraries
library(nlme)
# set the output file
sink("adolrisk03.out")
# load the dataset
...
# close the output file
sink()
# unload the libraries
detach("package:nlme")
# change back to the original directory
setwd(initial.dir)

#DCL/RCL
#Os limites percentuais da relação DCL/RCL dos Estados, do Distrito Federal e dos Municípios estão previstos na Resolução do Senado Federal nº 40, de 20/12/2001, e são os seguintes:
# a) no caso dos Estados e do Distrito Federal:  < 2,0
# O MDF está disponível em tesouro.gov.br/mdf.

