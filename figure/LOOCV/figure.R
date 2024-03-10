library(tidyverse)
library(gghalves)
library(ggplot2)
library(dplyr)
library(cowplot)
library(ggpubr)
library(gridExtra)

data = read.csv("E:/2DCM/LOO/FIGURE_G.csv")
data %>%
  mutate(Group =factor(Group,levels = c("HC","PBD")))->df
ordercolors<-c("coral1","lightslateblue")
group<-ggplot(data = df,
       aes(x=Group,y=qE, fill=Group))+
  geom_half_violin(side="r",color = NA,alpha=0.35)+
  geom_half_boxplot(side="r",errorbar.draw = FALSE,width=0.2,linewidth=0.5)+
  geom_half_point_panel(side="l",shape=21,size=3,color="white")+
  scale_fill_manual(values=ordercolors)+
  scale_y_continuous(limits = c(-1.5,1),expand = c(0,0))+
  scale_x_discrete(labels = c('HC','PBD'))+
  labs(y="EC from left Amygdala to right dACC",x="Group")+
  theme_classic()+
  theme(legend.position = "right",
        axis.title = element_text(size=11,color = "black"),
        axis.text = element_text(size=11,color = "black"))
group

dep<- read.csv("E:/2DCM/LOO/FIGURE_D.csv")
d<- ggscatter(dep,x = "depression",y="qE",
              size=1.5,color = "#282a62",
              add="reg.line",
              add.params = list(color="#276c9e",fill="#a3c9d5",size=1.5),
              conf.int = TRUE)+
  theme_classic()+
  theme(legend.position = "none",
        axis.title = element_text(size=11,color = "black"),
        axis.text = element_text(size=11,color = "black"))+
  scale_y_continuous(limits = c(-1.5,1.5),expand = c(0,0))+
  scale_x_continuous(limits = c(-1.5,2),expand = c(0,0))+
  labs(x ='Depression symptom severity',y='EC from left hippocampus to right MFG')
d
man<-read.csv("E:/2DCM/LOO/FIGURE_M.csv")

m<- ggscatter(man,x = "mania",y="qE",
              size=1.5,color = "#282a62",
              add="reg.line",
              add.params = list(color="#276c9e",fill="#a3c9d5",size=1.5),
              conf.int = TRUE)+
  theme_classic()+
 # stat_cor(method = "pearson")+
  theme(legend.position = "none",
        axis.title = element_text(size=11,color = "black"),
        axis.text = element_text(size=11,color = "black"))+
  scale_y_continuous(limits = c(-0.5,0.5),expand = c(0,0))+
  scale_x_continuous(limits = c(-1.5,2.5),expand = c(0,0))+
  labs(x ='Mania symptom severity',y='EC from left Caudate to right Augular')

m

figure<- ggdraw()+
  draw_plot(group,0,0.33,0.33,0.5)+
  draw_plot(d,0.33,0.33,0.33,0.5)+
  draw_plot(m,0.66,0.33,0.33,0.5)+
  draw_plot_label(c("(a)","(b)","(c)"),c(0,0.33,0.66),c(0.95,0.95,0.95),size = 12,colour = "black")
figure



#ggarrange(group,d,m,ncol=3,nrow = 1)






