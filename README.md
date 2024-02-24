# :brain: Classifying a subset of Google's GoEmotions Data

This project labels a portion of Google's [GoEmotions](https://github.com/google-research/google-research/tree/master/goemotions) data -- a collection of Reddit comments that were hand labelled for a range of emotions. `nn.ipynb` specifies and trains an RNN on a train/development/test split which achieves an F1 score of 0.8 on the test data. The framework used is Tensorflow and hyperparameter tuning was performed using [W & B](https://wandb.ai/).
