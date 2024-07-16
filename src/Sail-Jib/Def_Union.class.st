Class {
	#name : #'Def_Union',
	#superclass : #JibDef,
	#instVars : [
		'name',
		'members'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Def_Union class >> inducedParser [
	^ 'union' asParser trim
	, JibParser id trim
	, ((JibParser id, $: asParser trim, Ty inducedParser ==> [ :x | x first -> x last ]) commaSeparated braces
	  ==> (Dictionary newFromAssociations: □))
	construct: #(- name members)
]

{ #category : #initialization }
Def_Union >> addTo: aJibProgram [
	aJibProgram unions
		at: name
		put: self
]

{ #category : #printing }
Def_Union >> printOn: aStream [
	aStream
		nextPutAll: 'union ';
		nextPutAll: name;
		nextPutAll: ' {…}'
]
