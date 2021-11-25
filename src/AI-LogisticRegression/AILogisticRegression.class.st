Class {
	#name : #AILogisticRegression,
	#superclass : #AILinearRegression,
	#instVars : [
		'predictedY'
	],
	#category : #'AI-LogisticRegression'
}

{ #category : #running }
AILogisticRegression >> costDerivativeX: inputMatrix y: outputVector [


]

{ #category : #initialization }
AILogisticRegression >> initializeWeightsOfSize: aNumber [

	| rand |
	rand := Random new.
	
	bias := rand next.
	weights := (1 to: aNumber) collect: [ :i | rand next ].
]

{ #category : #api }
AILogisticRegression >> predict: inputMatrix [

	| prediction |
	prediction := inputMatrix collect: [ :row | (row * weights) sum + bias ].

	^ prediction collect: [ :each | 
		each > 0.5
			ifTrue: [ 1 ]
			ifFalse: [ 0 ] ]
]

{ #category : #running }
AILogisticRegression >> sigmoidForTheta: zVector [

	^ zVector collect: [ :z | 
		1 / (1 + (Float e raisedTo: z negated)) ]
]

{ #category : #running }
AILogisticRegression >> updateX: inputMatrix y: outputVector [

	"Use the gradient descent function"

	| weightDerivative biasDerivative yPredicted z djdz |
	z := self zForX: inputMatrix.
	yPredicted := self sigmoidForTheta: z.

	djdz := yPredicted - outputVector.

	"weightDerivative := (inputMatrix * djdz) average."

	weightDerivative := (1 to: inputMatrix size) sum: [ :index | 
		(inputMatrix at: index) * (djdz at: index) ].
	weightDerivative := weightDerivative / weightDerivative size.

	biasDerivative := djdz average.

	weights := weights - (learningRate * weightDerivative).
	bias := bias - (learningRate * biasDerivative)
]

{ #category : #running }
AILogisticRegression >> zForX: inputMatrix [

	"z = Xw + b"

	^ inputMatrix collect: [:row |
		(row * weights) sum + bias ]
]
