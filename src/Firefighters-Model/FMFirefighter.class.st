"
My Fireman agent
"
Class {
	#name : 'FMFirefighter',
	#superclass : 'CMAgent',
	#instVars : [
		'perceptionRange'
	],
	#classInstVars : [
		'perceptionRange'
	],
	#category : 'Firefighters-Model',
	#package : 'Firefighters-Model'
}

{ #category : 'class initialization' }
FMFirefighter class >> initializeParameters [ 
	super initializeParameters.

	perceptionRange := 1
]

{ #category : 'accessing' }
FMFirefighter class >> perceptionRange [

	^ perceptionRange
]

{ #category : 'accessing' }
FMFirefighter class >> perceptionRange: aPositiveInteger [

	perceptionRange := aPositiveInteger
]

{ #category : 'control' }
FMFirefighter >> extinguish [

	self cell isFire ifTrue: [ self cell beEmpty ].
]

{ #category : 'initialization' }
FMFirefighter >> initialize [

	super initialize.
	self class perceptionRange: 1.
]

{ #category : 'control' }
FMFirefighter >> patrol [

	| neighboursOnFire destination visiblePatchs |
	self cell isFire ifTrue: [ ^ self ].
	visiblePatchs := (self locationsWithinRadius: self class perceptionRange).
	neighboursOnFire := visiblePatchs select: #isFire.
	neighboursOnFire
		ifEmpty: [ "self randomWalk"
			destination := self selectRandomlyFrom: visiblePatchs ]
		ifNotEmpty: [
		destination := self selectRandomlyFrom: neighboursOnFire ].
	self moveTo: destination
]

{ #category : 'pov' }
FMFirefighter >> pov [

	<pov>
	^ CMPointOfView
		shape: #star
		size: 0.8.
]

{ #category : 'control' }
FMFirefighter >> step [

	self patrol; extinguish.

]
