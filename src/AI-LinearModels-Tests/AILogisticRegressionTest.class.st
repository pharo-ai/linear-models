"
An AILogisticRegressionTest is a test class for testing the behavior of AILogisticRegression
"
Class {
	#name : 'AILogisticRegressionTest',
	#superclass : 'AILinearRegressionGradientDescentTest',
	#instVars : [
		'newInput',
		'expectedOutput',
		'input',
		'output'
	],
	#category : 'AI-LinearModels-Tests',
	#package : 'AI-LinearModels-Tests'
}

{ #category : 'running' }
AILogisticRegressionTest >> regression [

	^ AILogisticRegression new
]

{ #category : 'running' }
AILogisticRegressionTest >> setUp [

	| inputPositive inputNegative |
	super setUp. 
	
	"From -4 to 4, positives numbers are 1 and the negatives are 0"
	inputNegative := #( #( -3.2 ) #( -3.6 ) #( -2.54 ) #( -1.64 ) #( -2.875 ) #( -1.867567 ) #( -0.876 ) #( -1.231421 )
	                    #( -3.4242 ) #( -0.223 ) #( -1.343 ) ).
	inputPositive := #( #( 0.9898 ) #( 1.767 ) #( 2.87578 ) #( 3.79867 ) #( 1.767 ) #( 2.0987897 ) #( 1.79090 ) #( 3.2322 )
	                    #( 2.4242 ) #( 1.232342 ) #( 0.42424 ) ).

	input := inputPositive , inputNegative.
	output := (inputPositive collect: [ :e | 1 ]) , (inputNegative collect: [ :e | 0 ]).

	newInput := #( #( 0.788 ) #( 3.098 ) #( 2.987689 ) #( -0.78 ) #( -2.9898 ) #( -1.5778687 ) ).
	expectedOutput := #( 1 1 1 0 0 0 )
]

{ #category : 'tests' }
AILogisticRegressionTest >> testCostFunction [
	"Checks that the cost function of the model gives the right result"

	model := AILogisticRegression new initializeWeightsToZeroOfSize: 1.
	input := {
		         { 0.48498 }.
		         { 8.47382 }.
		         { -2.47483 }.
		         { -0.47483 } }.
	output := { 1. 1. 0. 0 }.

	self assert: (model costFunctionX: input y: output) equals: 0.5 ln negated
]

{ #category : 'tests' }
AILogisticRegressionTest >> testExactFitSingleVariable [

	| actualOutput |
	model := AILogisticRegression new
		         learningRate: 0.01;
		         maxIterations: 1000;
		         yourself.

	model fitX: input y: output.
	actualOutput := model predict: newInput.
	actualOutput
		with: expectedOutput
		do: [ :actual :expected | self assert: actual equals: expected ]
]

{ #category : 'tests' }
AILogisticRegressionTest >> testFixedIterations [
	"Checks that the model, with a given input and a fixed random number generator, always converges with the same amount of iterations
This model converges very slowly and doesn't reach convergence, so it performs the maximum number of iterations and ends (but since it's a logistic regression it's not a problem)"

	model fitX: input y: output random: (Random seed: 42).

	self assert: model performedIterations equals: 5000
]

{ #category : 'tests' }
AILogisticRegressionTest >> testPredictProbabilities [

	| actualOutput actualOutputPositive actualOutputNegative |
	model := AILogisticRegression new
		         learningRate: 0.01;
		         maxIterations: 1000;
		         yourself.

	model fitX: input y: output.
	actualOutput := model predictProbabilities: newInput.
	actualOutputPositive := actualOutput copyFrom: 1 to: 3.
	actualOutputNegative := actualOutput copyFrom: 4 to: 6.

	actualOutputPositive do: [ :each |
			self deny: each equals: 1.
			self assert: each > 0.5.
			self assert: each < 1 ].
	actualOutputNegative do: [ :each |
			self deny: each equals: 0.
			self assert: each < 0.5.
			self assert: each > 0 ]
]
