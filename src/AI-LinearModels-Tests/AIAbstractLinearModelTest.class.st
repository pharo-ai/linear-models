Class {
	#name : 'AIAbstractLinearModelTest',
	#superclass : 'TestCase',
	#instVars : [
		'model'
	],
	#category : 'AI-LinearModels-Tests',
	#package : 'AI-LinearModels-Tests'
}

{ #category : 'testing' }
AIAbstractLinearModelTest class >> isAbstract [ 
^self == AIAbstractLinearModelTest 
]

{ #category : 'running' }
AIAbstractLinearModelTest >> regression [

	^ self subclassResponsibility
]

{ #category : 'running' }
AIAbstractLinearModelTest >> setUp [

	super setUp.
	model := self regression
]

{ #category : 'tests' }
AIAbstractLinearModelTest >> testDivergingException [
	^ self subclassResponsibility
]

{ #category : 'tests' }
AIAbstractLinearModelTest >> testExactFitSingleVariable [
	^ self subclassResponsibility
]

{ #category : 'tests' }
AIAbstractLinearModelTest >> testInconsistentFitOnDimension [

	| input output |
	input := #( #( 2 ) #( 3 ) ).
	output := #( #( 1 ) ).

	self should: [ model fitX: input y: output ] raise: Error
]

{ #category : 'tests' }
AIAbstractLinearModelTest >> testInitializeWeightsToZeroOfSize [

	| expectedInitWeigths |
	expectedInitWeigths := #(0 0 0).
	model initializeWeightsToZeroOfSize: 3.
	
	self assert: model weights equals: expectedInitWeigths   
]

{ #category : 'tests' }
AIAbstractLinearModelTest >> testPerformedIterationsIsInitialized [

	self assert: model performedIterations equals: nil
]

{ #category : 'tests' }
AIAbstractLinearModelTest >> testPredictionWithNonFittedModel [

	| input output |
	input := #( #( 2 ) #( 3 ) #( 1 ) ).

	self should: [ output := model predict: input ] raise: Error
]

{ #category : 'tests' }
AIAbstractLinearModelTest >> testWeightedSumOf [

	model bias: 2.
	model weights: #(4 5 6).
	self
		assertCollection: (model weightedSumOf: #( (1 2 3) (4 5 6) (7 8 9) ))
		hasSameElements: #( 34 79 124 )
]
