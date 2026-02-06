"
I am a fixture with a small and simple example for linear regression.
I provide input matrix X and expected output vector y.
"
Class {
	#name : 'AILinearRegressionFixture',
	#superclass : 'Object',
	#instVars : [
		'bias',
		'inputMatrix',
		'outputVector',
		'weights'
	],
	#category : 'AI-LinearModels-Tests',
	#package : 'AI-LinearModels-Tests'
}

{ #category : 'accessing' }
AILinearRegressionFixture >> bias [

	^ bias
]

{ #category : 'initialization' }
AILinearRegressionFixture >> initialize [

	| function |
	super initialize.
	
	bias := 3.
	inputMatrix := #( #( 2 ) #( 3 ) #( 1 ) #( 5 ) #( 2 ) #( 6 ) ).
	weights := #( 2 ).
	
	function := [ :x | ( weights at: 1) * x + self bias ].
	outputVector := inputMatrix collect: [ :x | function value: x first ]
	
	
]

{ #category : 'accessing' }
AILinearRegressionFixture >> inputMatrix [

	^ inputMatrix
]

{ #category : 'accessing' }
AILinearRegressionFixture >> outputVector [

	^ outputVector
]

{ #category : 'accessing' }
AILinearRegressionFixture >> weights [

	^ weights
]
