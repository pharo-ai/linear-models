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

{ #category : #api }
AILinearRegressionLeastSquares >> fitX: inputMatrix y: outputVector [

	| leastSquares xOffset yOffset centeredInputMatrix centeredOutputVector |
	
	xOffset := inputMatrix average.
	yOffset := outputVector average.
	
	centeredInputMatrix := inputMatrix collect: [ :each | each - xOffset ].
	centeredOutputVector := outputVector - yOffset.

	leastSquares := LapackDgelsd new
		numberOfRows: centeredInputMatrix size;
		numberOfColumns: centeredInputMatrix first size;
		numberOfRightHandSides: 1;
		matrixA: centeredInputMatrix flattened;
		matrixB: centeredOutputVector;
		yourself.
	
	leastSquares solve.
	
	weights := leastSquares minimumNormSolution first: inputMatrix first size.
	bias := yOffset - (xOffset * weights)
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

{ #category : #running }
AILinearRegressionLeastSquares >> weightedSumOf: inputMatrix [

	"z = Xw + b"
	"As X is a matrix we need to multiplicate each of the rows, the rows are the data, with the weights.
	Each of the rows has n size. n being the number of features.
	After the multiplication of a row with all the weights, we need to sum all the elements and add the bias.
	Then we return a vector of the same size of the original inputMatrix."

	^ inputMatrix collect: [:row |
		(row * weights) sum + bias ]
]
