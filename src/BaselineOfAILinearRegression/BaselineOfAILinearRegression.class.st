Class {
	#name : #BaselineOfAILinearRegression,
	#superclass : #BaselineOf,
	#category : #BaselineOfAILinearRegression
}

{ #category : #baselines }
BaselineOfAILinearRegression >> baseline: spec [
	<baseline>
	spec for: #common do: [
		"Packages"
		spec 
			package: 'AI-LinearRegression';
			package: 'AI-LinearRegression-Tests' with: [ spec requires: #('AI-LinearRegression') ] ].
]
