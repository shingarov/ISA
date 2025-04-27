Class {
	#name : #JibInstructionDebugger,
	#superclass : #JibDebugger,
	#category : #'Sail-Jib-Interpreter-Debugger'
}

{ #category : #accessing }
JibInstructionDebugger class >> defaultTitle [
	^ 'Jib'
]

{ #category : #'building presentations' }
JibInstructionDebugger >> codeIn: composite forContext: context [
	self instructionsIn: composite forContext: context
]
