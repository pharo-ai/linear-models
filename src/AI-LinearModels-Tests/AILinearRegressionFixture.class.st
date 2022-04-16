"
I am a fixture with a small and simple example for linear regression.
I provide input matrix X and expected output vector y.
"
Class {
	#name : #AILinearRegressionFixture,
	#superclass : #Object,
	#category : #'AI-LinearModels-Tests'
}

{ #category : #accessing }
AILinearRegressionFixture >> bias [

	^ 5
	
]

{ #category : #'as yet unclassified' }
AILinearRegressionFixture >> inputMatrix [

	^ #( #( 2 ) #( 3 ) #( 1 ) #( 5 ) #( 2 ) #( 6 ) )
]

{ #category : #'as yet unclassified' }
AILinearRegressionFixture >> outputVector [

	| function |
	function := [ :x | (self weights at: 1) * x + self bias ].
	
	^ self inputMatrix collect: [ :x | function value: x first ]
]

{ #category : #accessing }
AILinearRegressionFixture >> weights [

	^ #( 2 )
	
]
