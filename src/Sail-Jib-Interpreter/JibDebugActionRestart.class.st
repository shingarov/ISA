Class {
	#name : #JibDebugActionRestart,
	#superclass : #JibDebugAction,
	#category : #'Sail-Jib-Interpreter-Debugger-Actions'
}

{ #category : #accessing }
JibDebugActionRestart class >> actionFor: aJibDebugger [
	<gtStackDebuggingAction>

	<gtContextStackDebuggingAction>
	<gtContextSourceDebuggingAction>
	<gtContextInstructionDebuggingAction>

	^self forDebugger: aJibDebugger

]

{ #category : #accessing }
JibDebugActionRestart >> defaultIcon [

	^ GLMUIThemeExtraIcons glamorousRestart
]

{ #category : #accessing }
JibDebugActionRestart >> defaultLabel [
	^ 'Restart'
]

{ #category : #accessing }
JibDebugActionRestart >> defaultOrder [

	^ 6
]

{ #category : #actions }
JibDebugActionRestart >> executeAction [
	self session restart: self selectedContext


]
