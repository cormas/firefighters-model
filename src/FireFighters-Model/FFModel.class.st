Class {
	#name : #FFModel,
	#superclass : #CMAbstractModel,
	#instVars : [
		'forestRatio',
		'thePlots'
	],
	#category : #'FireFighters-Model'
}

{ #category : #accessing }
FFModel >> forestRatio [

	^ forestRatio ifNil: [ forestRatio := 0.5]
]

{ #category : #accessing }
FFModel >> forestRatio: anObject [

	forestRatio := anObject
]

{ #category : #init }
FFModel >> initLandscape [

	"30 x 30 plots with 4 neighbours, with 50% forest and 50% empty"

	| emptyPlots |
	self createGridLines: 30 columns: 30 neighbourhood: 4 closed: true.

	emptyPlots := Cormas
		              selectRandomlyFrom: self thePlots
		              subCollectionSize:
		              (self forestRatio * self thePlots size) asInteger.
	emptyPlots do: [ :aPlot | aPlot state: 'empty' ].
	self pickCell state: 'fire'
]

{ #category : #control }
FFModel >> step: t [
	self stepSynchronouslyCA: t
]

{ #category : #accessing }
FFModel >> thePlots [

	^ thePlots ifNil: [ thePlots := OrderedCollection new ]
]

{ #category : #accessing }
FFModel >> thePlots: anObject [

	thePlots := anObject
]
