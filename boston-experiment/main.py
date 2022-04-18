from sklearn.linear_model import LinearRegression
from scipy.linalg import lstsq
import numpy as np


with open('data/boston-train.csv', 'r') as f:
	lines = f.readlines()

x = np.array([[float(x) for x in line.strip().split(',')] for line in lines])

with open('data/boston-train-labels.csv', 'r') as f:
	lines = f.readlines()

y = np.array([float(line.strip()) for line in lines])

coef, residues, rank, singular = lstsq(x, y)

print("Minimum norm solution:")
print(coef)
print()
print("Effective rank:")
print(rank)
print()
print("Singular values:")
print(singular)