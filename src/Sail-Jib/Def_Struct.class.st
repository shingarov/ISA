Class {
	#name : #'Def_Struct',
	#superclass : #JibDef,
	#instVars : [
		'id',
		'ids'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Def_Struct class >> inducedParser [
	^ 'struct' asParser trim
	, JibParser id trim
	, (JibParser id, $: asParser trim, Ty asParser) commaSeparated braces
	construct: #(- id ids)
]

{ #category : #initialization }
Def_Struct >> addTo: aJibProgram [
	aJibProgram structs
		at: id
		put: self
]

{ #category : #printing }
Def_Struct >> printOn: aStream [
	aStream
		nextPutAll: 'struct ';
		nextPutAll: id;
		nextPutAll: ' {…}'
]
