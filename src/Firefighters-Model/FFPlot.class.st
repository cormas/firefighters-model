"
Plot of the landscape
"
Class {
	#name : 'FFPlot',
	#superclass : 'CMCell',
	#traits : 'TCMCellularAutomaton',
	#classTraits : 'TCMCellularAutomaton classTrait',
	#category : 'Firefighters-Model',
	#package : 'Firefighters-Model'
}

{ #category : 'accessing' }
FFPlot >> beEmpty [

	state := #empty
]

{ #category : 'accessing' }
FFPlot >> beFire [
	state := #fire.
]

{ #category : 'accessing' }
FFPlot >> beForest [ 
	state := #forest.
]

{ #category : 'initialization' }
FFPlot >> initialize [

	super initialize.
	self beEmpty.
	bufferState := #empty
]

{ #category : 'testing' }
FFPlot >> isEmpty [

	^ state = #empty
]

{ #category : 'testing' }
FFPlot >> isFire [

	^ state = #fire 
]

{ #category : 'testing' }
FFPlot >> isForest [

 
	^ state = #forest
]

{ #category : 'control' }
FFPlot >> newState [
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
FFPlot >> pov [

	<pov>
	| aColor |
	aColor := Color black.
	self isForest ifTrue: [ aColor := Color green ].
	self isFire ifTrue: [ aColor := Color red ].
	self isEmpty ifTrue: [ aColor := Color paleTan ].
	^ CMPointOfView color: aColor
]
