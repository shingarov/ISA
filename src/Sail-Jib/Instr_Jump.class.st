Class {
	#name : #'Instr_Jump',
	#superclass : #JibInstr,
	#instVars : [
		'exp',
		'target'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Instr_Jump class >> inducedParser [
	^ 'jump' asParser trim
	, JibExp inducedParser trim
	, 'goto' asParser trim
	, PPParser decimalInteger trim
	, JibSourceLoc inducedParser trim
	construct: #(- exp - target sourceLoc)
]

{ #category : #'Hindley-Milner' }
Instr_Jump >> unifyHmTypesIn: Γ [
	^exp unifyHmTypesIn: Γ
]
