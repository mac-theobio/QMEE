lizards <- read.csv("../data/lizards.csv") |>
     mutate(across(time, ~ fct_inorder(factor(.)) ))
lm_int <- lm(grahami ~ light*time, data = lizards)
 ## ~ 1 + light + time + light:time
lm_add <- update(lm_int , . ~ light + time)
lm_light <- update(lm_add, . ~ . - light)
car::Anova(lm_int)
