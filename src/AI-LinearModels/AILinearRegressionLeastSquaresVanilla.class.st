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

{ #category : 'training' }
AILinearRegressionLeastSquaresVanilla >> solveLeastSquaresInputMatrix: aMatrix outputVector: aVector [

	| leastSquares |
	leastSquares := PMLeastSquares new.

	^ leastSquares solveMatrixA: aMatrix matrixB: aVector asPMVector
]
