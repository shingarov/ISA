Class {
	#name : #JibDebuggerDebugActionFinish,
	#superclass : #DebugAction,
	#category : #'Sail-Jib-Interpreter-Debugger'
}

{ #category : #acccessing }
JibDebuggerDebugActionFinish class >> actionFor: aDebugger [
	<gtStackDebuggingAction>

	^ self forDebugger: aDebugger
]

{ #category : #acccessing }
JibDebuggerDebugActionFinish class >> actionType [
	<debuggingAction>
	<contextMenuDebuggingAction>
]

{ #category : #testing }
JibDebuggerDebugActionFinish >> appliesToDebugger: aDebugger [

	^ aDebugger isKindOf: JibDebugger
]

{ #category : #accessing }
JibDebuggerDebugActionFinish >> defaultIcon [

	^ GLMUIThemeExtraIcons glamorousOver
]

{ #category : #accessing }
JibDebuggerDebugActionFinish >> defaultLabel [
	^ 'Finish'
]

{ #category : #accessing }
JibDebuggerDebugActionFinish >> defaultOrder [

	^ 25
]

{ #category : #actions }
JibDebuggerDebugActionFinish >> executeAction [
	self session finish: self selectedContext

]

{ #category : #accessing }
JibDebuggerDebugActionFinish >> help [
	^ 'Execute until selected context returns'.
]
