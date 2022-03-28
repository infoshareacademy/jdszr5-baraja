import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn import datasets


data = datasets.load_iris()

iris_data = data.data
print(plt.hist(data.target))


