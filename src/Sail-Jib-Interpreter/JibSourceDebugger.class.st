Class {
	#name : #JibSourceDebugger,
	#superclass : #JibDebugger,
	#category : #'Sail-Jib-Interpreter-Debugger'
}

{ #category : #accessing }
JibSourceDebugger class >> defaultTitle [
	^ 'Sail'
]

{ #category : #building }
JibSourceDebugger >> codeIn: composite forContext: context [
	context sourceLoc isKnown ifTrue:[
		self sourceIn: composite forContext: context
	] ifFalse:[
		self instructionsIn: composite forContext: context
	].
]
