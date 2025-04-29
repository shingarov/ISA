Class {
	#name : #JibDebugger,
	#superclass : #GTGenericStackDebugger,
	#category : #'Sail-Jib-Interpreter-Debugger'
}

{ #category : #accessing }
JibDebugger class >> defaultTitle [
	^ self class name
]

{ #category : #testing }
JibDebugger class >> isAbstract [
	^ self == JibDebugger 
]

{ #category : #openning }
JibDebugger class >> openOn: anObject [
	self == JibDebugger ifTrue:[
		^ JibSourceDebugger openOn: anObject 
	] ifFalse:[
		^ super openOn: anObject.
	]
]

{ #category : #accessing }
JibDebugger class >> sessionClass [
	^JibDebuggerSession 
]

{ #category : #private }
JibDebugger class >> spanNewSessionForContext: aContext fromProcess: aProcess [
	self shouldNotImplement 
]

{ #category : #accessing }
JibDebugger class >> spanNewSessionFrom: anotherSession [
	self assert: anotherSession class == self sessionClass.
	
	^anotherSession copy
]

{ #category : #private }
JibDebugger class >> spanNewSessionLabeled: aString forContext: aContext fromProcess: aProcess [
	self shouldNotImplement 
]

{ #category : #'building presentations' }
JibDebugger >> codeIn: composite forContext: frame [
	self subclassResponsibility 
]

{ #category : #building }
JibDebugger >> debuggerStructureIn: browser [
	
	browser
		row: #stack;
		row: #code span: 2;
		row: #inspector.
]

{ #category : #formatting }
JibDebugger >> formatInstruction: insn forContext: context [
	(context function instrs indexOf: insn) == context pc ifTrue:[
		^ '>> ' , insn unparsedString
	] ifFalse:[
		^ '   ' , insn unparsedString
	]

]

{ #category : #formatting }
JibDebugger >> formatStackForContext: context [
	^context function unparsedString
]

{ #category : #'building presentations' }
JibDebugger >> installBindingsForDoItIn: aPresentation from: aContext [
	"TODO"


]

{ #category : #'building presentations' }
JibDebugger >> instructionsIn: composite forContext: context [
	^ composite fastList
		title: 'Instructions';
		with: [ :text | self installActionsForRootPragmas: #( instructionDebuggingAction ) in: text ];
		display: [ context function instrs ];
		format: [ :insn | self formatInstruction: insn forContext: context ];
		selectionAct: [ :list | list selection inspect ]
			iconName: #smallInspectIt
			entitled: 'Inspect'.
]

{ #category : #opening }
JibDebugger >> setDebuggerToFirstNonFilteredContext [
	"Nothing to do"
]

{ #category : #'building presentations' }
JibDebugger >> sourceIn: composite forContext: context [
	composite text
			with: [ :text | self installActionsForRootPragmas: #( sourceDebuggingAction ) in: text ];
			title: 'Source';
			display: [ context sourceLoc sourceTextWithHighlights ];
			format: #asText
]

{ #category : #'building presentations' }
JibDebugger >> stackWidgetIn: composite [
	^ composite fastList
		title: 'Stack';
		useCache;
		display: [:aSession | self retrieveStackFrom: aSession];
		format: [ :aContext | self formatStackForContext: aContext];
		selectionAct: [ :list | list selection inspect ]
			iconName: #smallInspectIt
			entitled: 'Inspect'.
]

{ #category : #building }
JibDebugger >> transmitFromStackToCodeIn: browser [
	browser transmit
		from: #stack port: #selection;
		to: #code;
		andShow: [ :composite :context | context notNil ifTrue:[ self codeIn: composite forContext: context ]].
]
