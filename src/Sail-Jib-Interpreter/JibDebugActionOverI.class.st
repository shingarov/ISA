Class {
	#name : #JibDebugActionOverI,
	#superclass : #JibDebugAction,
	#category : #'Sail-Jib-Interpreter-Debugger-Actions'
}

{ #category : #accessing }
JibDebugActionOverI class >> actionFor: aGTBDebugger [	
	<gtStackDebuggingAction>
	
	<gtContextStackDebuggingAction>
	<gtContextInstructionDebuggingAction>

	^self forDebugger: aGTBDebugger 
]

{ #category : #accessing }
JibDebugActionOverI >> defaultIcon [

	^ GLMUIThemeExtraIcons glamorousOver
]

{ #category : #accessing }
JibDebugActionOverI >> defaultLabel [
	^ 'Over instruction'
]

{ #category : #accessing }
JibDebugActionOverI >> defaultOrder [

	^ 30
]

{ #category : #actions }
JibDebugActionOverI >> executeAction [
	self session stepOverI: self selectedContext
	
	
]
