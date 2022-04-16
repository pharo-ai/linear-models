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
			baseline: 'Lapack'
			with: [ spec repository: 'github://pharo-ai/lapack/src' ].
		
		"Packages"
		spec 
			package: 'AI-LinearModels' with: [ spec requires: #('Lapack') ];
			package: 'AI-LinearModels-Tests' with: [ spec requires: #('AI-LinearModels') ] ].
]
