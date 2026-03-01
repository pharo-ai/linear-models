Class {
	#name : 'AILinearRegressionTest',
	#superclass : 'AILinearRegressionGradientDescentTest',
	#category : 'AI-LinearModels-Tests',
	#package : 'AI-LinearModels-Tests'
}

{ #category : 'running' }
AILinearRegressionTest >> regression [

	^ AILinearRegression learningRate: 0.1 maxIterations: 3000
]

{ #category : 'tests' }
AILinearRegressionTest >> testBiasAlmostEqual [

	model fitX: self fixtureInput y: self fixtureOutput.

	self assert: model bias closeTo: fixture bias precision: 0.001
]

{ #category : 'tests' }
AILinearRegressionTest >> testBiasDerivative [

	self
		assert: (model biasDerivative: #( 3 4 5 6))
		equals: 4.5
]

{ #category : 'tests' }
AILinearRegressionTest >> testCostDerivativeActual [

	self
		assert: (model costDerivative: #( 10 20 30 ) actual: #( 11 22 33 ))
		equals: #(-1 -2 -3).
	
	self
		assert: (model costDerivative: #( 11 22 33 ) actual: #( 10 20 30 ))
		equals: #(1 2 3)
]

{ #category : 'tests' }
AILinearRegressionTest >> testExactFitSingleVariable [

	| newInput expectedOutput actualOutput |
	newInput := #( #( 4 ) #( 1 ) #( 7 ) #( 0 ) ).
	expectedOutput := #( 11 5 17 3 ).

	model fitX: self fixtureInput y: self fixtureOutput.
	actualOutput := model predict: newInput.

	actualOutput with: expectedOutput do: [ :actual :expected | self assert: actual closeTo: expected precision: 0.001 ]
]

{ #category : 'tests' }
AILinearRegressionTest >> testFixedIterations [
	"Checks that the model, with a given input and a fixed random number generator, always converges with the same amount of iterations"

	| expected |
	model fitX: self fixtureInput y: self fixtureOutput random: (Random seed: 42).
	expected := (SystemVersion current version beginsWith: 'Pharo11')
		            ifTrue: [ 432 ]
		            ifFalse: [ 424 ].

	self assert: model performedIterations equals: expected
]

{ #category : 'tests' }
AILinearRegressionTest >> testWeightDerivativeforXCostDerivative [
	
	self
		assert: (model weightDerivativeforX: #( (1 2 3) (4 5 6) (7 8 9) (10 11 12) ) costDerivative: #( 9 8 7 6 ))
		equals: #( 37.5 45 52.5 )
]

{ #category : 'tests' }
AILinearRegressionTest >> testWeightsAlmostEqual [

	model fitX: self fixtureInput y: self fixtureOutput.

	fixture weights with: model weights do: [ :expected :actual |
		self assert: actual closeTo: expected precision: 0.0001 ]
]
