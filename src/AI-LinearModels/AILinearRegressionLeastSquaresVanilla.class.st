Class {
	#name : #AILinearRegressionLeastSquaresVanilla,
	#superclass : #AILinearRegressionLeastSquares,
	#category : #'AI-LinearModels-Linear regression'
}

{ #category : #'as yet unclassified' }
AILinearRegressionLeastSquaresVanilla >> solveLeastSquaresInputMatrix: aMatrix outputVector: aVector [

	| leastSquares |
	leastSquares := PMLeastSquares new.
	
	^ leastSquares
		solveMatrixA: (PMMatrix rows: aMatrix)
		matrixB: aVector asPMVector.
]
