Class {
	#name : #AIAbstractLinearModelTest,
	#superclass : #TestCase,
	#instVars : [
		'model'
	],
	#category : #'AI-LinearModels-Tests'
}

{ #category : #testing }
AIAbstractLinearModelTest class >> isAbstract [ 
^self == AIAbstractLinearModelTest 
]

{ #category : #running }
AIAbstractLinearModelTest >> regression [
^self subclassResponsibility 
]

{ #category : #running }
AIAbstractLinearModelTest >> setUp [
	super setUp.
	
	model := self regression.
]

{ #category : #tests }
AIAbstractLinearModelTest >> testFitEmptyInputMatrix [

	"It should be better to raise the exception at the initialization of the LinearModel"

	| input output |
	input := #(  ).
	output := #( #( 1 ) ).
	
	self should: [ model fitX: input y: output ] raise: Error
]

{ #category : #tests }
AIAbstractLinearModelTest >> testFitEmptyOutputValues [

	"It should be better to raise the exception at the initialization of the LinearModel"

	| input output |
	input := #( #( 5 ) #( 3 ) ).
	output := #(  ).

	self should: [ model fitX: input y: output ] raise: Error
]

{ #category : #tests }
AIAbstractLinearModelTest >> testInconsistentFitInputOnType [

	| input output |
	input := #( #( 'number' ) #( 3 ) #( 1 ) ).
	output := #( 1 3 1 ).

	self should: [ model fitX: input y: output ] raise: Error
]

{ #category : #tests }
AIAbstractLinearModelTest >> testInconsistentFitOnDimension [

	| input output |
	input := #( #( 2 ) #( 3 ) ).
	output := #( #( 1 ) ).

	self should: [ model fitX: input y: output ] raise: Error
]

{ #category : #tests }
AIAbstractLinearModelTest >> testInconsistentFitOutputOnType [

	| input output |
	input := #( #( 1 ) #( 3 ) #( 1 ) ).
	output := #( 'number' 3 1 ).

	self should: [ model fitX: input y: output ] raise: Error
]

{ #category : #tests }
AIAbstractLinearModelTest >> testInconsistentLearningRate [

	"It should be better to raise the exception at the initialization of the LinearModel

	self
		should: [ 
			model := AIAbstractLinearModel new
				         learningRate: 'learningRate';
				         maxIterations: 2000;
				         yourself ]
		raise: Error"
		self skip.
]

{ #category : #tests }
AIAbstractLinearModelTest >> testInconsistentMaxIterations [

	"It should be better to raise the exception at the initialization of the LinearModel

	self
		should: [ 
			model := AIAbstractLinearModel new
				         learningRate: 0.1;
				         maxIterations: 'number';
				         yourself ]
		raise: Error"
		self skip
]

{ #category : #tests }
AIAbstractLinearModelTest >> testLearningRateIsInitialized [

	self
		assert: model learningRate 
		equals: model class defaultLearningRate 
]

{ #category : #tests }
AIAbstractLinearModelTest >> testMaxIterationsIsInitialized [

	self assert: model maxIterations equals: model class defaultMaxIterations 
]

{ #category : #tests }
AIAbstractLinearModelTest >> testPerformedIterationsIsInitialized [

	self assert: model performedIterations equals: nil
]

{ #category : #tests }
AIAbstractLinearModelTest >> testPredictionWithNonFittedModel [

	| input output |
	input := #( #( 2 ) #( 3 ) #( 1 ) ).

	self should: [ output := model predict: input ] raise: Error
]
