Class {
	#name : 'AILinearRegressionLeastSquaresTest',
	#superclass : 'AILinearRegressionTest',
	#category : 'AI-LinearModels-Tests',
	#package : 'AI-LinearModels-Tests'
}

{ #category : 'running' }
AILinearRegressionLeastSquaresTest >> regression [

	^ AILinearRegressionLeastSquares new
]

{ #category : 'tests' }
AILinearRegressionLeastSquaresTest >> testInitializeWeightsToZeroOfSize [

	self skip
]

{ #category : 'tests' }
AILinearRegressionLeastSquaresTest >> testLearningRateIsInitialized [

	self skip
]

{ #category : 'tests' }
AILinearRegressionLeastSquaresTest >> testMaxIterationsIsInitialized [

	self skip
]

{ #category : 'tests' }
AILinearRegressionLeastSquaresTest >> testPerformedIterationsIsInitialized [

	self skip
]

{ #category : 'tests' }
AILinearRegressionLeastSquaresTest >> testWeightDerivativeforXCostDerivative [

	self skip
]
