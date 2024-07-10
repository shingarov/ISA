Class {
	#name : #'Def_Register',
	#superclass : #JibDef,
	#instVars : [
		'name',
		'ty'
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
	construct: #(- name - ty -)
]

{ #category : #initialization }
Def_Register >> addTo: aJibProgram [
	aJibProgram registers
		at: name
		put: self.
	aJibProgram types
		at: name
		ifPresent: [ self error: 'cant have more than one type declaration' ]
		ifAbsentPut: ty
]

{ #category : #printing }
Def_Register >> printOn: aStream [
	aStream nextPut: (Character codePoint: 16rAE).
	aStream nextPutAll: name zdecode.
	aStream nextPutAll: ' ∷ '.
	ty printOn: aStream
]
