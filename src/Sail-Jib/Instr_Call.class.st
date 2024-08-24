Class {
	#name : #'Instr_Call',
	#superclass : #JibInstr,
	#instVars : [
		'lvalue',
		'f',
		'args'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Instr_Call class >> inducedParser [
	^ JibLoc inducedParser trim
	, $= asParser trim
	, ($$ asParser optional, JibParser id) flatten trim
	, JibExp inducedParser commaList trim
	, JibSourceLoc inducedParser
	construct: #(lvalue - f args sourceLoc)
]

{ #category : #enumerating }
Instr_Call >> defdIdsDo: aBlock [
	lvalue defdIdsDo: aBlock
	
]

{ #category : #'deterministic interpretation' }
Instr_Call >> interpretIn: aContext [
	| fn callee |
	fn := aContext at: f.
	callee := JibDeterministicContext new.
	callee
		fn: fn;
		temps: (Dictionary newFromAssociations: {'return'->fn returnSort undefinedElement});
		sender: aContext;
		pc: 1.
	^callee
]

{ #category : #printing }
Instr_Call >> printOn: aStream [
	lvalue printOn: aStream.
	aStream nextPutAll: ' = '.
	aStream nextPutAll: f.
	aStream nextPutAll: '(...)'.

]

{ #category : #enumerating }
Instr_Call >> usedIdsDo: aBlock [
	"BOGUS: look at what is in `e` and `args` instvars, looks like some garbage to me."	
	args flattened do:[:e|(e isKindOf: JibExp) ifTrue:[e usedIdsDo: aBlock]]
	
]
