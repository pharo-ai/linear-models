Class {
	#name : #BaselineOfAILinearRegression,
	#superclass : #BaselineOf,
	#category : #BaselineOfAILinearRegression
}

{ #category : #baselines }
BaselineOfAILinearRegression >> baseline: spec [
	<baseline>
	spec for: #common do: [
		"External dependencies"
		spec
			baseline: 'AINormalization'
    		with: [ spec repository: 'github://pharo-ai/normalization/src' ].
		
		"Packages"
		spec 
			package: 'AI-Regressions' with: [ spec requires: #('AINormalization') ];
			package: 'AI-Regressions-Tests' with: [ spec requires: #('AI-Regressions') ] ].
]
