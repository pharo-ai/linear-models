Class {
	#name : #AILogisticRegression,
	#superclass : #AILinearRegression,
	#instVars : [
		'predictedY'
	],
	#category : #'AI-LogisticRegression'
}

{ #category : #running }
AILogisticRegression >> biasDerivative: djdz [

	"J(w) = cost function"
	"J = - ylog( h(x) ) - ( 1 - y )log( 1 - h(x) )"
	"dJ/db = (dJ/dh)*(dh/dz)*(dz/db)"
	"dz/db = 1"
	"dJ/db = 1*dJ/dz "
	"dJ/db = h(z) - y"
	
	^ djdz average
]

{ #category : #running }
AILogisticRegression >> djdzForH: yPredicted y: outputVector [

	"h(z) = sigmoid function (see method comment)"
	"z = Xw + bias (see method comment)"

	"J(w) = cost function"
	"J = - ylog( h(z) ) - ( 1 - y )log( 1 - h(z) )"
	"dJ/dz = (dJ/dh)*(dh/dz)"
	"dJ/dz = h(z) - y"

	^ yPredicted - outputVector
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
AILogisticRegression >> sigmoidForZ: zVector [

	"Sigmoid function: 1 / (1 + e ^ -z)"
	
	^ zVector collect: [ :z | 
		1 / (1 + (Float e raisedTo: z negated)) ]
]

{ #category : #running }
AILogisticRegression >> updateX: inputMatrix y: outputVector [

	| weightDerivative biasDerivative yPredicted z djdz |

	z := self zForX: inputMatrix.
	yPredicted := self sigmoidForZ: z.

	djdz := self djdzForH: yPredicted y: outputVector.
	weightDerivative := self weightDerivativeforX: inputMatrix djdz: djdz.

	biasDerivative := self biasDerivative: djdz.

	weights := weights - (learningRate * weightDerivative).
	bias := bias - (learningRate * biasDerivative)
]

{ #category : #running }
AILogisticRegression >> weightDerivativeforX: inputMatrix djdz: djdz [

	"J(w) = cost function"
	"J = - ylog( h(x) ) - ( 1 - y )log( 1 - h(x) )"
	"dJ/dw = (dJ/dh)*(dh/dz)*(dz/dw)"
	"dJ/dw = X*(dJ/dz)"
	"dJ/dw = X( h(z) - y )"

	| weightDerivative |
	weightDerivative := (1 to: inputMatrix size) sum: [ :index | 
		(inputMatrix at: index) * (djdz at: index) ].
	^ weightDerivative / weightDerivative size
]

{ #category : #running }
AILogisticRegression >> zForX: inputMatrix [

	"z = Xw + b"
	"As X is a matrix we need to multiplicate each of the rows, the rows are the data, with the weights.
	Each of the rows has n size. n being the number of features.
	After the multiplication of a row with all the weights, we need to sum all the elements and add the bias.
	Then we return a vector of the same size of the original X matrix."

	^ inputMatrix collect: [:row |
		(row * weights) sum + bias ]
]
