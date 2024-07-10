Class {
	#name : #JibInstr,
	#superclass : #Object,
	#instVars : [
		'sourceLoc'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
JibInstr class >> adtSummands [
	^{
		Instr_Arbitrary.
		Instr_End.
		Instr_Goto.
		Instr_Jump.
		Instr_Monomorphize.
		Instr_Call.
		Instr_Copy.
		Instr_Decl.
		Instr_Exit.
		Instr_Init.
	}
]

{ #category : #'Hindley-Milner' }
JibInstr >> unifyHmTypesIn: typeDictionary [
	self subclassResponsibility
]
