Class {
	#name : #'Def_Enum',
	#superclass : #JibDef,
	#instVars : [
		'name',
		'members'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Def_Enum class >> inducedParser [
	^ 'enum' asParser trim
	, JibParser id trim
	, JibParser id trim commaSeparated braces
	construct: #(- name members)
]

{ #category : #initialization }
Def_Enum >> addTo: aJibProgram [ 
	aJibProgram enums
		at: name
		put: self
]

{ #category : #printing }
Def_Enum >> printOn: aStream [
	aStream
		nextPutAll: 'enum ';
		nextPutAll: name;
		nextPutAll: ' {…}'
]
