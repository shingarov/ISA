Class {
	#name : #'Instr_Init',
	#superclass : #JibInstr,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Instr_Init class >> inducedParser [
	^ JibParser id
	, $: asParser trim
	, Ty inducedParser
	, $= asParser trim
	, JibExp inducedParser
	, JibSourceLoc inducedParser
	

"
Instr_Init parser parse: 'zz43 = zb `6 132:2-132:8'
"
]
