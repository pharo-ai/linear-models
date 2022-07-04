Extension { #name : #SequenceableCollection }

{ #category : #'*AI-LinearModels' }
SequenceableCollection >> averageForMatrix [

	"This is the same as doing `aMAtrix average`.
	But written this way is faster"

	| average |
	average := Array new: self first size.
	1 to: self first size do: [ :i | 
		| averageOfAVector |
		averageOfAVector := ((self sum: [ :e | e at: i ]) / self size) asFloat.
		average at: i put: averageOfAVector ].

	^ average
]

{ #category : #'*AI-LinearModels' }
SequenceableCollection >> averageForVector [

	| sum |
	sum := 0.
	1 to: self size do: [ :i | sum := sum + (self at: i) ].
	^ (sum / self size) asFloat
]
