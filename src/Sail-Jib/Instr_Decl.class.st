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

{ #category : #'as yet unclassified' }
Instr_Decl >> addTempDeclTo: aJibFnEnvironment [ 
	aJibFnEnvironment temp: id hasType: ty
]

{ #category : #'deterministic interpretation' }
Instr_Decl >> interpretIn: aContext [ 
	^(aContext declareTemp: id ofSort: ty sort) incrPC
]
