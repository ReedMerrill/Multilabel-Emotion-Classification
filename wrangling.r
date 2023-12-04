library(tidyverse)

dt <- read_csv("data/train.csv")

dt <- dt |> mutate(
    label_count = admiration + amusement + gratitude + love + pride + relief + remorse #nolint
)

dt_onehot <- dt |> filter(label_count <= 1)

table(dt$label_count)

# get the unique number of label combinations
dt$label_strings <- paste(
    dt$admiration, dt$amusement, dt$gratitude, dt$love, dt$pride, dt$relief, dt$remorse, sep = "") #nolint

print(paste("Number of unique label combinations:", length(unique(dt$label_strings))))
print("Unique label combinations:")
print(unique(dt$label_strings))

# solve for the proportional sample weights
weights <- dt |>
    group_by(label_strings) |>
    summarise(
        n = n(),
        weight = (1 / n) * 10
)
weights
