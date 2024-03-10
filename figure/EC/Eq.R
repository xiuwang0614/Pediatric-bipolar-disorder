library(tidyverse)
library(corrplot)
setwd('E:/2DCM/PEB/PBD')
EC<- read.csv('E:/2DCM/PEB/PBD/A_manic_Eq.csv',header = FALSE)
ECmatrix<-as.matrix(EC)
#ECmatrix[(ECmatrix < 0.05) & (ECmatrix>0)] <- 0
#ECmatrix[(ECmatrix > -0.05) & (ECmatrix< 0)] <- 0
ECmatrix<-round(ECmatrix,digit = 3)
colnames(ECmatrix)<- c("sgACC","PCC","Angular_R","Angular_L",
                       "MFG_R","IPR","IPL","MFG_L",
                       "dACC_R","dACC_L","AI_L","AI_R",
                       "Hippo_R","Hippo_L","Amyg_R",
                       "Amyg_L","Caudate_L","Caudate_R")
rownames(ECmatrix)<- c("sgACC","PCC","Angular_R","Angular_L",
                       "MFG_R","IPR","IPL","MFG_L",
                       "dACC_R","dACC_L","AI_L","AI_R",
                       "Hippo_R","Hippo_L","Amyg_R",
                       "Amyg_L","Caudate_L","Caudate_R")
res1<-read.csv('E:/2DCM/PEB/PBD/A_manic_Pp.csv',header = FALSE)
res1<-as.matrix(res1)
res1[(ECmatrix == 0)] <-0
res1[(res1 <0.95 )]<-NA
res1[(res1 >= 0.95)] <- 0
res1[is.na(res1)] <- 1
#res1[is.na(ECmatrix)]<-NA
colnames(res1)<- c("sgACC","PCC","Angular_R","Angular_L",
                   "MFG_R","IPR","IPL","MFG_L",
                   "dACC_R","dACC_L","AI_L","AI_R",
                   "Hippo_R","Hippo_L","Amyg_R",
                   "Amyg_L","Caudate_L","Caudate_R")
rownames(res1)<- c("sgACC","PCC","Angular_R","Angular_L",
                   "MFG_R","IPR","IPL","MFG_L",
                   "dACC_R","dACC_L","AI_L","AI_R",
                   "Hippo_R","Hippo_L","Amyg_R",
                   "Amyg_L","Caudate_L","Caudate_R")
col3<-grDevices::colorRampPalette(c("#2082DD", "white",'#FF3F3F'))
#ECmatrix<-pmin(pmax(ECmatrix, -1), 1)
#highlighted_lines <- c(6.5, 10.5, 14.5)  # Rows to highlight
#highlighted_columns <- c(4.5, 8.5, 12.5)  # Columns to highlight

folder_path <- "E:/2DCM/figure"
# Update the filename with the full path
tiff_file <- file.path(folder_path, "A_manic_Eq.tif")

tiff(filename = tiff_file, width = 960, height = 960,units = "px", pointsize = 12,
     compression = c("none", "rle", "lzw", "jpeg", "zip", "lzw+p", "zip+p"),
     res = 130)
#diag(ECmatrix) <- 0
p1<- corrplot::corrplot.mixed(corr=ECmatrix,
                         lower="color",
                         upper = "color",
                         diag = "u",
                         upper.col = col3(101),
                         lower.col = col3(101),
                         number.cex=0.7,
                         p.mat=res1,
                         sig.level=0.95,
                         insig = 'blank',
                         bg = "white",
                         is.corr = FALSE,
                         outline = FALSE,
                         mar = c(0,0,3,0),
                         addCoef.col = 'black', 
                         addCoefasPercent = FALSE, 
                         order = c("original"),
                         rect.col = "black", 
                         rect.lwd = 1, 
                         tl.cex = 0.7,
                         tl.col = "black", 
                         tl.offset = 0.5, 
                         tl.srt = 45,
                         cl.cex = 1, 
                         cl.ratio = .2,
                         cl.length = 4,
                         tl.pos="lt",
                         cl.offset = 0.1,
                         pch = 0,
                         pch.cex=4.1,
                         pch.col = "red",
                         col.lim = c(-0.7,0.7))

# Add additional rectangles to emphasize specific rows
#for (line in highlighted_lines) {
#  rect(-2,line-0.05, ncol(ECmatrix)+0.5, line + 0.05, col = "black", border = NA)
#}

#for (col in highlighted_columns) {
#  rect(col - 0.05, 6.5, col + 0.05, nrow(ECmatrix) + 0.5, col = "black", border = NA)
#}
p1
title(main="Effective Connectivity Matrix",cex.main=1.2)
dev.off()

