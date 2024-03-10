#配色，随机选择10个颜色，并找到RGB0-1版
color<-read.csv("D:/Desktop/article1/ICA/color.csv",header = FALSE)
#RGB转成16进制的RGB
color16<-rgb(color,maxColorValue = 1)
col<-grDevices::colorRampPalette(color16)
#自动生成10种颜色的过度色，101种颜色
Coo <-col(101)
# 16进制转换成RGB255编号
rgb_c<-col2rgb(Coo)
# RGB255转成RGB0-1
rgb1<-rgb_c/255

