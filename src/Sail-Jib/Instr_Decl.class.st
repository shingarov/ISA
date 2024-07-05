Class {
	#name : #'Instr_Decl',
	#superclass : #JibInstr,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Instr_Decl class >> inducedParser [
	^ JibParser id
	, $: asParser trim
	, Ty inducedParser
	, JibSourceLoc inducedParser
	

"
Instr_Decl inducedParser parse: 'zz40 : %bool `6 131:25-134:1'
"
]
