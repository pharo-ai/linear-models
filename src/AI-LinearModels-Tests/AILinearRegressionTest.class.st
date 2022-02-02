Class {
	#name : #AILinearRegressionTest,
	#superclass : #AIAbstractLinearModelTest,
	#category : #'AI-LinearModels-Tests'
}

{ #category : #running }
AILinearRegressionTest >> setUp [
	super setUp.
	model := AILinearRegression new.
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
AILinearRegressionTest >> testInconsistentFitInputOnDimension [

	| function input output |
	function := [ :x | 2 * x + 3 ].

	input := #( #( 2 ) #( 3 ) #( 1 ) #( 5 ) #( 2 ) #( 6 ) ).
	output := input collect: [ :x | function value: x first ].
	input := input allButFirst.
	
	model := AILinearRegression new
		         learningRate: 0.01;
		         maxIterations: 3000;
		         yourself.

	self should: [ model fitX: input y: output ] raise: Error
]

{ #category : #tests }
AILinearRegressionTest >> testInconsistentFitInputOnType [

	| function input output |
	function := [ :x | 2 * x + 3 ].

	input := #( #( 2 ) #( 3 ) #( 1 ) #( 5 ) #( 2 ) #( 6 ) ).
	output := input collect: [ :x | function value: x first ].
	input := #( #( 'number' ) #( 3 ) #( 1 ) #( 5 ) #( 2 ) #( 6 ) ).

	model := AILinearRegression new
		         learningRate: 0.01;
		         maxIterations: 3000;
		         yourself.

	self should: [ model fitX: input y: output ] raise: Error
]

{ #category : #tests }
AILinearRegressionTest >> testInconsistentFitOutputOnDimension [

	| function input output |
	function := [ :x | 2 * x + 3 ].

	input := #( #( 2 ) #( 3 ) #( 1 ) #( 5 ) #( 2 ) #( 6 ) ).
	output := (input collect: [ :x | function value: x first ]) allButFirst .

	model := AILinearRegression new
		         learningRate: 0.01;
		         maxIterations: 3000;
		         yourself.

	self should: [ model fitX: input y: output ] raise: Error
]

{ #category : #tests }
AILinearRegressionTest >> testInconsistentFitOutputOnType [

	| function input output |
	function := [ :x | 2 * x + 3 ].

	input := #( #( 2 ) #( 3 ) #( 1 ) #( 5 ) #( 2 ) #( 6 ) ).
	output := input collect: [ :x | function value: x first ].
	output at: 1 put: 'number'.

	model := AILinearRegression new
		         learningRate: 0.01;
		         maxIterations: 3000;
		         yourself.

	self should: [ model fitX: input y: output ] raise: Error
]

{ #category : #tests }
AILinearRegressionTest >> testInconsistentPredictionInputOnType [

	| function input output newInput actualOutput |
	function := [ :x | 2 * x + 3 ].

	input := #( #( 2 ) #( 3 ) #( 1 ) #( 5 ) #( 2 ) #( 6 ) ).
	output := input collect: [ :x | function value: x first ].

	newInput := #( #( 'number' ) #( 1 ) #( 7 ) #( 0 ) ).

	model := AILinearRegression new
		         learningRate: 0.01;
		         maxIterations: 3000;
		         yourself.

	model fitX: input y: output.
	
self should: [ actualOutput := model predict: newInput ] raise: Error
]
