import argparse
import datasets
import pandas
import transformers
import tensorflow as tf
import numpy

model_path="model"
input_path="data/dev.csv"

# load the saved model
model = tf.keras.models.load_model(model_path)

# load the data for prediction
# use Pandas here to make assigning labels easier later
df = pandas.read_csv(input_path)

# create input features in the same way as in train()
hf_dataset = datasets.Dataset.from_pandas(df)
hf_dataset = hf_dataset.map(tokenize, batched=True)
hf_dataset = hf_dataset.map(to_bow)
tf_dataset = hf_dataset.to_tf_dataset(
    columns="input_bow",
    batch_size=16)

# generate predictions from model
predictions = numpy.where(model.predict(tf_dataset) > 0.5, 1, 0)

# assign predictions to label columns in Pandas data frame
df.iloc[:, 1:] = predictions

# write the Pandas dataframe to a zipped CSV file
df.to_csv("submission.zip", index=False, compression=dict(
    method='zip', archive_name=f'submission.csv'))
