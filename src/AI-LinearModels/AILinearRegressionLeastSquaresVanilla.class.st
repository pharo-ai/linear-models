"
Linear Regression using least squares algorithm from PolyMath, that is Pure written in pure Pharo
"
Class {
	#name : 'AILinearRegressionLeastSquaresVanilla',
	#superclass : 'AILinearRegressionLeastSquares',
	#category : 'AI-LinearModels-Linear regression',
	#package : 'AI-LinearModels',
	#tag : 'Linear regression'
}

{ #category : 'api' }
AILinearRegressionLeastSquaresVanilla >> fitX: inputMatrix y: outputVector [

	| xOffset yOffset centeredInputMatrix centeredOutputVector |
	"yOffset := outputVector columnAverage first."
	yOffset := outputVector average.
	xOffset := inputMatrix average.
	centeredInputMatrix := inputMatrix collect: [ :col | col - xOffset].
	centeredOutputVector := outputVector - yOffset.

	weights := self
		solveLeastSquaresInputMatrix: centeredInputMatrix
		outputVector: centeredOutputVector.

	bias := yOffset - (xOffset * weights) sum
]

{ #category : 'training' }
AILinearRegressionLeastSquaresVanilla >> solveLeastSquaresInputMatrix: aMatrix outputVector: aVector [

	| leastSquares |
	leastSquares := PMLeastSquares new.
	
	^ leastSquares
		solveMatrixA: (PMMatrix rows: aMatrix)
		matrixB: aVector asPMVector.
]
