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

	| function realWeights realBias input output |
	realWeights := #( 2 ).
	realBias := 5.
	function := [ :x | (realWeights at: 1) * x + realBias ].

	input := #( #( 2 ) #( 3 ) #( 1 ) #( 5 ) #( 2 ) #( 6 ) ).
	output := input collect: [ :x | function value: x first ].

	model := AILinearRegression new
		         learningRate: 0.01;
		         maxIterations: 3000;
		         yourself.

	model fitX: input y: output.

	self deny: realBias closeTo: model bias
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

	| function input output newInput expectedOutput actualOutput |
	function := [ :x | 2 * x + 3 ].

	input := #( #( 2 ) #( 3 ) #( 1 ) #( 5 ) #( 2 ) #( 6 ) ).
	output := input collect: [ :x | function value: x first ].

	newInput := #( #( 4 ) #( 1 ) #( 7 ) #( 0 ) ).
	expectedOutput := #( 11 5 17 3 ).

	model := AILinearRegression new
		         learningRate: 0.01;
		         maxIterations: 3000;
		         yourself.

	model fitX: input y: output.
	actualOutput := model predict: newInput.
	actualOutput
		with: expectedOutput
		do: [ :actual :expected | self assert: actual closeTo: expected ]
]

{ #category : #tests }
AILinearRegressionTest >> testWeightsAlmostEqual [

	| function realWeights realBias input output |
	realWeights := #( 2 ).
	realBias := 5.
	function := [ :x | (realWeights at: 1) * x + realBias ].

	input := #( #( 2 ) #( 3 ) #( 1 ) #( 5 ) #( 2 ) #( 6 ) ).
	output := input collect: [ :x | function value: x first ].

	model := AILinearRegression new
		         learningRate: 0.01;
		         maxIterations: 3000;
		         yourself.

	model fitX: input y: output.

	realWeights
		with: model weights
		do: [ :real :modeled | self assert: real closeTo: modeled ]
]
