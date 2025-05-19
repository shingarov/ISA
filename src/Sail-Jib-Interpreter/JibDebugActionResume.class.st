Class {
	#name : #JibDebugActionResume,
	#superclass : #JibDebugAction,
	#category : #'Sail-Jib-Interpreter-Debugger-Actions'
}

{ #category : #accessing }
JibDebugActionResume class >> actionFor: aJibDebugger [
	<gtStackDebuggingAction>

	<gtContextStackDebuggingAction>
	<gtContextSourceDebuggingAction>
	<gtContextInstructionDebuggingAction>

	^self forDebugger: aJibDebugger

]

{ #category : #accessing }
JibDebugActionResume >> defaultIcon [

	^ GLMUIThemeExtraIcons glamorousPlay
]

{ #category : #accessing }
JibDebugActionResume >> defaultLabel [
	^ 'Continue' "I decided to use 'Continue' to make it consistent with GTB Debugger"
]

{ #category : #accessing }
JibDebugActionResume >> defaultOrder [

	^ 5
]

{ #category : #actions }
JibDebugActionResume >> executeAction [
	self session resume


]
