Class {
	#name : #'Instr_Call',
	#superclass : #JibInstr,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Instr_Call class >> inducedParser [
	^ JibLoc inducedParser trim
	, $= asParser trim
	, ($$ asParser optional, JibParser id) trim
	, JibExp inducedParser commaList trim
	, JibSourceLoc inducedParser


"
Instr_Call inducedParser parse: 'y = f(x) `6 157:32-157:41'
"
]
