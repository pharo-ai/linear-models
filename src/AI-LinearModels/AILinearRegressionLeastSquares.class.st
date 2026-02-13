"
Linear regression implementation solving the least squares problem using Pharo-LAPACK
"
Class {
	#name : 'AILinearRegressionLeastSquares',
	#superclass : 'Object',
	#instVars : [
		'weights',
		'bias'
	],
	#category : 'AI-LinearModels-Linear regression',
	#package : 'AI-LinearModels',
	#tag : 'Linear regression'
}

{ #category : 'accessing' }
AILinearRegressionLeastSquares >> bias [

	^ bias
]

{ #category : 'accessing' }
AILinearRegressionLeastSquares >> bias: anInteger [

	bias := anInteger
]

{ #category : 'api' }
AILinearRegressionLeastSquares >> fitX: inputMatrix y: outputVector [

	| xOffset yOffset centeredOutputVector |
	"yOffset := outputVector columnAverage first."
	yOffset := outputVector average.
	xOffset := inputMatrix columnAverage.
	inputMatrix -= xOffset.
	centeredOutputVector := outputVector - yOffset.

	weights := self solveLeastSquaresInputMatrix: inputMatrix outputVector: (centeredOutputVector asAIMatrix: AIColumnMajorMatrix).

	bias := yOffset - (xOffset * weights) sum
]

{ #category : 'running' }
AILinearRegressionLeastSquares >> hypothesisFunction: inputMatrix [

	"The hypothesis function for the linear regression is the line equation. It can be a multidimensional line."

	"h(x) = X*w + bias"

	^ self weightedSumOf: inputMatrix
]

{ #category : 'api' }
AILinearRegressionLeastSquares >> predict: inputMatrix [

	^ self hypothesisFunction: inputMatrix
]

{ #category : 'training' }
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

{ #category : 'running' }
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
		weightedSum at: index put: sum ].

	^ weightedSum
]

{ #category : 'accessing' }
AILinearRegressionLeastSquares >> weights [

	^ weights
]

{ #category : 'accessing' }
AILinearRegressionLeastSquares >> weights: aCollection [

	weights := aCollection
]
