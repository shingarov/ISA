Class {
	#name : #'Instr_Call',
	#superclass : #JibInstr,
	#instVars : [
		'lvalue',
		'f',
		'args'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Instr_Call class >> inducedParser [
	^ JibLoc inducedParser trim
	, $= asParser trim
	, ($$ asParser optional, JibParser id) flatten trim
	, JibExp inducedParser commaList trim
	, JibSourceLoc inducedParser
	construct: #(lvalue - f args sourceLoc)
]

{ #category : #'Hindley-Milner' }
Instr_Call >> unifyHmTypesIn: Γ [
	| functionType actualArgTypes actualReturnType |
	actualArgTypes := args collect: (□ typeIn: Γ).
	functionType := Γ at: f.
	(actualArgTypes zip: functionType dom) doAssociations: #unify:.
	actualReturnType := lvalue typeIn: Γ.
	actualReturnType unify: functionType cod.
	"TODO: instantiation of concrete app" self halt.
	^Γ

]
