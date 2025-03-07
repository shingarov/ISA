Class {
	#name : #'Def_Union',
	#superclass : #JibDef,
	#instVars : [
		'id',
		'ids'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Def_Union class >> inducedParser [
	^ 'union' asParser trim
	, JibParser id trim
	, ((JibParser id, $: asParser trim, Ty asParser ==> [ :x | x first -> x last ]) commaSeparated braces
	  ==> (Dictionary newFromAssociations: □))
	construct: #(- id ids)
]

{ #category : #initialization }
Def_Union >> addTo: aJibProgram [
	aJibProgram unions
		at: id
		put: self
]

{ #category : #printing }
Def_Union >> printOn: aStream [
	aStream
		nextPutAll: 'union ';
		nextPutAll: id;
		nextPutAll: ' {…}'
]
