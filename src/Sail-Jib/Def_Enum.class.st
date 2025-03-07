Class {
	#name : #'Def_Enum',
	#superclass : #JibDef,
	#instVars : [
		'id',
		'ids'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Def_Enum class >> inducedParser [
	^ 'enum' asParser trim
	, JibParser id trim
	, JibParser id trim commaSeparated braces
	construct: #(- id ids)
]

{ #category : #initialization }
Def_Enum >> addTo: aJibProgram [ 
	aJibProgram enums
		at: id
		put: self
]

{ #category : #printing }
Def_Enum >> printOn: aStream [
	aStream
		nextPutAll: 'enum ';
		nextPutAll: id;
		nextPutAll: ' {…}'
]
