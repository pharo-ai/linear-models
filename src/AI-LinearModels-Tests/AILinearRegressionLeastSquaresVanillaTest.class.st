Class {
	#name : 'AILinearRegressionLeastSquaresVanillaTest',
	#superclass : 'AILinearRegressionLeastSquaresTest',
	#category : 'AI-LinearModels-Tests',
	#package : 'AI-LinearModels-Tests'
}

{ #category : 'running' }
AILinearRegressionLeastSquaresVanillaTest >> inputType [

	^ PMMatrix
]

{ #category : 'running' }
AILinearRegressionLeastSquaresVanillaTest >> regression [

	^ AILinearRegressionLeastSquaresVanilla new
]

{ #category : 'tests' }
AILinearRegressionLeastSquaresVanillaTest >> testExactFitDoubleVariable [
	"| newInput expectedOutput actualOutput initialInput initialOutput |
	initialInput := #( #( 2 4 ) #( 3 2 ) #( 1 2 ) #( 5 1 ) #( 2 6 ) #( 6 3 ) ).
	initialOutput := initialInput collect: [ :x | 2 + (x first * 3) + x second ].
	newInput := #( #( 4 3 ) #( 1 2 ) #( 7 3 ) #( 0 4 ) ).
	expectedOutput := #( 17 7 26 6 ).

	model fitX: (PMMatrix rows: initialInput) y: initialOutput asPMVector.
	actualOutput := model predict: newInput.

	""initialInput collect: [ :x | model bias + (x first * model weights first) + (x second * model weights second) ].""
	
	actualOutput with: expectedOutput do: [ :actual :expected | self assert: actual closeTo: expected precision: 0.001 ]"
	"should work but doesn't give the correct answer, vanilla needs to be fixes"

	self skip
]

{ #category : 'tests' }
AILinearRegressionLeastSquaresVanillaTest >> testExactFitSingleVariable [

	self skip
]
