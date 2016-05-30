# Written in 2016 by Theodore Jones theo@theojones.name
# this script measures the correlation between HDI and oil 
# after adjusting for level of political freedom, and adjusting
# for spatial autocorrelation. It goes with my blog post at
#https://theojones.name/2016/05/will-automation-cause-a-resource-curse/
# Output is in the output.txt file 
#
# To the extent possible under law, the author(s) have dedicated all copyright and related and neighboring rights to this software to the public domain worldwide. This software is distributed without any warranty.You should have received a copy of the CC0 Public Domain Dedication along with this script. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

#Load the data, most of the data is from wikipedia pages 
# data was changed into .csv form and cleaned up in a 
#way that makes it more analysable 
#2015 Democracy index 
# from https://en.wikipedia.org/wiki/Democracy_Index
dem <- read.csv("justscore.csv",strip.white=TRUE)
#Percapita gdp
# from https://en.wikipedia.org/wiki/List_of_countries_by_GDP_(PPP)_per_capita
#archived at http://www.webcitation.org/6hpb6rZim
percap <- read.csv("percap.csv",strip.white=TRUE)
#oil production per year
# from https://en.wikipedia.org/wiki/List_of_countries_by_oil_production
#archived at http://www.webcitation.org/6hpaz0Pla
oilprod <- read.csv("oilprod.csv",strip.white=TRUE)
#latitude and longitude used to adjust for spatial autocorrelation
# from https://developers.google.com/public-data/docs/canonical/countries_csv
# archived at http://www.webcitation.org/6hpat3xbn
latlon <- read.csv("latlon.csv",strip.white=TRUE)
# hdi data 
# from https://en.wikipedia.org/wiki/List_of_countries_by_Human_Development_Index
#archived at http://www.webcitation.org/6hpah5XpE
hdi <- read.csv("hdi.csv",strip.white=TRUE)

#Merge the datasets, based of country name
democracyandincome <- merge(dem,percap,1,1)
demincandoil <- merge(democracyandincome,oilprod,1,1)
andhdi <- merge(demincandoil,hdi,1,1)
merged <- merge(andhdi,latlon,1,1)


# do a multiple regression using gdp 
#money = gdp per capita, score = democracy index combined score
# longitude is longitude, lattitude is lattitude, included to adjust for autocorrelation
fitgdp <- lm(money~prod + score + longitude + latitude, data=merged)
summary(fitgdp)
# multiple regression same as above but using hdi
fithdi <- lm(HDI~prod + score + longitude + latitude, data=merged)
summary(fithdi)

