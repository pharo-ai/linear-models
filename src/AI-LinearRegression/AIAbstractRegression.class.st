"
I am the abstract class for linear and logistic regression (for now) and I have the general methods for the regression
"
Class {
	#name : #AIAbstractRegression,
	#superclass : #Object,
	#instVars : [
		'bias',
		'costHistory',
		'maxIterations',
		'learningRate',
		'normalizer',
		'shouldNormalizeData',
		'weights'
	],
	#category : #'AI-LinearRegression'
}

{ #category : #accessing }
AIAbstractRegression >> bias [

	^ bias
]

{ #category : #accessing }
AIAbstractRegression >> costHistory [

	^ costHistory
]

{ #category : #running }
AIAbstractRegression >> costX: inputMatrix y: targetVector [

	| outputVector |
	outputVector := self predict: inputMatrix.
	
	^ (targetVector - outputVector) sum: [ :each | each ** 2 ].
]

{ #category : #api }
AIAbstractRegression >> fitX: inputMatrix y: targetVector [

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
AIAbstractRegression >> hasConverged [

	| precision |
	
	costHistory ifNil: [ ^ false ].
	costHistory size < 2 ifTrue: [ ^ false ].
	
	precision := 1e-10.
	
	^ (costHistory last closeTo: 0 precision: precision) or: [
		costHistory nextToLast closeTo: costHistory last precision: precision ]
]

{ #category : #initialization }
AIAbstractRegression >> initialize [

	super initialize.
	learningRate := self class defaultLearningRate.
	maxIterations := self class defaultMaxIterations.
	
	shouldNormalizeData := true.
	normalizer := self class defaultNormalizerClass new.
]

{ #category : #initialization }
AIAbstractRegression >> initializeRandomWeightsOfSize: aNumber [

	| rand |
	rand := Random new.
	
	bias := rand next.
	weights := (1 to: aNumber) collect: [ :i | rand next ].
]

{ #category : #initialization }
AIAbstractRegression >> initializeWeightsOfSize: aNumber [

	self initializeRandomWeightsOfSize: aNumber
]

{ #category : #accessing }
AIAbstractRegression >> learningRate [

	^ learningRate
]

{ #category : #accessing }
AIAbstractRegression >> learningRate: anObject [

	learningRate := anObject
]

{ #category : #accessing }
AIAbstractRegression >> maxIterations [

	^ maxIterations
]

{ #category : #accessing }
AIAbstractRegression >> maxIterations: anObject [

	maxIterations := anObject
]

{ #category : #accessing }
AIAbstractRegression >> normalizer: aNormalizer [

	normalizer := aNormalizer.
]

{ #category : #running }
AIAbstractRegression >> predict: inputMatrix [

	^ self subclassResponsibility
]

{ #category : #api }
AIAbstractRegression >> updateX: inputMatrix y: targetVector [

	self subclassResponsibility
]

{ #category : #accessing }
AIAbstractRegression >> weights [

	^ weights
]
