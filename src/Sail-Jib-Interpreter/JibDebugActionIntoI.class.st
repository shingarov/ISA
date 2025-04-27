Class {
	#name : #JibDebugActionIntoI,
	#superclass : #JibDebugAction,
	#category : #'Sail-Jib-Interpreter-Debugger-Actions'
}

{ #category : #accessing }
JibDebugActionIntoI class >> actionFor: aGTBDebugger [
	<gtStackDebuggingAction>
	
	<gtContextStackDebuggingAction>
	<gtContextInstructionDebuggingAction>

	^self forDebugger: aGTBDebugger 
]

{ #category : #accessing }
JibDebugActionIntoI >> defaultIcon [

	^ GLMUIThemeExtraIcons glamorousInto
]

{ #category : #accessing }
JibDebugActionIntoI >> defaultLabel [
	^ 'Into instruction'
]

{ #category : #accessing }
JibDebugActionIntoI >> defaultOrder [

	^ 35
]

{ #category : #actions }
JibDebugActionIntoI >> executeAction [
	self session stepIntoI: self selectedContext
]
