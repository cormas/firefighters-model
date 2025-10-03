"
Plot of the landscape
"
Class {
	#name : 'FMPlot',
	#superclass : 'CMCell',
	#traits : 'TCMCellularAutomaton',
	#classTraits : 'TCMCellularAutomaton classTrait',
	#category : 'Firefighters-Model',
	#package : 'Firefighters-Model'
}

{ #category : 'accessing' }
FMPlot >> beEmpty [

	state := #empty
]

{ #category : 'accessing' }
FMPlot >> beFire [
	state := #fire.
]

{ #category : 'accessing' }
FMPlot >> beForest [ 
	state := #forest.
]

{ #category : 'initialization' }
FMPlot >> initialize [

	super initialize.
	self beEmpty.
	bufferState := #empty
]

{ #category : 'testing' }
FMPlot >> isEmpty [

	^ state = #empty
]

{ #category : 'testing' }
FMPlot >> isFire [

	^ state = #fire 
]

{ #category : 'testing' }
FMPlot >> isForest [

 
	^ state = #forest
]

{ #category : 'control' }
FMPlot >> newState [
	"c'est la fonction de transition :
si je suis en foret et qu'il y a un feu autour de moi, alors je deviendrai en feu (bufferState). Sinon, je ne change pas d'état"

	self isForest
		ifFalse: [ bufferState := state ]
		ifTrue: [
			(self neighbourhood noneSatisfy: #isFire)
				ifFalse: [ bufferState := #fire ]
				ifTrue: [ bufferState := state ] ]
]

{ #category : 'pov' }
FMPlot >> pov [

	<pov>
	| aColor |
	aColor := Color black.
	self isForest ifTrue: [ aColor := CMColor green ].
	self isFire ifTrue: [ aColor := CMColor red ].
	self isEmpty ifTrue: [ aColor := Color paleTan ].
	^ CMPointOfView color: aColor
]
