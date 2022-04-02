from keras.models import load_model
import cv2
import matplotlib.pyplot as plt

model = load_model("model_weights.h5")

imp = cv2.imread("stop.jpg")

plt.imshow(imp)
plt.show()


print(model.predict(imp))

