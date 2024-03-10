# Assuming 'mat' is your 18x18 matrix
library(tidyverse)
library(corrplot)
setwd('F:/2DCM/PEB/PBD')
EC<- read.csv('F:/2DCM/PEB/PBD/A_manic_Eq.csv',header = FALSE)
ECmatrix<-as.matrix(EC)
res1<-read.csv('F:/2DCM/PEB/PBD/A_manic_Pp.csv',header = FALSE)
res1<-as.matrix(res1)
#diag(ECmatrix) <- 0
# 只计算Pp>95%的数值
ECmatrix[(res1 == 0)] <- 0
# Define the ranges
ranges <- list(c(1,4), c(5,8), c(9,11), c(12,18))

# Initialize an empty 4x4 matrix to store the results
result <- matrix(nrow=4, ncol=4)


# Calculate the mean for each specific point in the matrix
for(i in 1:length(ranges)){
  for(j in 1:length(ranges)){
    result[i,j] <- mean(ECmatrix[ranges[[i]][1]:ranges[[i]][2], ranges[[j]][1]:ranges[[j]][2]])
  }
}

# Print the resulting 4x4 matrix

colnames(result)<- c("DMN","CEN","SN","LN")
rownames(result)<- c("DMN","CEN","SN","LN")

col3<-grDevices::colorRampPalette(c("#0033FF","white", "#FF3F3F"))
col3
tiff(filename = "A_manic_averaged.tif", width = 960, height = 960,units = "px", pointsize = 12,
     compression = c("none", "rle", "lzw", "jpeg", "zip", "lzw+p", "zip+p"),
     res = 130)
corrplot::corrplot.mixed(corr=result,
                         lower="color",
                         upper = "color",
                         diag = "u",
                         upper.col = col3(101),
                         lower.col = col3(101),
                         number.cex=1.5,
                         sig.level=0,
                         bg = "white",
                         is.corr = FALSE,
                         outline = FALSE,
                         mar = c(0,0,3,0),
                         addCoef.col = 'black', 
                         number.digits = 5,
                         addCoefasPercent = FALSE, 
                         order = c("original"),
                         rect.col = "black", 
                         rect.lwd = 1, 
                         tl.cex = 1.4,
                         tl.col = "black", 
                         tl.offset = 0.7, 
                         tl.srt = 360,
                         cl.cex = 1.3, 
                         cl.ratio = .2,
                         cl.length = 4,
                         tl.pos="lt",
                         cl.offset = 0.1,
                         col.lim = c(-0.1,0.05))

title(main="Averaged Effective Connectivity",cex.main=2)
dev.off()



