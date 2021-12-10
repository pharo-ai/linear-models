"
Logistic regression is used to model the probability of a certain class or event existing such as pass/fail, win/lose, alive/dead or healthy/sick. This can be extended to model several classes of events such as determining whether an image contains a cat, dog, lion, etc. Each object being detected in the image would be assigned a probability between 0 and 1, with a sum of one. (Wikipedia).

We use the sigmoid function to put the prediction values between 1 and 0
h(z) = sigmoid( z ) = 1 / ( 1 + e( - z ) )

z function is the weighted input
z = xw + bias

The cost function is
J = - ylog( h(z) ) - ( 1 - y )log( 1 - h(z) )

So, we need to minimize the error of the cost function. To do that, we derive the cost function according to the weights and the bias.

See more information in the comments of the methods.
"
Class {
	#name : #AILogisticRegression,
	#superclass : #AIAbstractRegression,
	#category : #'AI-Regressions-Logistic regression'
}

{ #category : #running }
AILogisticRegression >> activationFor: inputMatrix [

	"Activation function for logistic regression is the logistic function
	which is a kind of sigmoid function"

	"Sigmoid function: 1 / (1 + e ^ -z)
	z = X*w + bias 
	where X is the input matrix"

	| weightedSumVector |
	weightedSumVector := self weightedSumOf: inputMatrix.

	^ weightedSumVector collect: [ :z | 
		1 / (1 + (Float e raisedTo: z negated)) ]
]

{ #category : #running }
AILogisticRegression >> biasDerivative: costDerivativeVector [

	"J(w) = cost function"
	"J = - ylog( h(x) ) - ( 1 - y )log( 1 - h(x) )"
	"dJ/db = (dJ/dh)*(dh/dz)*(dz/db)"
	"dz/db = 1"
	"dJ/db = 1*dJ/dz "
	"dJ/db = h(z) - y"
	
	^ costDerivativeVector average
]

{ #category : #running }
AILogisticRegression >> costDerivative: predictedOutputVector target: targetOutputVector [

	"h(z) = sigmoid function (see method comment)"
	"z = Xw + bias (see method comment)"

	"J(w) = cost function"
	"J = - ylog( h(z) ) - ( 1 - y )log( 1 - h(z) )"
	"dJ/dz = (dJ/dh)*(dh/dz)"
	"dJ/dz = h(z) - y"
	
	"We will return a vector so the methods weights and bias derivative must sum the elements
	of the vector"

	^ predictedOutputVector - targetOutputVector
]

{ #category : #api }
AILogisticRegression >> predict: inputMatrix [

	| prediction |
	prediction := self weightedSumOf: inputMatrix.

	^ prediction collect: [ :each | 
		each > 0.5
			ifTrue: [ 1 ]
			ifFalse: [ 0 ] ]
]

{ #category : #running }
AILogisticRegression >> weightDerivativeforX: inputMatrix costDerivative: costDerivativeVector [

	"J(w) = cost function"
	"J = - ylog( h(x) ) - ( 1 - y )log( 1 - h(x) )"
	"dJ/dw = (dJ/dh)*(dh/dz)*(dz/dw)"
	"dJ/dw = X*(dJ/dz)"
	"dJ/dw = X( h(z) - y )"

	| weightDerivative |
	weightDerivative := (1 to: inputMatrix size) sum: [ :index | 
		(inputMatrix at: index) * (costDerivativeVector at: index) ].

	^ weightDerivative / inputMatrix size
]
