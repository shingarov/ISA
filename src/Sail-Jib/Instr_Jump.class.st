Class {
	#name : #'Instr_Jump',
	#superclass : #JibInstr,
	#instVars : [
		'exp',
		'target',
		'loc'
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
	construct: #(- exp - target loc)
]
