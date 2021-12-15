"
I am the abstract class for linear and logistic regression (for now) and I have the general methods for the regression
"
Class {
	#name : #AIAbstractRegression,
	#superclass : #Object,
	#instVars : [
		'bias',
		'maxIterations',
		'learningRate',
		'normalizer',
		'shouldNormalizeData',
		'weights',
		'costHistory',
		'performedIterations'
	],
	#category : #'AI-Regressions-Core'
}

{ #category : #'as yet unclassified' }
AIAbstractRegression class >> defaultLearningRate [

	^ 0.01
]

{ #category : #'as yet unclassified' }
AIAbstractRegression class >> defaultMaxIterations [

	^ 5000
]

{ #category : #accessing }
AIAbstractRegression class >> defaultNormalizerClass [

	^ AIMinMaxNormalizer
]

{ #category : #accessing }
AIAbstractRegression >> bias [

	^ bias
]

{ #category : #running }
AIAbstractRegression >> biasDerivative: arg1 [ 
	^ self subclassResponsibility
]

{ #category : #running }
AIAbstractRegression >> costDerivative: arg1 target: arg2 [ 
	^ self subclassResponsibility
]

{ #category : #running }
AIAbstractRegression >> costFunctionX: inputMatrix y: actualValues [

	^ self subclassResponsibility
]

{ #category : #accessing }
AIAbstractRegression >> costHistory [

	^ costHistory
]

{ #category : #api }
AIAbstractRegression >> fitX: inputMatrix y: actualValues [

	
	self initializeWeightsOfSize: (inputMatrix anyOne size).
	
	costHistory := OrderedCollection new.
	costHistory add: (self costFunctionX: inputMatrix y: actualValues).
	
	performedIterations := 0.
	
	[ self hasConverged or: [ performedIterations >= maxIterations ] ] whileFalse: [ 
		self updateX: inputMatrix y: actualValues.
		costHistory add: (self costFunctionX: inputMatrix y: actualValues).
		performedIterations := performedIterations + 1 ].

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

{ #category : #running }
AIAbstractRegression >> hypothesisFunction: inputMatrix [ 
	^ self subclassResponsibility
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

{ #category : #initialization }
AIAbstractRegression >> initializeWeightsToZeroOfSize: aNumber [

	bias := 0.
	weights := (1 to: aNumber) collect: [ :each | 0 ]
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

{ #category : #accessing }
AIAbstractRegression >> performedIterations [

	^ performedIterations
]

{ #category : #api }
AIAbstractRegression >> predict: inputMatrix [

	^ self subclassResponsibility
]

{ #category : #accessing }
AIAbstractRegression >> shouldNormalizeData: aBoolean [

	shouldNormalizeData := aBoolean
]

{ #category : #running }
AIAbstractRegression >> updateX: inputMatrix y: actualValues [

	| weightDerivative biasDerivative predictedOutputVector costDerivative |

	predictedOutputVector := self hypothesisFunction: inputMatrix.

	costDerivative := self costDerivative: predictedOutputVector target: actualValues.
	weightDerivative := self weightDerivativeforX: inputMatrix costDerivative: costDerivative.

	biasDerivative := self biasDerivative: costDerivative.

	weights := weights - (learningRate * weightDerivative).
	bias := bias - (learningRate * biasDerivative)
]

{ #category : #running }
AIAbstractRegression >> weightDerivativeforX: arg1 costDerivative: arg2 [ 
	^ self subclassResponsibility
]

{ #category : #running }
AIAbstractRegression >> weightedSumOf: inputMatrix [

	"z = Xw + b"
	"As X is a matrix we need to multiplicate each of the rows, the rows are the data, with the weights.
	Each of the rows has n size. n being the number of features.
	After the multiplication of a row with all the weights, we need to sum all the elements and add the bias.
	Then we return a vector of the same size of the original inputMatrix."

	^ inputMatrix collect: [:row |
		(row * weights) sum + bias ]
]

{ #category : #accessing }
AIAbstractRegression >> weights [

	^ weights
]
