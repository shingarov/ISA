Class {
	#name : #'Instr_Exit',
	#superclass : #JibInstr,
	#instVars : [
		'cause',
		'src'
	],
	#category : #'Sail-Jib'
}

{ #category : #parsing }
Instr_Exit class >> inducedParser [
	^ 'exit' asParser trim
	, JibParser id trim
	, JibSourceLoc inducedParser
	
	
"
Instr_Exit parser parse: 'exit match `6 131:25-134:1'
"
	
]
