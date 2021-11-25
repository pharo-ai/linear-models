"
An AILogisticRegressionTest is a test class for testing the behavior of AILogisticRegression
"
Class {
	#name : #AILogisticRegressionTest,
	#superclass : #TestCase,
	#instVars : [
		'model'
	],
	#category : #'AI-Regressions-Tests'
}

{ #category : #running }
AILogisticRegressionTest >> setUp [

	super setUp.
	model := AILogisticRegression new
]

{ #category : #tests }
AILogisticRegressionTest >> testExactFitSingleVariable [

	| output newInput expectedOutput actualOutput inputPositive inputNegative input |
	"From -4 to 4, positives numbers are 1"
	inputNegative := #( #(-3.2) #(-3.6) #(-2.54) #(-1.64) #(-2.875) #(-1.867567) #(-0.876)
		#(-1.231421) #(-3.4242) #(-0.223) #(-1.343) ) .
	inputPositive := #( #(0.9898) #(1.767) #(2.87578) #(3.79867) #(1.767) #(2.0987897) #(1.79090)
		#(3.2322) #(2.4242) #(1.232342) #(0.42424) ).

	input := inputPositive , inputNegative.
	output := (inputPositive collect: [:e | 1]) , (inputNegative collect: [:e | 0]).

	newInput := #( #(0.788) #(3.098) #(2.987689) #(-0.78) #(-2.9898) #(-1.5778687) ).
	expectedOutput := #( 1 1 1 0 0 0 ).

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

{ #category : #tests }
AILogisticRegressionTest >> testExactFitTwoVariables [

	| output newInput expectedOutput actualOutput inputPositive inputNegative input numIte random |
	"The point that have both coordinates positive are 1 and the one that have both of the point as negative numbers are 0"
	numIte := 50.
	inputNegative := OrderedCollection new.
	inputPositive := OrderedCollection new.
	random := Random seed: 453.
	
	numIte timesRepeat: [ 
		| x y |
		y:= random nextIntegerBetween: 0 and: 20.
		x:= random nextIntegerBetween: 0 and: 20.
		inputPositive add: {x . y}.
		
		y:= random nextIntegerBetween: 0 and: 20.
		x:= random nextIntegerBetween: 0 and: 20.
		inputNegative add: {x negated . y negated} ].
	
	input := inputPositive , inputNegative.
	output := (inputPositive collect: [:e | 1]) , (inputNegative collect: [:e | 0]).

	newInput := #( #(3 5) #(15 11) #(6 11) #(-11 -11) #(-2 -4) #(-7 -9) ).
	expectedOutput := #( 1 1 1 0 0 0 ).

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
