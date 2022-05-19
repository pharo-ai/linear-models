"
Linear regression is a machine learning model that attempts to find the the linear relationship between one or more input variables x1, x2, ..., xn and an output variable y. It finds a set of parameters b, w1, w2, ..., wn such that the predicted output h(x) = b + w1 * x1 + ... + wn * xn is as close as possible to the real output y.

How to use it

```
model := AILinearRegression new
  learningRate: 0.001;
  maxIterations: 2000;
  yourself.
	
model fitX: input y: output.
```

```
input := #(
    (-6 0.44 3)
    (4 -0.45 -7)
    (-4 -0.16 4)
    (9 0.17 -8)
    (-6 -0.41 8)
    (9 0.03 6)
    (-2 -0.26 -4)
    (-3 -0.02 -6)
    (6 -0.18 -2)
    (-6 -0.11 9)
    (-10 0.15 -8)
    (-8 -0.13 7)
    (3 -0.29 1)
    (8 -0.21 -1)
    (-3 0.12 7)
    (4 0.03 5)
    (3 -0.27 2)
    (-8 -0.21 -10)
    (-10 -0.41 -8)
    (-5 0.11 0)).

output := #(-10.6 10.5 -13.6 27.7 -24.1 12.3 -2.6 -0.2 12.2 -22.1 -10.5 -24.3 2.1 14.9 -11.8 3.3 1.3 -8.1 -16.1 -8.9).
```
"
Class {
	#name : #AILinearRegression,
	#superclass : #AIAbstractLinearModel,
	#category : #'AI-LinearModels-Linear regression'
}

{ #category : #running }
AILinearRegression >> biasDerivative: costDerivative [


	"J(w) = (1/n) * Σ (yi - h(z))^2"

	"dj/db = dj/dz * dz/db"
	"dj/dz = (1/n) *  2 * Σ (yi - h(z))
	dz/db = 1	"

	"So the derivate of the cost funciton in terms of the bias is the same as the derivative
	of the cost function in terms of the z"

	^ costDerivative average
]

{ #category : #running }
AILinearRegression >> costDerivative: predictedOutputVector actual: targetOutputVector [

	"We are using the mean squared error function to minimize the errors."

	"h(z) = activation function
	z = X*w + bias"

	"cost function = J(w) = (1/n) * Σ (yi - h(z))^2
	Is the same as:
	J(w) = (1/n) * Σ (y - (xi*w + bias))^2"

	"So, the derivative of the cost function in terms of z
	dj/dz = (1/n) *  2 * Σ (yi - h(z))"

	"This method receives the h(z) which is the predicted output vector as a parameter.
	We return a vector instead of a number. That means that we should sum the elements of the vector
	and divide by N in weight and bias derivative methods"

	^ 2 * (predictedOutputVector - targetOutputVector)
]

{ #category : #running }
AILinearRegression >> costFunctionX: inputMatrix y: actualValues [

	"The cost function for the linear regression is the mean squared error function"

	"J(w) = (1/n) * Σ (yi - h(z))^2"

	| predictedValues squaredSum |
	predictedValues := self hypothesisFunction: inputMatrix.

	squaredSum := (actualValues - predictedValues) collect: [ :each | each ** 2 ].
	^ squaredSum average
]

{ #category : #running }
AILinearRegression >> hypothesisFunction: inputMatrix [

	"The hypothesis function for the linear regression is the line equation. It can be a multidimensional line."

	"h(x) = X*w + bias"

	^ self weightedSumOf: inputMatrix
]

{ #category : #api }
AILinearRegression >> predict: inputMatrix [

	^ self hypothesisFunction: inputMatrix
]

{ #category : #running }
AILinearRegression >> weightDerivativeforX: inputMatrix costDerivative: costDerivativeVector [

	"J(w) = (1/n) * Σ (yi - h(z))^2"

	"dj/dw = dj/dz * dz/dw
	dz/dw = X"
	"So,
	dj/dw = X * dj/dz"

	| weightsDerivative |
	weightsDerivative := inputMatrix
		with: costDerivativeVector
		collect: [ :x : cost | x * cost ].

	^ weightsDerivative average
]
