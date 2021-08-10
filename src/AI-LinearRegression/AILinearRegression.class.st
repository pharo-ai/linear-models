Class {
	#name : #AILinearRegression,
	#superclass : #Object,
	#instVars : [
		'weights',
		'bias',
		'costHistory',
		'learningRate',
		'maxIterations',
		'normalizer',
		'shouldNormalizeData'
	],
	#category : #'AI-LinearRegression'
}

{ #category : #'as yet unclassified' }
AILinearRegression class >> defaultLearningRate [

	^ 0.01
]

{ #category : #'as yet unclassified' }
AILinearRegression class >> defaultMaxIterations [

	^ 1000
]

{ #category : #accessing }
AILinearRegression class >> defaultNormalizerClass [

	^ AIMinMaxNormalizer
]

{ #category : #accessing }
AILinearRegression >> bias [

	^ bias
]

{ #category : #accessing }
AILinearRegression >> costHistory [

	^ costHistory
]

{ #category : #'as yet unclassified' }
AILinearRegression >> costX: inputMatrix y: targetVector [

	| outputVector |
	outputVector := self predict: inputMatrix.
	
	^ (targetVector - outputVector) sum: [ :each | each ** 2 ].
]

{ #category : #'as yet unclassified' }
AILinearRegression >> fitX: inputMatrix y: targetVector [

	| iteration |
	
	self initializeWeightsOfSize: (inputMatrix anyOne size).
	
	costHistory := OrderedCollection new.
	costHistory add: (self costX: inputMatrix y: targetVector).
	
	iteration := 1.
	
	[ self hasConverged or: [ iteration >= maxIterations ] ] whileFalse: [ 
		self updateX: inputMatrix y: targetVector.
		costHistory add: (self costX: inputMatrix y: targetVector).
		iteration := iteration + 1 ].

]

{ #category : #testing }
AILinearRegression >> hasConverged [

	| precision |
	
	costHistory ifNil: [ ^ false ].
	costHistory size < 2 ifTrue: [ ^ false ].
	
	precision := 1e-10.
	
	^ (costHistory last closeTo: 0 precision: precision) or: [
		costHistory nextToLast closeTo: costHistory last precision: precision ]
]

{ #category : #initialization }
AILinearRegression >> initialize [
	super initialize.
	learningRate := self class defaultLearningRate.
	maxIterations := self class defaultMaxIterations.
	
	shouldNormalizeData := true.
	normalizer := self class defaultNormalizerClass new.
]

{ #category : #initialization }
AILinearRegression >> initializeWeightsOfSize: aNumber [

	| rand |
	rand := Random new.
	
	bias := rand next.
	weights := (1 to: aNumber) collect: [ :i | rand next ].
]

{ #category : #accessing }
AILinearRegression >> learningRate [

	^ learningRate
]

{ #category : #accessing }
AILinearRegression >> learningRate: anObject [

	learningRate := anObject
]

{ #category : #accessing }
AILinearRegression >> maxIterations [

	^ maxIterations
]

{ #category : #accessing }
AILinearRegression >> maxIterations: anObject [

	maxIterations := anObject
]

{ #category : #accessing }
AILinearRegression >> normalizer: aNormalizer [

	normalizer := aNormalizer.
]

{ #category : #'as yet unclassified' }
AILinearRegression >> predict: inputMatrix [
	
	^ inputMatrix collect: [ :row |
		(row * weights) sum + bias ]
]

{ #category : #accessing }
AILinearRegression >> shouldNormalizeData: aBoolean [

	shouldNormalizeData := aBoolean
]

{ #category : #'as yet unclassified' }
AILinearRegression >> updateX: inputMatrix y: targetVector [

	| outputVector difference |
	
	outputVector := self predict: inputMatrix.
	difference := targetVector - outputVector.
	
	bias := bias + (2 * learningRate * difference sum).
	
	weights := weights + (2 * learningRate * ((1 to: targetVector size) sum: [ :i |
		(difference at: i) * (inputMatrix at: i) ])).
]

{ #category : #accessing }
AILinearRegression >> weights [

	^ weights
]
