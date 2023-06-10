library(FactoMineR)
library(factoextra)
library(readr)
library(reshape2)
library(dplyr)

data <- read_csv("Downloads/data1.csv")

counts <- data %>%
  group_by(`Country`, topic_names) %>%
  summarise(count = n())

df <- as.data.frame(counts)
tableau_croise <- dcast(df, topic_names ~ Country , value.var = "count")

# Afficher le tableau croisé dynamique
print(tableau_croise)

nouveau_df <- data.frame(tableau_croise)

colnames(tableau_croise)[1] <- ""

# Afficher le dataframe
print(tableau_croise)

ds <- replace(tableau_croise, is.na(tableau_croise), 0)
rownames(ds) <- ds[,1]
ds = ds[, -1]

res.ca <- CA(ds, graph = FALSE)
fviz_ca_biplot(res.ca, repel = TRUE)



