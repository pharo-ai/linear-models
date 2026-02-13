Class {
	#name : 'AILinearRegressionLeastSquaresTest',
	#superclass : 'AIAbstractLinearModelTest',
	#category : 'AI-LinearModels-Tests',
	#package : 'AI-LinearModels-Tests'
}

{ #category : 'running' }
AILinearRegressionLeastSquaresTest >> fixtureInput [

	^ self inputType rows: fixture inputMatrix 
]

{ #category : 'running' }
AILinearRegressionLeastSquaresTest >> inputType [

	^ AIColumnMajorMatrix 
]

{ #category : 'running' }
AILinearRegressionLeastSquaresTest >> regression [

	^ AILinearRegressionLeastSquares new
]

{ #category : 'tests' }
AILinearRegressionLeastSquaresTest >> testExactFitSingleVariable [

	| newInput expectedOutput actualOutput |
	newInput := #( #( 4 ) #( 1 ) #( 7 ) #( 0 ) ).
	expectedOutput := #( 11 5 17 3 ).

	model fitX: self fixtureInput y: self fixtureOutput.
	actualOutput := model predict: newInput.

	actualOutput with: expectedOutput do: [ :actual :expected | self assert: actual closeTo: expected precision: 0.001 ]
]

{ #category : 'tests' }
AILinearRegressionLeastSquaresTest >> testPredictionWithNonFittedModel [

	| input |
	input := AIColumnMajorMatrix rows: #(
		(1 2 3)
   		(2 3 4)
		(3 4 5)
	).

	self assert: (model predict: input) equals: Array new
]
