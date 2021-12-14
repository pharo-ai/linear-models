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

{ #category : #defaults }
AILogisticRegressionTest >> generateRandomNumber: random between: lowerBound and: higherBound [

	^ lowerBound + (random next * (higherBound - lowerBound))
]

{ #category : #running }
AILogisticRegressionTest >> setUp [

	super setUp.
	model := AILogisticRegression new
]

{ #category : #tests }
AILogisticRegressionTest >> testExactFitSingleVariable [

	| output newInput expectedOutput actualOutput inputPositive inputNegative input |
	"From -4 to 4, positives numbers are 1 and the negatives are 0"
	inputNegative := #( #(-3.2) #(-3.6) #(-2.54) #(-1.64) #(-2.875) #(-1.867567) #(-0.876)
		#(-1.231421) #(-3.4242) #(-0.223) #(-1.343) ) .
	inputPositive := #( #(0.9898) #(1.767) #(2.87578) #(3.79867) #(1.767) #(2.0987897) #(1.79090)
		#(3.2322) #(2.4242) #(1.232342) #(0.42424) ).

	input := inputPositive , inputNegative.
	output := (inputPositive collect: [:e | 1]) , (inputNegative collect: [:e | 0]).

	newInput := #( #(0.788) #(3.098) #(2.987689) #(-0.78) #(-2.9898) #(-1.5778687) ).
	expectedOutput := #( 1 1 1 0 0 0 ).

	model := AILogisticRegression new
		         learningRate: 0.5;
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
	"The points that have both positive coordinates are 1 and the ones that have both of the coordinates negative numbers are 0"
	numIte := 50.
	inputNegative := OrderedCollection new.
	inputPositive := OrderedCollection new.
	random := Random seed: 453.
	
	numIte timesRepeat: [ 
		| x y |
		y:= self generateRandomNumber: random between: 0 and: 20. 
		x:= self generateRandomNumber: random between: 0 and: 20. 
		inputPositive add: {x . y}.
		
		y:= self generateRandomNumber: random between: 0 and: 20. 
		x:= self generateRandomNumber: random between: 0 and: 20. 
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

{ #category : #tests }
AILogisticRegressionTest >> testPredictProbabilities [

	| output newInput expectedOutput actualOutput inputPositive inputNegative input actualOutputPositive actualOutputNegative |
	"From -4 to 4, positives numbers are 1 and the negatives are 0"
	inputNegative := #( #(-3.2) #(-3.6) #(-2.54) #(-1.64) #(-2.875) #(-1.867567) #(-0.876)
		#(-1.231421) #(-3.4242) #(-0.223) #(-1.343) ) .
	inputPositive := #( #(0.9898) #(1.767) #(2.87578) #(3.79867) #(1.767) #(2.0987897) #(1.79090)
		#(3.2322) #(2.4242) #(1.232342) #(0.42424) ).

	input := inputPositive , inputNegative.
	output := (inputPositive collect: [:e | 1]) , (inputNegative collect: [:e | 0]).

	newInput := #( #(0.788) #(3.098) #(2.987689) #(-0.78) #(-2.9898) #(-1.5778687) ).
	expectedOutput := #( 1 1 1 0 0 0 ).

	model := AILogisticRegression new
		         learningRate: 0.5;
		         maxIterations: 1000;
		         yourself.

	model fitX: input y: output.
	actualOutput := model predictProbabilities: newInput.
	actualOutputPositive := actualOutput copyFrom: 1 to:3.
	actualOutputNegative := actualOutput copyFrom: 4 to: 6.

	actualOutputPositive do: [ :each | self assert: each > 0.5 ].
	actualOutputNegative do: [ :each | self assert: each < 0.5 ].
]
