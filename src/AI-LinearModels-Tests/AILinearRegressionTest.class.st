Class {
	#name : #AILinearRegressionTest,
	#superclass : #AIAbstractLinearModelTest,
	#category : #'AI-LinearModels-Tests'
}

{ #category : #running }
AILinearRegressionTest >> regression [

	^ AILinearRegression new
]

{ #category : #tests }
AILinearRegressionTest >> testBiasAlmostEqual [

	| fixture |
	fixture := AILinearRegressionFixture new.

	model := AILinearRegression new
		learningRate: 0.1;
		maxIterations: 3000;
		yourself.

	model
		fitX: fixture inputMatrix
		y: fixture outputVector.

	self assert: model bias closeTo: fixture bias
]

{ #category : #tests }
AILinearRegressionTest >> testBiasDerivative [

	self
		assert: (model biasDerivative: #( 3 4 5 6))
		equals: 4.5
]

{ #category : #tests }
AILinearRegressionTest >> testCostDerivativeActual [

	self
		assert: (model costDerivative: #( 10 20 30 ) actual: #( 11 22 33 ))
		equals: #(-1 -2 -3).
	
	self
		assert: (model costDerivative: #( 11 22 33 ) actual: #( 10 20 30 ))
		equals: #(1 2 3)
]

{ #category : #tests }
AILinearRegressionTest >> testDivergingException [

	"Training the model with non-sense, completely unproportioned data and with a very high learning rate to raise the diverging exception."

	|input output |

	input := #( #( 13421525235235235235 ) #( 3 ) #( 0.1 ) #( 0.000005 ) #( 241241241124124124 ) #( 6412412412414 ) #(45345) #(5) #(53) #(5) #(3) #(1) #(2) #(1) #(0.09) #(0.4) #(0.0009) #(5) #(234242342423423) #(0.9888) #(0.0000009) ).
	
	output := #( 4 234 523 523 5 63456346346346 636463 63463 0.253 0.84234 0.00042 243 4 2 2 5 2 5235235 0.0005 3 3 ).

	model := AILinearRegression new
		learningRate: 100;
		maxIterations: 3000;
		yourself.

	self should: [model fitX: input y: output] raise: ModelStartingToDivergeException
]

{ #category : #tests }
AILinearRegressionTest >> testExactFitSingleVariable [

	| newInput expectedOutput actualOutput fixture |
	fixture := AILinearRegressionFixture new.

	newInput := #( #( 4 ) #( 1 ) #( 7 ) #( 0 ) ).
	expectedOutput := #( 11 5 17 3 ).

	model := AILinearRegression new
		learningRate: 0.01;
		maxIterations: 3000;
		yourself.

	model fitX: fixture inputMatrix y: fixture outputVector.
	actualOutput := model predict: newInput.
	actualOutput
		with: expectedOutput
		do: [ :actual :expected | self assert: actual closeTo: expected ]
]

{ #category : #tests }
AILinearRegressionTest >> testWeightDerivativeforXCostDerivative [
	
	self
		assert: (model weightDerivativeforX: #( (1 2 3) (4 5 6) (7 8 9) (10 11 12) ) costDerivative: #( 9 8 7 6 ))
		equals: #( 37.5 45 52.5 )
]

{ #category : #tests }
AILinearRegressionTest >> testWeightsAlmostEqual [

	| fixture |
	fixture := AILinearRegressionFixture new.

	model := AILinearRegression new
		learningRate: 0.1;
		maxIterations: 3000;
		yourself.

	model
		fitX: fixture inputMatrix
		y: fixture outputVector.

	fixture weights with: model weights do: [ :expected :actual |
		self assert: actual closeTo: expected ]
]
