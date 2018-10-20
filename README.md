# Data-Products
Submissions for the Data Products Coursera module


This repo contains the project files for a submission to the Data Products Coursera Module.

The applet can be found here - https://gormonjee.shinyapps.io/Fun_with_weight/

The pitchdeck can be found here - http://rpubs.com/maximegalon5/DP_W_4

The following code was used to transform the original brfss dataset to create a subset with the selected variables.

filePath <- "LLCP2017.XPT"
D <- read.xport(filePath)

selected_Data <- D %>% select(HTM4, WTKG3, X_PAINDX1, SEX) %>% 
  na.omit()
rm(D)

set.seed(5678)
size = nrow(selected_Data)
mini_data_set <- selected_Data[sample(1:size, 10000),]
rm(selected_Data)


mini_data_set <- mini_data_set %>% filter(X_PAINDX1 <= 2, SEX <= 2) %>% 
  mutate(Aer_Ex = as.factor(X_PAINDX1), Gender = as.factor(SEX)) %>% 
  mutate(Aer_Ex = ifelse(X_PAINDX1 == 1, "Yes", "No"),
         Gender = ifelse(Gender == 1, "Male", "Female"),
         Height = HTM4,
         Weight = WTKG3) %>%
  select(Height, Weight, Aer_Ex, Gender)

saveRDS(mini_data_set, file = "mini_brfss.rds")

