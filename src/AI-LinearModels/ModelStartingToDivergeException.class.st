"
I am a custom exception that is signaled when the model is starting to diverge (the weights start to grow up to infinity)
"
Class {
	#name : #ModelStartingToDivergeException,
	#superclass : #Exception,
	#category : #'AI-LinearModels-Exception'
}

{ #category : #signaling }
ModelStartingToDivergeException >> signal [

	self messageText:
		'The model is starting to diverge. Try setting up a smaller learning rate or normalizing your data.'.
	^ super signal
]
