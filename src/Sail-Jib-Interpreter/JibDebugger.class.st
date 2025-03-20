Class {
	#name : #JibDebugger,
	#superclass : #GTGenericStackDebugger,
	#category : #'Sail-Jib-Interpreter-Debugger'
}

{ #category : #formatting }
JibDebugger >> formatInstruction: insn forContext: context [
	(context function instrs indexOf: insn) == context pc ifTrue:[
		^ '>> ' , insn displayString
	] ifFalse:[
		^ '   ' , insn displayString
	]

]

{ #category : #formatting }
JibDebugger >> formatStackForContext: context [
	^context function displayString
]

{ #category : #'building presentations' }
JibDebugger >> installBindingsForDoItIn: aPresentation from: aContext [
	"TODO"


]

{ #category : #'building presentations' }
JibDebugger >> methodCodeIn: composite forContext: context [
	^ composite fastList
		title: 'Instructions';
		display: [ context function instrs ];
		format: [ :insn | self formatInstruction: insn forContext: context ]
]

{ #category : #'building presentations' }
JibDebugger >> stackWidgetIn: composite [
	^ composite fastList
		title: 'Stack';
		useCache;
		display: [:aSession | self retrieveStackFrom: aSession];
		format: [ :aContext | self formatStackForContext: aContext]
]
