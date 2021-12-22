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
		
		"Packages"
		spec 
			package: 'AI-LinearModels';
			package: 'AI-LinearModels-Tests' with: [ spec requires: #('AI-LinearModels') ] ].
]
