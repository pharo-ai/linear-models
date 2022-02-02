Class {
	#name : #AIAbstractLinearModelTest,
	#superclass : #TestCase,
	#instVars : [
		'model'
	],
	#category : #'AI-LinearModels-Tests'
}

{ #category : #initialization }
AIAbstractLinearModelTest >> setUp [

	super setUp.
	model := AIAbstractLinearModel new
]

{ #category : #tests }
AIAbstractLinearModelTest >> testInconsistentLearningRate [

	"It should be better to raise the exception at the initialization of the LinearModel"

	self
		should: [ 
			model := AIAbstractLinearModel new
				         learningRate: 'learningRate';
				         maxIterations: 2000;
				         yourself ]
		raise: Error
]

{ #category : #tests }
AIAbstractLinearModelTest >> testInconsistentMaxIterations [

	"It should be better to raise the exception at the initialization of the LinearModel"

	self
		should: [ 
			model := AIAbstractLinearModel new
				         learningRate: 0.1;
				         maxIterations: 'number';
				         yourself ]
		raise: Error
]

{ #category : #tests }
AIAbstractLinearModelTest >> testPredictionWithNonFittedModel [

	| input output |
	input := #( #( 2 ) #( 3 ) #( 1 ) ).

	model := AILinearRegression new
		         learningRate: 0.01;
		         maxIterations: 3000;
		         yourself.

	self should: [ output := model predict: input ] raise: Error.

	model := AILogisticRegression new
		         learningRate: 0.01;
		         maxIterations: 3000;
		         yourself.
		
	self should: [ output := model predict: input ] raise: Error.
]
