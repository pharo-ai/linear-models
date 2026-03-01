Class {
	#name : 'AILinearRegressionGradientDescentTest',
	#superclass : 'AIAbstractLinearModelTest',
	#category : 'AI-LinearModels-Tests',
	#package : 'AI-LinearModels-Tests'
}

{ #category : 'testing' }
AILinearRegressionGradientDescentTest class >> isAbstract [

	^ self == AILinearRegressionGradientDescentTest
]

{ #category : 'tests' }
AILinearRegressionGradientDescentTest >> testDivergingException [

	"Training the model with non-sense, completely unproportioned data and with a very high learning rate to raise the diverging exception."

	|input output |

	input := #( #( 13421525235235235235 ) #( 3 ) #( 0.1 ) #( 0.000005 ) #( 241241241124124124 ) #( 6412412412414 ) #(45345) #(5) #(53) #(5) #(3) #(1) #(2) #(1) #(0.09) #(0.4) #(0.0009) #(5) #(234242342423423) #(0.9888) #(0.0000009) ).
	
	output := (1 to: input size) collect: [ :e | 0 ].

	model learningRate: 100.

	self should: [model fitX: input y: output] raise: ModelStartingToDivergeException
]

{ #category : 'tests' }
AILinearRegressionGradientDescentTest >> testDivergingExceptionWhenCostsIncrease [
	"Simulates an increase of the cost function and checks that the model raises the diverging error"

	model costHistory: (Array with: 0 with: 0.5).

	self should: [ model hasConverged ] raise: ModelStartingToDivergeException
]

{ #category : 'tests' }
AILinearRegressionGradientDescentTest >> testInitializeWeightsToZeroOfSize [

	| expectedInitWeigths |
	expectedInitWeigths := #(0 0 0).
	model initializeWeightsToZeroOfSize: 3.
	
	self assert: model weights equals: expectedInitWeigths   
]

{ #category : 'tests' }
AILinearRegressionGradientDescentTest >> testMaxIterationsReached [
	"Checks that the model performs the maximum number of iterations given and not more nor less"

	model maxIterations: 10.

	model fitX: self fixtureInput y: self fixtureOutput.

	self assert: model performedIterations equals: model maxIterations
]

{ #category : 'tests' }
AILinearRegressionGradientDescentTest >> testModelHasConvergedWhenCostDifferenceIsZero [
	"Simulates a stabilisation of the cost function and checks that the model reached convergence"

	model costHistory: (Array with: 10 with: 10).

	self assert: model hasConverged
]

{ #category : 'tests' }
AILinearRegressionGradientDescentTest >> testModelHasConvergedWhenLastCostIsZero [
	"Checks that the model reaches convergence when the cost function reaches 0"

	model costHistory: (Array with: 10 with: 0).

	self assert: model hasConverged
]

{ #category : 'tests' }
AILinearRegressionGradientDescentTest >> testModelHasNotConvergedWithEmptyCostHistory [
	"Checks that the model doesn't converge when the history of the cost function results is empty"

	model costHistory: OrderedCollection new.

	self deny: model hasConverged
]

{ #category : 'tests' }
AILinearRegressionGradientDescentTest >> testModelHasNotConvergedWithNoCostHistory [
	"Checks that the model doesn't converge when there isn't a history of the cost function results"

	self deny: model hasConverged
]

{ #category : 'tests' }
AILinearRegressionGradientDescentTest >> testNegativeMaxIterations [
	"Checks that the model doesn't perform iterations and doesn't add new cost function result when it is given negative max iterations number"

	model maxIterations: -1.

	model fitX: self fixtureInput y: self fixtureOutput.

	self assert: model performedIterations equals: 0.
	self assert: model costHistory size equals: 1
]

{ #category : 'tests' }
AILinearRegressionGradientDescentTest >> testPerformedIterationsIsInitialized [

	self assert: model performedIterations equals: nil
]
