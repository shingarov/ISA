Class {
	#name : #'Instr_Monomorphize',
	#superclass : #JibInstr,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Instr_Monomorphize class >> inducedParser [
^'MONO' asParser
]

{ #category : #printing }
Instr_Monomorphize >> unparseOn: aStream [
	super unparseOn: aStream.
	"
	aStream 
		nextPutAll:'...';
		nextPutAll:'...'.
	"
	sourceLoc unparseOn: aStream.

]
