Class {
	#name : #JibDebugActionOver,
	#superclass : #JibDebugAction,
	#category : #'Sail-Jib-Interpreter-Debugger-Actions'
}

{ #category : #accessing }
JibDebugActionOver class >> actionFor: aGTBDebugger [
	<gtStackDebuggingAction>

	<gtContextStackDebuggingAction>
	<gtContextSourceDebuggingAction>


	^self forDebugger: aGTBDebugger

]

{ #category : #accessing }
JibDebugActionOver >> defaultIcon [

	^ GLMUIThemeExtraIcons glamorousOver
]

{ #category : #accessing }
JibDebugActionOver >> defaultLabel [
	^ 'Over'
]

{ #category : #accessing }
JibDebugActionOver >> defaultOrder [

	^ 10
]

{ #category : #actions }
JibDebugActionOver >> executeAction [
	self session stepOver: self selectedContext


]
