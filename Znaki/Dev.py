import pickle
import tenserflow


with open("model", "rb") as m:
    model = pickle.load(m)


