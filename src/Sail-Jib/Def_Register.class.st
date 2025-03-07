Class {
	#name : #'Def_Register',
	#superclass : #JibDef,
	#instVars : [
		'id',
		'ty',
		'instrs'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Def_Register class >> inducedParser [
	^ 'register' asParser trim
	, JibParser id trim
	, $: asParser trim
	, Ty inducedParser trim
	, '{BOGUS}' asParser optional "never happens in riscv_duopod"
	construct: #(- id - ty -)
]

{ #category : #initialization }
Def_Register >> addTo: aJibProgram [
	aJibProgram registers
		at: id
		put: self
]

{ #category : #printing }
Def_Register >> printOn: aStream [
	aStream nextPut: (Character codePoint: 16rAE).
	aStream nextPutAll: id zdecode.
	aStream nextPutAll: ' ∷ '.
	ty printOn: aStream
]
