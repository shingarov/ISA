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
	context sourceLoc isKnown ifTrue:[
		composite tabulator with:[:tabulator |
			tabulator
				column: #source;
				column: #instructions.
			tabulator transmit
				to: #source;
				andShow: [ :c | self sourceIn: c forContext: context ].
			tabulator transmit
				to: #instructions;
				andShow: [ :c | self instructionsIn: c forContext: context ].
		]
	] ifFalse:[
		self instructionsIn: composite forContext: context
	].
]
