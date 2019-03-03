library(dplyr)
library(readr)
library(broom)
library(ggplot2); theme_set(theme_bw())

lizards <- (read_csv("data/lizards.csv")
    %>% mutate(time=factor(time,levels=c("early","midday","late")))
    %>% mutate_if(is.character,factor)
)


m1 <- lm(grahami~light*time, data=lizards)
aa <- augment(m1)

ggplot(aa,aes(.fitted,.resid, colour=interaction(light,time)))+
    geom_boxplot(aes(group=.fitted))+
    geom_point(alpha=0.5,position=position_jitter(width=0.5))+
    scale_colour_brewer(palette="Dark2")+
    geom_smooth(aes(group=1),se=FALSE)

ggplot(aa,aes(.fitted,sqrt(abs(.std.resid)), colour=interaction(light,time)))+
    geom_boxplot(aes(group=.fitted))+
    geom_point(alpha=0.5,position=position_jitter(width=0.5))+
    scale_colour_brewer(palette="Dark2")+
    geom_smooth(aes(group=1),se=FALSE)

ggplot(aa,aes(.hat,.std.resid, colour=interaction(light,time)))+
    geom_point(alpha=0.5,position=position_jitter(width=0.5))+
    scale_colour_brewer(palette="Dark2")




