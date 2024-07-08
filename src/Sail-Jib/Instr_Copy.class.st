Class {
	#name : #'Instr_Copy',
	#superclass : #JibInstr,
	#instVars : [
		'l',
		'e'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Instr_Copy class >> inducedParser [
	^ JibParser id trim
	, $= asParser trim
	, JibExp inducedParser
	, JibSourceLoc inducedParser optional"??? not according to ir_parser.lalrpop!"
	construct: #(l - e sourceLoc)
]
