"
My Fireman agent
"
Class {
	#name : 'FMFirefighter',
	#superclass : 'CMAgent',
	#traits : 'TCMLocated',
	#classTraits : 'TCMLocated classTrait',
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

	self patch isFire ifTrue: [ self patch beEmpty ].
]

{ #category : 'initialization' }
FMFirefighter >> initialize [

	super initialize.
	self class perceptionRange: 1.
]

{ #category : 'control' }
FMFirefighter >> patrol [

	| neighboursOnFire destination visiblePatchs |
	self patch isFire ifTrue: [ ^ self ].
	visiblePatchs := (self locationsWithinRadius: self class perceptionRange).
	neighboursOnFire := visiblePatchs select: #isFire.
	neighboursOnFire
		ifEmpty: [ "self randomWalk"
			destination := self selectRandomlyFrom: visiblePatchs ]
		ifNotEmpty: [
		destination := self selectRandomlyFrom: neighboursOnFire ].
	self moveTo: destination
]

{ #category : 'control' }
FMFirefighter >> step [

	self patrol; extinguish.

]
