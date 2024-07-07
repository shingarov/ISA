Class {
	#name : #JibUnion,
	#superclass : #JibDef,
	#instVars : [
		'name',
		'members'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
JibUnion class >> inducedParser [
	^ 'union' asParser trim
	, JibParser id trim
	, (JibParser id, $: asParser trim, Ty inducedParser) commaSeparated braces
	construct: #(- name members)
]

{ #category : #initialization }
JibUnion >> addTo: aJibProgram [
	aJibProgram unions
		at: name zdecode
		put: self
]

{ #category : #printing }
JibUnion >> printOn: aStream [
	aStream
		nextPutAll: 'union ';
		nextPutAll: name;
		nextPutAll: ' {…}'
]
