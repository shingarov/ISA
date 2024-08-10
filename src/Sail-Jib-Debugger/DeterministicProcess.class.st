Class {
	#name : #DeterministicProcess,
	#superclass : #Object,
	#category : #'Sail-Jib-Debugger'
}

{ #category : #'as yet unclassified' }
DeterministicProcess >> newDebugSessionNamed: aString startedAt: aContext [ 
	^JibDebugSession
		named: aString
		on: self
		startedAt: aContext
]
