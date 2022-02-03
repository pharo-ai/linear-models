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

	self assert: realBias closeTo: model bias
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
