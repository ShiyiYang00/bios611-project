# Load libraries
library(umap)
library(tidyverse)
set.seed(42)

# prepare data
df <-  readRDS("derived_data/employ_data_sub.rds")
data <- df %>% select(-Resigned)
data_dummy <- model.matrix(~ . - 1, data = data)

labels <- ifelse(df$Resigned == "Resigned", 1, 0)

# Perform UMAP
umap_result <- umap(data_dummy)

# Extract UMAP coordinates
umap_coords <- as.data.frame(umap_result$layout)
colnames(umap_coords) <- c("UMAP1", "UMAP2")

# Add ground truth labels to the UMAP results
umap_coords$Label <- labels

# Plot the UMAP results with ggplot2
ggplot(umap_coords,aes(x = UMAP1, y = UMAP2, color = as.factor(Label))) +
  facet_wrap(~Label)+
  geom_point(size = 3, alpha = 0.7) +
  scale_color_manual(values = c("red", "blue"), name = "Resigned") +
  labs(title = "UMAP", x = "UMAP Dimension 1", y = "UMAP Dimension 2") +
  theme_minimal()+
  theme(
    panel.spacing = unit(1, "cm")  # Adjust the space between panels
  )

ggsave("figs/umap.png",dpi=500)