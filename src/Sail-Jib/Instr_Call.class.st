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
