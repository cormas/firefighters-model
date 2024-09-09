"
Main class (Scheduler) of the Firemen Model.
"
Class {
	#name : 'FMFiremenModel',
	#superclass : 'CMAbstractModel',
	#instVars : [
		'plots',
		'firemen'
	],
	#classInstVars : [
		'forestRatio'
	],
	#category : 'FireFighters-Model',
	#package : 'FireFighters-Model'
}

{ #category : 'accessing' }
FMFiremenModel class >> forestRatio [

	^ forestRatio
]

{ #category : 'accessing' }
FMFiremenModel class >> forestRatio: anObject [

	forestRatio := anObject
]

{ #category : 'accessing' }
FMFiremenModel class >> initializeParameters [ 

	super initializeCellClass.
	forestRatio := 0.5
]

{ #category : 'init' }
FMFiremenModel >> basicCreation [

	<init>
	self basicLandscape.
	"self createN: 10 randomlyLocatedEntities: FMFireman."
	self createN: 10 randomlyLocatedEntities: FMFireman constrainedBy: #isForest
]

{ #category : 'init' }
FMFiremenModel >> basicCreationFullForest [

	<init>
	|  firePlot |
	self
		createGridNumberOfRows: 30
		numberOfColumns: 30
		neighbourhood: 8
		closed: true.
	plots do: #beForest.
	firePlot := self selectRandomlyFrom: plots.
	firePlot beFire
]

{ #category : 'init' }
FMFiremenModel >> basicLandscape [

	<init>
	| forestPlots firePlot |
	self
		createGridNumberOfRows: 30
		numberOfColumns: 30
		neighbourhood: 8
		closed: true.
	forestPlots := self
		               selectRandomlyFrom: plots
		               size: (plots size * self class forestRatio) rounded.
	forestPlots do: #beForest.
	firePlot := self selectRandomlyFrom: forestPlots.
	firePlot beFire
]

{ #category : 'control' }
FMFiremenModel >> basicStep [

	<control>
	plots do: #newState.
	plots do: #updateState.
	firemen do: #step
	
]

{ #category : 'accessing' }
FMFiremenModel >> firemen [

	<getterFor: #FMFireman >
	^ firemen
]

{ #category : 'init' }
FMFiremenModel >> initialize [

	super initialize.
	firemen := OrderedCollection new.
	plots := OrderedCollection new
]

{ #category : 'probes' }
FMFiremenModel >> numberOfEmptyPlots [

	<probeNamed: 'Number of empty plots' color: 'EBE0C7'>
	^ (plots select: #isEmpty) size
]

{ #category : 'probes' }
FMFiremenModel >> numberOfExtinguishedPlots [

	<probeNamed: 'Number of extinguished plots' color: '808080'>
	^ (plots select: #isEmpty) size - 450
]

{ #category : 'probes' }
FMFiremenModel >> numberOfForestedPlots [

	<probeNamed: 'Number of forested plots' color: '00FF00'>
	^ (plots select: #isForest) size
]

{ #category : 'probes' }
FMFiremenModel >> numberOfPlotsOnFire [

	<probeNamed: 'Number of plots on fire' color: 'FF0000'>
	"Color red asHexString." 
	^ (plots select: #isFire) size
]

{ #category : 'accessing' }
FMFiremenModel >> plots [

	<getterFor: #FMPlot>
	^ plots
]
