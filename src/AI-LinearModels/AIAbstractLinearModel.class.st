"
I am the abstract class for linear models. I represent a model that is described with a line equation

y = W*X + b

where both W and X are vectors that can have any size (multidimensional lines).
"
Class {
	#name : 'AIAbstractLinearModel',
	#superclass : 'Object',
	#instVars : [
		'bias',
		'maxIterations',
		'learningRate',
		'weights',
		'costHistory',
		'performedIterations'
	],
	#category : 'AI-LinearModels-Core',
	#package : 'AI-LinearModels',
	#tag : 'Core'
}

{ #category : 'accessing' }
AIAbstractLinearModel class >> defaultLearningRate [

	^ 0.01
]

{ #category : 'accessing' }
AIAbstractLinearModel class >> defaultMaxIterations [

	^ 5000
]

{ #category : 'instance creation' }
AIAbstractLinearModel class >> learningRate: aNumber [

	^ self new learningRate: aNumber
]

{ #category : 'instance creation' }
AIAbstractLinearModel class >> learningRate: aNumber maxIterations: maxIterations [

	^ self new
		learningRate: aNumber;
		maxIterations: maxIterations
]

{ #category : 'accessing' }
AIAbstractLinearModel >> bias [

	^ bias
]

{ #category : 'accessing' }
AIAbstractLinearModel >> bias: anInteger [ 
	bias := anInteger
]

{ #category : 'running' }
AIAbstractLinearModel >> biasDerivative: arg1 [ 
	^ self subclassResponsibility
]

{ #category : 'running' }
AIAbstractLinearModel >> costDerivative: inputMatrix actual: actualValues [

	^ self subclassResponsibility
]

{ #category : 'running' }
AIAbstractLinearModel >> costFunctionX: inputMatrix y: actualValues [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
AIAbstractLinearModel >> costHistory [

	^ costHistory
]

{ #category : 'api' }
AIAbstractLinearModel >> fitX: inputMatrix y: actualValues [

	
	self initializeWeightsOfSize: (inputMatrix anyOne size).
	
	costHistory := OrderedCollection new.
	costHistory add: (self costFunctionX: inputMatrix y: actualValues).
	
	performedIterations := 0.
	
	[ self hasConverged or: [ performedIterations >= maxIterations ] ] whileFalse: [ 
		self updateWeightsForX: inputMatrix y: actualValues.
		costHistory add: (self costFunctionX: inputMatrix y: actualValues).
		performedIterations := performedIterations + 1 ].

]

{ #category : 'testing' }
AIAbstractLinearModel >> hasConverged [

	| precision difference |
	costHistory ifNil: [ ^ false ].
	costHistory size < 2 ifTrue: [ ^ false ].

	precision := 1e-10.
	difference := costHistory last - costHistory nextToLast.

	"If the error, calculated by the cost function, is increasing that means the model is starting to diverge"
	(difference > 0 or: [difference isNaN])
		ifTrue: [ ModelStartingToDivergeException signal ].

	^ (costHistory last closeTo: 0 precision: precision) or: [ 
		  difference closeTo: 0 precision: precision ]
]

{ #category : 'running' }
AIAbstractLinearModel >> hypothesisFunction: inputMatrix [ 
	^ self subclassResponsibility
]

{ #category : 'initialization' }
AIAbstractLinearModel >> initialize [

	super initialize.
	learningRate := self class defaultLearningRate.
	maxIterations := self class defaultMaxIterations
]

{ #category : 'initialization' }
AIAbstractLinearModel >> initializeRandomWeightsOfSize: aNumber [

	| rand |
	rand := Random new.
	
	bias := rand next.
	weights := (1 to: aNumber) collect: [ :i | rand next ].
]

{ #category : 'initialization' }
AIAbstractLinearModel >> initializeWeightsOfSize: aNumber [

	self initializeRandomWeightsOfSize: aNumber
]

{ #category : 'initialization' }
AIAbstractLinearModel >> initializeWeightsToZeroOfSize: aNumber [

	bias := 0.
	weights := (1 to: aNumber) collect: [ :each | 0 ]
]

{ #category : 'accessing' }
AIAbstractLinearModel >> learningRate [

	^ learningRate
]

{ #category : 'accessing' }
AIAbstractLinearModel >> learningRate: anObject [

	learningRate := anObject
]

{ #category : 'accessing' }
AIAbstractLinearModel >> maxIterations [

	^ maxIterations
]

{ #category : 'accessing' }
AIAbstractLinearModel >> maxIterations: anObject [

	maxIterations := anObject
]

{ #category : 'accessing' }
AIAbstractLinearModel >> performedIterations [

	^ performedIterations
]

{ #category : 'api' }
AIAbstractLinearModel >> predict: inputMatrix [

	^ self subclassResponsibility
]

{ #category : 'running' }
AIAbstractLinearModel >> updateWeightsForX: inputMatrix y: actualValues [

	| weightDerivative biasDerivative predictedOutputVector costDerivative |

	predictedOutputVector := self hypothesisFunction: inputMatrix.

	costDerivative := self costDerivative: predictedOutputVector actual: actualValues.
	weightDerivative := self weightDerivativeforX: inputMatrix costDerivative: costDerivative.

	biasDerivative := self biasDerivative: costDerivative.

	weights := weights - (learningRate * weightDerivative).
	bias := bias - (learningRate * biasDerivative)
]

{ #category : 'running' }
AIAbstractLinearModel >> weightDerivativeforX: arg1 costDerivative: arg2 [ 
	^ self subclassResponsibility
]

{ #category : 'running' }
AIAbstractLinearModel >> weightedSumOf: inputMatrix [

	"z = Xw + b"
	"As X is a matrix we need to multiplicate each of the rows, the rows are the data, with the weights.
	Each of the rows has n size. n being the number of features.
	After the multiplication of a row with all the weights, we need to sum all the elements and add the bias.
	Then we return a vector of the same size of the original inputMatrix."

	^ inputMatrix collect: [:row |
		(row * weights) sum + bias ]
]

{ #category : 'accessing' }
AIAbstractLinearModel >> weights [

	^ weights
]

{ #category : 'accessing' }
AIAbstractLinearModel >> weights: aCollection [ 
	weights := aCollection
]
