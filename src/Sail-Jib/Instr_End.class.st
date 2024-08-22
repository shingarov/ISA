Class {
	#name : #'Instr_End',
	#superclass : #JibInstr,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Instr_End class >> inducedParser [
	^ 'end' asParser
	==> self uniqueInstance
]

{ #category : #accessing }
Instr_End class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self basicNew ]
]

{ #category : #'deterministic interpretation' }
Instr_End >> interpretIn: aContext [ 
	self shouldBeImplemented.
]

{ #category : #testing }
Instr_End >> isEnd [
	^true
]

{ #category : #'formal semantics' }
Instr_End >> toSpriteExprIn: aJibProgram [ 
	^EImm imm: (EVar of: 'return') "BOGUS, must unravel the coalgebra"
]
