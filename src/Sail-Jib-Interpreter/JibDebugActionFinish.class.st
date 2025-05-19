Class {
	#name : #JibDebugActionFinish,
	#superclass : #JibDebugAction,
	#category : #'Sail-Jib-Interpreter-Debugger-Actions'
}

{ #category : #acccessing }
JibDebugActionFinish class >> actionFor: aDebugger [
	<gtStackDebuggingAction>

	<gtContextStackDebuggingAction>
	<gtContextSourceDebuggingAction>
	<gtContextInstructionDebuggingAction>

	^ self forDebugger: aDebugger
]

{ #category : #testing }
JibDebugActionFinish >> appliesToDebugger: aDebugger [

	^ aDebugger isKindOf: JibDebugger
]

{ #category : #accessing }
JibDebugActionFinish >> defaultIcon [

	^ GLMUIThemeExtraIcons glamorousOver
]

{ #category : #accessing }
JibDebugActionFinish >> defaultLabel [
	^ 'Finish'
]

{ #category : #accessing }
JibDebugActionFinish >> defaultOrder [

	^ 45
]

{ #category : #actions }
JibDebugActionFinish >> executeAction [
	self session finish: self selectedContext

]

{ #category : #accessing }
JibDebugActionFinish >> help [
	^ 'Execute until selected context returns'.
]
