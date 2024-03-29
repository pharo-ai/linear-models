"
An AILogisticRegressionTest is a test class for testing the behavior of AILogisticRegression
"
Class {
	#name : #AILogisticRegressionTest,
	#superclass : #AIAbstractLinearModelTest,
	#category : #'AI-LinearModels-Tests'
}

{ #category : #defaults }
AILogisticRegressionTest >> generateRandomNumber: random between: lowerBound and: higherBound [

	^ lowerBound + (random next * (higherBound - lowerBound))
]

{ #category : #running }
AILogisticRegressionTest >> regression [

	^AILogisticRegression new
]

{ #category : #tests }
AILogisticRegressionTest >> testDivergingException [

	"Training the model with non-sense, completely unproportioned data and with a very high learning rate to raise the diverging exception."

	|input output |

	input := #( #( 13421525235235235235 ) #( 3 ) #( 0.1 ) #( 0.000005 ) #( 241241241124124124 ) #( 6412412412414 ) #(45345) #(5) #(53) #(5) #(3) #(1) #(2) #(1) #(0.09) #(0.4) #(0.0009) #(5) #(234242342423423) #(0.9888) #(0.0000009) ).
	
	output := (1 to: input size) collect: [ :e | 0 ].

	model := AILogisticRegression new
		learningRate: 100;
		maxIterations: 3000;
		yourself.

	self should: [model fitX: input y: output] raise: ModelStartingToDivergeException
]

{ #category : #tests }
AILogisticRegressionTest >> testExactFitSingleVariable [

	| output newInput expectedOutput actualOutput inputPositive inputNegative input |
	"From -4 to 4, positives numbers are 1 and the negatives are 0"
	inputNegative := #( #( -3.2 ) #( -3.6 ) #( -2.54 ) #( -1.64 )
	                    #( -2.875 ) #( -1.867567 ) #( -0.876 )
	                    #( -0.0231421 ) #( -3.4242 ) #( -0.223 )
	                    #( -1.343 ) ).
	inputPositive := #( #( 0.01 ) #( 1.767 ) #( 2.87578 ) #( 3.79867 )
	                    #( 1.767 ) #( 2.0987897 ) #( 1.79090 )
	                    #( 3.2322 ) #( 2.4242 ) #( 1.232342 )
	                    #( 0.42424 ) ).

	input := inputPositive , inputNegative.
	output := (inputPositive collect: [ :e | 1 ])
	          , (inputNegative collect: [ :e | 0 ]).

	newInput := #( #( 0.788 ) #( 3.098 ) #( 2.987689 ) #( -0.78 )
	               #( -2.9898 ) #( -1.5778687 ) ).
	expectedOutput := #( 1 1 1 0 0 0 ).

	model := AILogisticRegression new
		         learningRate: 0.1;
		         maxIterations: 2000;
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
	inputNegative := #( #( -3.2 ) #( -3.6 ) #( -2.54 ) #( -1.64 )
	                    #( -2.875 ) #( -1.867567 ) #( -0.876 )
	                    #( -1.231421 ) #( -3.4242 ) #( -0.223 )
	                    #( -1.343 ) ).
	inputPositive := #( #( 0.9898 ) #( 1.767 ) #( 2.87578 ) #( 3.79867 )
	                    #( 1.767 ) #( 2.0987897 ) #( 1.79090 )
	                    #( 3.2322 ) #( 2.4242 ) #( 1.232342 )
	                    #( 0.42424 ) ).

	input := inputPositive , inputNegative.
	output := (inputPositive collect: [ :e | 1 ])
	          , (inputNegative collect: [ :e | 0 ]).

	newInput := #( #( 0.788 ) #( 3.098 ) #( 2.987689 ) #( -0.78 )
	               #( -2.9898 ) #( -1.5778687 ) ).
	expectedOutput := #( 1 1 1 0 0 0 ).

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
