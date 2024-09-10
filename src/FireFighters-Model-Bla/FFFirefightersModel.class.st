"
Main class (Scheduler) of the Firemen Model.
"
Class {
	#name : 'FFFirefightersModel',
	#superclass : 'CMAbstractModel',
	#instVars : [
		'plots',
		'firemen'
	],
	#classInstVars : [
		'forestRatio'
	],
	#category : 'FireFighters-Model-Bla',
	#package : 'FireFighters-Model-Bla'
}

{ #category : 'accessing' }
FFFirefightersModel class >> forestRatio [

	^ forestRatio
]

{ #category : 'accessing' }
FFFirefightersModel class >> forestRatio: anObject [

	forestRatio := anObject
]

{ #category : 'accessing' }
FFFirefightersModel class >> initializeParameters [ 

	super initializeCellClass.
	forestRatio := 0.5
]

{ #category : 'init' }
FFFirefightersModel >> basicCreation [

	<init>
	self basicLandscape.
	"self createN: 10 randomlyLocatedEntities: FMFireman."
	self createN: 10 randomlyLocatedEntities: FMFirefighter constrainedBy: #isForest
]

{ #category : 'init' }
FFFirefightersModel >> basicCreationFullForest [

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
FFFirefightersModel >> basicLandscape [

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
FFFirefightersModel >> basicStep [

	<control>
	plots do: #newState.
	plots do: #updateState.
	firemen do: #step
	
]

{ #category : 'accessing' }
FFFirefightersModel >> firefighters [

	<getterFor: #FMFirefighter >
	^ firemen
]

{ #category : 'init' }
FFFirefightersModel >> initialize [

	super initialize.
	firemen := OrderedCollection new.
	plots := OrderedCollection new
]

{ #category : 'probes' }
FFFirefightersModel >> numberOfEmptyPlots [

	<probeNamed: 'Number of empty plots' color: 'EBE0C7'>
	^ (plots select: #isEmpty) size
]

{ #category : 'probes' }
FFFirefightersModel >> numberOfExtinguishedPlots [

	<probeNamed: 'Number of extinguished plots' color: '808080'>
	^ (plots select: #isEmpty) size - 450
]

{ #category : 'probes' }
FFFirefightersModel >> numberOfForestedPlots [

	<probeNamed: 'Number of forested plots' color: '00FF00'>
	^ (plots select: #isForest) size
]

{ #category : 'probes' }
FFFirefightersModel >> numberOfPlotsOnFire [

	<probeNamed: 'Number of plots on fire' color: 'FF0000'>
	"Color red asHexString." 
	^ (plots select: #isFire) size
]

{ #category : 'accessing' }
FFFirefightersModel >> plots [

	<getterFor: #FMPlot>
	^ plots
]
