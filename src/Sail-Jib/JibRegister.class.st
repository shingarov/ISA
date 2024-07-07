Class {
	#name : #JibRegister,
	#superclass : #JibDef,
	#instVars : [
		'name',
		'ty'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
JibRegister class >> inducedParser [
	^ 'register' asParser trim
	, JibParser id trim
	, $: asParser trim
	, Ty inducedParser trim
	, '{BOGUS}' asParser optional "never happens in riscv_duopod"
	construct: #(- name - ty -)
]

{ #category : #initialization }
JibRegister >> addTo: aJibProgram [
	aJibProgram registers
		at: name zdecode
		put: self
]
