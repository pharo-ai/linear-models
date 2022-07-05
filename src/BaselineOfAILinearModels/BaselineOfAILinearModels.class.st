"
I am the baseline
"
Class {
	#name : #BaselineOfAILinearModels,
	#superclass : #BaselineOf,
	#category : #BaselineOfAILinearModels
}

{ #category : #baselines }
BaselineOfAILinearModels >> baseline: spec [
	<baseline>
	spec for: #common do: [
		"External dependencies"
		spec
			baseline: 'AILinearAlgebra'
			with: [ spec repository: 'github://pharo-ai/linear-algebra/src' ].
			
		spec
			baseline: 'PolyMath'
			with: [ spec repository: 'github://jordanmontt/PolyMath:least-squares/src' ].
		
		"Packages"
		spec 
			package: 'AI-LinearModels' with: [ spec requires: #('AILinearAlgebra') ];
			package: 'AI-LinearModels-Tests' with: [ spec requires: #('AI-LinearModels') ] ].
]
