Class {
	#name : #JibFromGTBDebuggerSession,
	#superclass : #JibDebuggerSession,
	#category : #'Sail-Jib-Interpreter-GTB'
}

{ #category : #'debugging actions' }
JibFromGTBDebuggerSession >> clear [
	self shouldBeImplemented
]

{ #category : #accessing }
JibFromGTBDebuggerSession >> gdb [
	^ interpreter gdb
]

{ #category : #initialization }
JibFromGTBDebuggerSession >> initializeWithInterpreter: aJibInterpreter [
	self assert: (aJibInterpreter isKindOf: JibFromGDBInterpreter).

	super initializeWithInterpreter: aJibInterpreter
]

{ #category : #'debugging actions' }
JibFromGTBDebuggerSession >> terminate [
	interpreter writeRegisters
]

{ #category : #'debugging actions' }
JibFromGTBDebuggerSession >> writeRegisters [
	interpreter writeRegisters.
]
