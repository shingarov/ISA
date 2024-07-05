Class {
	#name : #'Instr_Monomorphize',
	#superclass : #JibInstr,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Instr_Monomorphize class >> inducedParser [
^'MONO' asParser
]
