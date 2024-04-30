# load flucalc table created by CLAN from IISRP data, run taxometrics on it

###### paths and params
PATH_BASE <- "C:\\docs\\code\\taxo"
PATH_SOURCE <- paste0(PATH_BASE, "\\sourcedata\\IISRP")
PATH_DER <- paste0(PATH_BASE, "\\derivatives\\IISRP")
PATH_VISITs_TOP <- paste0(PATH_DER, "\\sourcedata_by_visit")

visitnum <- "1"

visitdir <- paste0(PATH_VISITs_TOP, "\\visit-", visitnum)

flucalc_file <- paste0(visitdir, "\\flucalc.csv")  

setwd(visitdir)

# Load the readxl package
#### install.packages("readxl") # might need to comment this in if readxl package is not installed
library(readxl)
library(RTaxometrics)

subdata<- read.csv(flucalc_file, check.names=FALSE)
names(subdata) <- gsub("%", "pct", names(subdata))
names(subdata) <- gsub("#", "num", names(subdata))

# if subject has 4 or more weighted SLDs in this visit, classify as PWS
subdata$group_for_taxo <- ifelse(subdata$Weighted_SLD < 4, 1, 2)

data_for_taxo <- subdata[c("num_SLD","pct_Block","group_for_taxo")]
data_for_taxo <- subdata[c("num_SLD","pct_Block","Weighted_SLD","group_for_taxo")]
data_for_taxo <- subdata[c("num_Block","num_Prolongation","group_for_taxo")]
RunTaxometrics(data_for_taxo)