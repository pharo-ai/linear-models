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
	#superclass : #AIAbstractRegression,
	#category : #'AI-LinearRegression'
}

{ #category : #'as yet unclassified' }
AILinearRegression class >> defaultLearningRate [

	^ 0.01
]

{ #category : #'as yet unclassified' }
AILinearRegression class >> defaultMaxIterations [

	^ 1000
]

{ #category : #accessing }
AILinearRegression class >> defaultNormalizerClass [

	^ AIMinMaxNormalizer
]

{ #category : #api }
AILinearRegression >> predict: inputMatrix [
	
	^ inputMatrix collect: [ :row |
		(row * weights) sum + bias ]
]

{ #category : #accessing }
AILinearRegression >> shouldNormalizeData: aBoolean [

	shouldNormalizeData := aBoolean
]

{ #category : #running }
AILinearRegression >> updateX: inputMatrix y: targetVector [

	| predictedVector difference |
	
	predictedVector := self predict: inputMatrix.
	difference := targetVector - predictedVector.
	
	bias := bias + (2 * learningRate * difference sum).

	weights := weights + (2 * learningRate * ((1 to: targetVector size) sum: [ :i |	
		(difference at: i) * (inputMatrix at: i) ])).
]
