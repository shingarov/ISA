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
	, JibExitCause inducedParser
	, JibSourceLoc inducedParser
	construct: #(- cause src)
	
"
Instr_Exit inducedParser parse: 'exit match `6 131:25-134:1'
"
	
]
