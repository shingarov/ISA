Class {
	#name : #JibDebugActionInto,
	#superclass : #JibDebugAction,
	#category : #'Sail-Jib-Interpreter-Debugger-Actions'
}

{ #category : #accessing }
JibDebugActionInto class >> actionFor: aGTBDebugger [
	<gtStackDebuggingAction>

	<gtContextStackDebuggingAction>
	<gtContextSourceDebuggingAction>


	^self forDebugger: aGTBDebugger
]

{ #category : #accessing }
JibDebugActionInto >> defaultIcon [

	^ GLMUIThemeExtraIcons glamorousInto
]

{ #category : #accessing }
JibDebugActionInto >> defaultLabel [
	^ 'Into'
]

{ #category : #accessing }
JibDebugActionInto >> defaultOrder [

	^ 20
]

{ #category : #actions }
JibDebugActionInto >> executeAction [
	self session stepInto: self selectedContext
]
