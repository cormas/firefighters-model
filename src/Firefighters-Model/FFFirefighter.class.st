"
My Fireman agent
"
Class {
	#name : 'FFFirefighter',
	#superclass : 'CMAgent',
	#classInstVars : [
		'perceptionRange'
	],
	#category : 'Firefighters-Model',
	#package : 'Firefighters-Model'
}

{ #category : 'accessing' }
FFFirefighter class >> perceptionRange [
	<parameterIntegerDefault: 1>
	^ perceptionRange
]

{ #category : 'accessing' }
FFFirefighter class >> perceptionRange: aNumber [

	perceptionRange := aNumber
]

{ #category : 'control' }
FFFirefighter >> extinguish [

	self cell isFire ifTrue: [ self cell beEmpty ].
]

{ #category : 'control' }
FFFirefighter >> patrol [

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
FFFirefighter >> pov [

	<pov>
	^ CMPointOfView
		color: CMColor blue
		shape: #star
		size: 0.9.
]

{ #category : 'pov' }
FFFirefighter >> povImage [

	<pov>
	^ CMPointOfView
		tile: CMDefaultTileset firefighter
		size: 0.6.
]

{ #category : 'control' }
FFFirefighter >> step [

	self patrol; extinguish.

]
