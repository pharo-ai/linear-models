"
This is a simple and trivial fixture that we did to compute things manually
"
Class {
	#name : 'AILinearRegressionTrivialFixture',
	#superclass : 'Object',
	#instVars : [
		'initialBias',
		'initialWeights',
		'inputMatrix',
		'outputVector',
		'learningRate',
		'expectedCostBeforeLearning',
		'expectedWeightDerivativeAtFirstIterarion',
		'expectedBiasDerivativeAtFirstIteration',
		'expectedWeightsAtFirstIteration',
		'expectedBiasAtFirstIteration',
		'expectedPredictionBeforeLearning'
	],
	#category : 'AI-LinearModels-Tests',
	#package : 'AI-LinearModels-Tests'
}

{ #category : 'accessing' }
AILinearRegressionTrivialFixture >> expectedBiasAtFirstIteration [

	^ expectedBiasAtFirstIteration
]

{ #category : 'accessing' }
AILinearRegressionTrivialFixture >> expectedBiasDerivativeAtFirstIteration [

	^ expectedBiasDerivativeAtFirstIteration
]

{ #category : 'accessing' }
AILinearRegressionTrivialFixture >> expectedCostBeforeLearning [

	^ expectedCostBeforeLearning
]

{ #category : 'accessing' }
AILinearRegressionTrivialFixture >> expectedPredictionBeforeLearning [

	^ expectedPredictionBeforeLearning
]

{ #category : 'accessing' }
AILinearRegressionTrivialFixture >> expectedWeightDerivativeAtFirstIterarion [

	^ expectedWeightDerivativeAtFirstIterarion
]

{ #category : 'accessing' }
AILinearRegressionTrivialFixture >> expectedWeightsAtFirstIteration [

	^ expectedWeightsAtFirstIteration
]

{ #category : 'accessing' }
AILinearRegressionTrivialFixture >> initialBias [

	^ initialBias
]

{ #category : 'accessing' }
AILinearRegressionTrivialFixture >> initialWeights [

	^ initialWeights
]

{ #category : 'initialization' }
AILinearRegressionTrivialFixture >> initialize [

	super initialize.

	initialBias := 0.
	initialWeights := #( 0 0 ).
	inputMatrix := #( #( 1 2 ) #( 3 4 ) #( 5 6 ) ).
	outputVector := #( 1 0 1 ).
	learningRate := 0.1.

	expectedPredictionBeforeLearning := #(0 0 0).
	expectedCostBeforeLearning := 2 / 3.
	expectedWeightDerivativeAtFirstIterarion := { -2. (-8 / 3) }.
	expectedBiasDerivativeAtFirstIteration := -2 / 3.
	expectedWeightsAtFirstIteration := { 0.2. (4 / 15) }.
	expectedBiasAtFirstIteration := 1/15
]

{ #category : 'accessing' }
AILinearRegressionTrivialFixture >> inputMatrix [

	^ inputMatrix
]

{ #category : 'accessing' }
AILinearRegressionTrivialFixture >> learningRate [

	^ learningRate
]

{ #category : 'accessing' }
AILinearRegressionTrivialFixture >> outputVector [

	^ outputVector
]
