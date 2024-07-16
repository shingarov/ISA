Class {
	#name : #'Instr_Arbitrary',
	#superclass : #JibInstr,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Instr_Arbitrary class >> inducedParser [
	^'arbitrary' asParser
]
