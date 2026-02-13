Class {
	#name : 'AILinearRegressionGradientDescentTest',
	#superclass : 'AIAbstractLinearModelTest',
	#category : 'AI-LinearModels-Tests',
	#package : 'AI-LinearModels-Tests'
}

{ #category : 'testing' }
AILinearRegressionGradientDescentTest class >> isAbstract [

	^ self == AILinearRegressionGradientDescentTest
]

{ #category : 'tests' }
AILinearRegressionGradientDescentTest >> testDivergingException [

	"Training the model with non-sense, completely unproportioned data and with a very high learning rate to raise the diverging exception."

	|input output |

	input := #( #( 13421525235235235235 ) #( 3 ) #( 0.1 ) #( 0.000005 ) #( 241241241124124124 ) #( 6412412412414 ) #(45345) #(5) #(53) #(5) #(3) #(1) #(2) #(1) #(0.09) #(0.4) #(0.0009) #(5) #(234242342423423) #(0.9888) #(0.0000009) ).
	
	output := (1 to: input size) collect: [ :e | 0 ].

	model learningRate: 100.

	self should: [model fitX: input y: output] raise: ModelStartingToDivergeException
]

{ #category : 'tests' }
AILinearRegressionGradientDescentTest >> testInitializeWeightsToZeroOfSize [

	| expectedInitWeigths |
	expectedInitWeigths := #(0 0 0).
	model initializeWeightsToZeroOfSize: 3.
	
	self assert: model weights equals: expectedInitWeigths   
]

{ #category : 'tests' }
AILinearRegressionGradientDescentTest >> testPerformedIterationsIsInitialized [

	self assert: model performedIterations equals: nil
]
