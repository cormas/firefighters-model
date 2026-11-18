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

{ #category : 'aspects' }
FFPlot >> aspectDefault: look [

	<aspect>
	| aColor |
	aColor := Color black.
	self isForest ifTrue: [ aColor := CMColor green ].
	self isFire ifTrue: [ aColor := CMColor red ].
	self isEmpty ifTrue: [ aColor := CMColor paleTan ].
	look color: aColor
]

{ #category : 'aspects' }
FFPlot >> aspectImage: look [

	<aspect>
	| image |
	image := CMImage named: 'grass-light'.
	self isForest ifTrue: [
		image := image + ((CMImage named: 'tree') size: 0.7) ].
	self isFire ifTrue: [
		image := image + ((CMImage named: 'tree-fire') size: 0.7) ].
	look image: image
]

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
