import pandas as pd

dt = pd.read_csv("data/train.csv")

# get the unique number of label combinations
dt['label_strings'] = dt[].astype(str).agg(''.join, axis=1)

# solve for the proportional sample weights
weights = dt.groupby('label_strings').size().reset_index(name='n')
weights['weight'] = (1 / weights['n']) * 10
weights = weights.drop('n', axis=1)

# join weights to the original data
dt = dt.merge(weights, on='label_strings', how='left')
dt = dt.drop('label_strings', axis=1)
dt = dt[['weight'] + [col for col in dt.columns if col != 'weight']]

dt.to_csv("data/train_weights.csv", index=False)
