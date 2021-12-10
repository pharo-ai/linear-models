Class {
	#name : #AILinearRegressionTest,
	#superclass : #TestCase,
	#instVars : [
		'model'
	],
	#category : #'AI-Regressions-Tests'
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
		         maxIterations: 5000;
		         yourself.

	model fitX: input y: output.
	actualOutput := model predict: newInput.
	actualOutput
		with: expectedOutput
		do: [ :actual :expected | self assert: actual closeTo: expected ]
]

{ #category : #tests }
AILinearRegressionTest >> testExactFitTwoVariables [
]
