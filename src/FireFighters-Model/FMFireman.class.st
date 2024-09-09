"
My Fireman agent
"
Class {
	#name : 'FMFireman',
	#superclass : 'CMAgent',
	#traits : 'TCMLocated',
	#classTraits : 'TCMLocated classTrait',
	#instVars : [
		'perceptionRange'
	],
	#classInstVars : [
		'perceptionRange'
	],
	#category : 'FireFighters-Model',
	#package : 'FireFighters-Model'
}

{ #category : 'class initialization' }
FMFireman class >> initializeParameters [ 
	super initializeParameters.

	perceptionRange := 1
]

{ #category : 'accessing' }
FMFireman class >> perceptionRange [

	^ perceptionRange
]

{ #category : 'accessing' }
FMFireman class >> perceptionRange: aPositiveInteger [

	perceptionRange := aPositiveInteger
]

{ #category : 'control' }
FMFireman >> extinguish [

	self patch isFire ifTrue: [ self patch beEmpty ].
]

{ #category : 'initialization' }
FMFireman >> initialize [

	super initialize.
	self class perceptionRange: 1.
]

{ #category : 'control' }
FMFireman >> patrol [

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
FMFireman >> step [

	self patrol; extinguish.

]
