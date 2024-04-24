library(tidyverse)
library(corrplot)
library(brms)
setwd('E:/2DCM/PEB/all')
EC<- read.csv('E:/2DCM/PEB/PBD/A_manic_Eq.csv',header = FALSE)
ECmatrix<-as.matrix(EC)

res1<-read.csv('E:/2DCM/PEB/PBD/A_manic_Pp.csv',header = FALSE)
res1<-as.matrix(res1)

ECmatrix[(res1 < 0.95)] <- 0
EE <- ECmatrix
EE[(res1==1 & (ECmatrix < 0.001 & ECmatrix >0))]<-ECmatrix[(res1==1 & (ECmatrix < 0.001 & ECmatrix >0))]*10
EE[(res1==1 & (ECmatrix > -0.01 & ECmatrix <0))]<-ECmatrix[(res1==1 & (ECmatrix > -0.01 & ECmatrix <0))]*10
DV<- matrix(c(EE),nrow = 324,ncol = 1)
value<- matrix(1, nrow = 18,ncol = 18)

value[1:4,1:4]<-"F01"#"DMNDMN"
value[5:8,1:4]<-"F02"#"DMNCEN"
value[9:12,1:4]<-"F03"#"DMNSN"
value[13:18,1:4]<-"F04"#"DMNLN"

value[1:4,5:8]<-"F05"#"CENDMN"
value[5:8,5:8]<-"F06"#"CENCEN"
value[9:12,5:8]<-"F07"#"CENSN"
value[13:18,5:8]<-"F08"#"CENLN"

value[1:4,9:12]<-"F09"#"SNDMN"
value[5:8,9:12]<-"F10"#"SNCEN"
value[9:12,9:12]<-"F11"#"SNSN"
value[13:18,9:12]<-"F12"#"SNLN"

value[1:4,13:18]<-"F13"#"LNDMN"
value[5:8,13:18]<-"F14"#"LNCEN"
value[9:12,13:18]<-"F15"#"LNSN"
value[13:18,13:18]<-"F16"#"LNLN"

F<- matrix(c(value),nrow = 324,ncol = 1)
F<- as.factor(F)
print(class(F))
#datam<- cbind(as.factor(F),DV)
datam<-data.frame(F=F,DV=DV)
str(datam)


fit_mCM <- brm(DV ~ -1 + F,
               data = datam,
               family = gaussian(),
               prior = c(
                 prior(normal(0, 2), class = sigma),
                 prior(normal(0, 2), class = b)
               )
)
b<-fixef(fit_mCM)
result<-b[1:16,1]
result<-as.matrix(result)
result<- matrix(c(result),nrow = 4,ncol = 4)


colnames(result)<- c("DMN","CEN","SN","LN")
rownames(result)<- c("DMN","CEN","SN","LN")

Est<-b[1:16,2]
Est<-as.matrix(Est)
Est<- matrix(c(Est),nrow = 4,ncol = 4)

colnames(Est)<- c("DMN","CEN","SN","LN")
rownames(Est)<- c("DMN","CEN","SN","LN")

result[(Est > 0.05)] <- 0
# save --------------------------------------------------------------------

# Specify the full path to the folder where you want to save the result data
output_folder <- "E:/2DCM/BayesianContrast"

# Update the output file paths
ec_output_file <- file.path(output_folder, "M1111.csv")
res_output_file <- file.path(output_folder, "M11111error.csv")

# Write the matrices to CSV files
write.csv(result, file = ec_output_file, row.names = TRUE)
write.csv(Est, file = res_output_file, row.names = TRUE)