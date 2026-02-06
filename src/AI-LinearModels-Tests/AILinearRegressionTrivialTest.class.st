Class {
	#name : 'AILinearRegressionTrivialTest',
	#superclass : 'TestCase',
	#instVars : [
		'model',
		'fixture'
	],
	#category : 'AI-LinearModels-Tests',
	#package : 'AI-LinearModels-Tests'
}

{ #category : 'running' }
AILinearRegressionTrivialTest >> setUp [

	super setUp.
	fixture := AILinearRegressionTrivialFixture new.

	model := AILinearRegression new.
	model
		bias: fixture initialBias;
		weights: fixture initialWeights;
		learningRate: fixture learningRate
]

{ #category : 'tests' }
AILinearRegressionTrivialTest >> testCostBeforeLearning [

	| cost |
	cost := model costFunctionX: fixture inputMatrix y: fixture outputVector.
	self assert: cost equals: fixture expectedCostBeforeLearning 
]

{ #category : 'tests' }
AILinearRegressionTrivialTest >> testExpectedBiasAtFirstIteration [

	model updateWeightsForX: fixture inputMatrix y: fixture outputVector.
	
	self assert: model bias closeTo: fixture expectedBiasAtFirstIteration
]

{ #category : 'tests' }
AILinearRegressionTrivialTest >> testExpectedBiasDerivativeAtFirstIteration [

	| predictedOutputVector costDerivative biasDerivative |
	predictedOutputVector := model predict: fixture inputMatrix.
	costDerivative := model costDerivative: predictedOutputVector actual: fixture outputVector.

	biasDerivative := model biasDerivative: costDerivative.
	
	self assert: biasDerivative equals: fixture expectedBiasDerivativeAtFirstIteration
]

{ #category : 'tests' }
AILinearRegressionTrivialTest >> testExpectedWeightDerivateAtFirstIteration [

	| predictedOutputVector costDerivative weightDerivative |
	predictedOutputVector := model predict: fixture inputMatrix.
	costDerivative := model costDerivative: predictedOutputVector actual: fixture outputVector.
	weightDerivative := model weightDerivativeforX: fixture inputMatrix costDerivative: costDerivative.

	self assert: weightDerivative equals: fixture expectedWeightDerivativeAtFirstIterarion
]

{ #category : 'tests' }
AILinearRegressionTrivialTest >> testExpectedWeightsAtFirstIteration [

	model updateWeightsForX: fixture inputMatrix y: fixture outputVector.
	
	model weights
		with: fixture expectedWeightsAtFirstIteration
		do: [ :real : expected | self assert: real closeTo: expected ]
]

{ #category : 'tests' }
AILinearRegressionTrivialTest >> testPredictionBeforeLearning [

	| prediction |
	prediction := model predict: fixture inputMatrix.
	self assert: prediction equals: fixture expectedPredictionBeforeLearning
]
