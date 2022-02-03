Class {
	#name : #AIAbstractLinearModelTest,
	#superclass : #TestCase,
	#instVars : [
		'model'
	],
	#category : #'AI-LinearModels-Tests'
}

{ #category : #tests }
AIAbstractLinearModelTest >> testFitEmptyInputMatrix [

	"It should be better to raise the exception at the initialization of the LinearModel"

	| input output |
	input := #(  ).
	output := #( #( 1 ) ).
	model := AIAbstractLinearModel new
		         learningRate: 0.01;
		         maxIterations: 3000;
		         yourself.

	self should: [ model fitX: input y: output ] raise: Error
]

{ #category : #tests }
AIAbstractLinearModelTest >> testFitEmptyOutputValues [

	"It should be better to raise the exception at the initialization of the LinearModel"

	| input output |
	input := #( #( 5 ) #( 3 ) ).
	output := #(  ).
	model := AIAbstractLinearModel new
		         learningRate: 0.01;
		         maxIterations: 3000;
		         yourself.

	self should: [ model fitX: input y: output ] raise: Error
]

{ #category : #tests }
AIAbstractLinearModelTest >> testInconsistentFitInputOnType [

	| input output |
	input := #( #( 'number' ) #( 3 ) #( 1 ) ).
	output := #( 1 3 1 ).

	model := AIAbstractLinearModel new
		         learningRate: 0.01;
		         maxIterations: 3000;
		         yourself.

	self should: [ model fitX: input y: output ] raise: Error
]

{ #category : #tests }
AIAbstractLinearModelTest >> testInconsistentFitOnDimension [

	| input output |
	input := #( #( 2 ) #( 3 ) ).
	output := #( #( 1 ) ).

	model := AIAbstractLinearModel new
		         learningRate: 0.01;
		         maxIterations: 3000;
		         yourself.

	self should: [ model fitX: input y: output ] raise: Error
]

{ #category : #tests }
AIAbstractLinearModelTest >> testInconsistentFitOutputOnType [

	| input output |
	input := #( #( 1 ) #( 3 ) #( 1 ) ).
	output := #( 'number' 3 1 ).

	model := AIAbstractLinearModel new
		         learningRate: 0.01;
		         maxIterations: 3000;
		         yourself.

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
AIAbstractLinearModelTest >> testInconsistentPredictionInputOnType [

	| input output1 output2 newInput actualOutput |
	
	input := #( #( 2 ) #( 3 ) #( -1 ) ).
	output1 := #( 3 4 0 ).
	output2 := #( 1 1 0 ).
	newInput := #( #( 'number' ) #( 1 ) #( 7 ) ).

	model := AILinearRegression new
		         learningRate: 0.01;
		         maxIterations: 3000;
		         yourself.

	model fitX: input y: output1.

	self should: [ actualOutput := model predict: newInput ] raise: Error.
	
model := AILogisticRegression new
		         learningRate: 0.01;
		         maxIterations: 3000;
		         yourself.

	model fitX: input y: output2.

	self should: [ actualOutput := model predict: newInput ] raise: Error
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
