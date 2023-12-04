library(tidyverse)

dt <- read_csv("data/train.csv")

# get the unique number of label combinations
dt$label_strings <- paste(
    dt$admiration, dt$amusement, dt$gratitude, dt$love, dt$pride, dt$relief, dt$remorse, sep = "") #nolint

# solve for the proportional sample weights
weights <- dt |>
    group_by(label_strings) |>
    summarise(
        n = n(),
        weight = (1 / n) * 10
) |> select(-c(n))

# join weights to the original data
dt <- dt |>
    left_join(weights, by = "label_strings") |>
    select(-label_strings) |>
    relocate(weight, .before = text)

write_csv(dt, "data/train_weights.csv")