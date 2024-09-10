Class {
	#name : 'BaselineOfFirefightersModel',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfFirefightersModel',
	#package : 'BaselineOfFirefightersModel'
}

{ #category : 'baselines' }
BaselineOfFirefightersModel >> baseline: spec [

	<baseline>
	spec for: #common do: [

		"Packages"
		spec
			package: 'Firefighters-Model';
			package: 'Firefighters-Tests' with: [ spec requires: #( 'Firefighters-Model' ) ] ]
]
