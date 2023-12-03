library(tidyverse)

dt <- read_csv("data/train.csv")

dt <- dt |> mutate(
    label_count = admiration + amusement + gratitude + love + pride + relief + remorse #nolint
)

dt_onehot <- dt |> filter(label_count <= 1)

table(dt$label_count)

# solve for the right sample weights

dt_onehot |> group_by(label_count) |> summarise(
    n = n(),
    weight = 1 / n
)