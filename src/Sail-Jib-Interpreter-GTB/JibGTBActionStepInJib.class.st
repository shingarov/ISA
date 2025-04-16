Class {
	#name : #JibGTBActionStepInJib,
	#superclass : #GTBDebuggerAction,
	#category : #'Sail-Jib-Interpreter-GTB'
}

{ #category : #accessing }
JibGTBActionStepInJib class >> actionFor: aDebugger [
	<gtDebuggingAction>

	^ self forDebugger: aDebugger
]

{ #category : #accessing }
JibGTBActionStepInJib class >> actionType [
	<debuggingAction>
	<contextMenuDebuggingAction>
]

{ #category : #accessing }
JibGTBActionStepInJib >> defaultLabel [

	^ 'Into Jib'
]

{ #category : #actions }
JibGTBActionStepInJib >> executeAction [
	self debugger debug: self interruptedContext using: JibFromGTBDebugger

]
