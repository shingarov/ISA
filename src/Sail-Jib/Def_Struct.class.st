Class {
	#name : #'Def_Struct',
	#superclass : #JibDef,
	#instVars : [
		'name',
		'members'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Def_Struct class >> inducedParser [
	^ 'struct' asParser trim
	, JibParser id trim
	, (JibParser id, $: asParser trim, Ty inducedParser) commaSeparated braces
	construct: #(- name members)
]

{ #category : #initialization }
Def_Struct >> addTo: aJibProgram [
	aJibProgram structs
		at: name
		put: self
]

{ #category : #printing }
Def_Struct >> printOn: aStream [
	aStream
		nextPutAll: 'struct ';
		nextPutAll: name;
		nextPutAll: ' {…}'
]
