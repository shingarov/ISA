Class {
	#name : #JibDebugSession,
	#superclass : #Object,
	#instVars : [
		'name',
		'interruptedContext',
		'interruptedProcess'
	],
	#category : #'Sail-Jib-Debugger'
}

{ #category : #'as yet unclassified' }
JibDebugSession class >> debuggingActionsForPragmas: aSymbolsCollection for: aDebugger [ 
	^OrderedCollection with: (
		StepIntoDebugAction forDebugger: aDebugger
	)
]

{ #category : #'as yet unclassified' }
JibDebugSession class >> named: aString on: aProcess startedAt: aContext [
	^self basicNew
		name: aString;
		process: aProcess context: aContext;
		yourself
]

{ #category : #accessing }
JibDebugSession >> interruptedContext [
	^ interruptedContext
]

{ #category : #accessing }
JibDebugSession >> interruptedContext: anObject [
	interruptedContext := anObject
]

{ #category : #accessing }
JibDebugSession >> interruptedProcess [
	^ interruptedProcess
]

{ #category : #accessing }
JibDebugSession >> interruptedProcess: anObject [
	interruptedProcess := anObject
]

{ #category : #accessing }
JibDebugSession >> name [
	^ name
]

{ #category : #accessing }
JibDebugSession >> name: anObject [
	name := anObject
]

{ #category : #initialization }
JibDebugSession >> process: aProcess context: aContext [
	"aProcess stepToSendOrReturn"
	"aProcess isSuspended ifTrue: [ aProcess stepToSendOrReturn ]"

	interruptedProcess := aProcess.
	interruptedContext ifNil: [ interruptedContext := aContext ]
]

{ #category : #'as yet unclassified' }
JibDebugSession >> selectedCodeRangeForContext: aContext [ 
	^nil
]

{ #category : #'as yet unclassified' }
JibDebugSession >> stack [
	^ interruptedContext stack
]

{ #category : #'as yet unclassified' }
JibDebugSession >> stepInto: aContext [ 
	self shouldBeImplemented.
]
