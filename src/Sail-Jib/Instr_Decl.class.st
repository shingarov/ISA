Class {
	#name : #'Instr_Decl',
	#superclass : #JibInstr,
	#instVars : [
		'id',
		'ty'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Instr_Decl class >> inducedParser [
	^ JibParser id
	, $: asParser trim
	, Ty inducedParser
	, JibSourceLoc inducedParser
	construct: #(id - ty sourceLoc)

"
Instr_Decl inducedParser parse: 'zz40 : %bool `6 131:25-134:1'
"
]
