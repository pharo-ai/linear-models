"
Linear regression implementation using least squares from LAPACK
"
Class {
	#name : #AILinearRegressionLeastSquares,
	#superclass : #Object,
	#instVars : [
		'weights',
		'bias'
	],
	#category : #'AI-LinearModels-Linear regression'
}

{ #category : #accessing }
AILinearRegressionLeastSquares >> bias [

	^ bias
]

{ #category : #api }
AILinearRegressionLeastSquares >> fitX: inputColumnMajorMatrix y: outputVector [

	| xOffset yOffset centeredOutputVector |
	yOffset := outputVector average.
	xOffset := inputColumnMajorMatrix columnAverage.
	inputColumnMajorMatrix -= xOffset.
	centeredOutputVector := outputVector - yOffset.

	weights := self
		solveLeastSquaresInputMatrix: inputColumnMajorMatrix
		outputVector: (centeredOutputVector asAIMatrix: AIColumnMajorMatrix).

	bias := yOffset - (xOffset * weights) sum
]

{ #category : #running }
AILinearRegressionLeastSquares >> hypothesisFunction: inputMatrix [

	"The hypothesis function for the linear regression is the line equation. It can be a multidimensional line."

	"h(x) = X*w + bias"

	^ self weightedSumOf: inputMatrix
]

{ #category : #api }
AILinearRegressionLeastSquares >> predict: inputMatrix [

	^ self hypothesisFunction: inputMatrix
]

{ #category : #training }
AILinearRegressionLeastSquares >> solveLeastSquaresInputMatrix: aMatrix outputVector: aVector [

	| leastSquares rowSize |
	leastSquares := AILeastSquares new
		matrixA: aMatrix;
		matrixB: aVector;
		yourself.
	
	leastSquares solve.
	
	rowSize := aMatrix numberOfColumns.
	^ (1 to: rowSize) collect: [ :i | leastSquares solution contents at: i ]
]

{ #category : #running }
AILinearRegressionLeastSquares >> weightedSumOf: inputMatrix [

	"z = Xw + b"

	"As X is a matrix we need to multiplicate each of the rows, the rows are the data, with the weights.
	Each of the rows has n size. n being the number of features.
	After the multiplication of a row with all the weights, we need to sum all the elements and add the bias.
	Then we return a vector of the same size of the original inputMatrix."

	| weightedSum |
	weightedSum := Array new: inputMatrix size.
	1 to: inputMatrix size do: [ :index | 
		| sum row |
		row := (inputMatrix at: index).
		sum := (row * weights) sum + bias.
		weightedSum at: index add: sum ].

	^ weightedSum
]

{ #category : #accessing }
AILinearRegressionLeastSquares >> weights [

	^ weights
]
