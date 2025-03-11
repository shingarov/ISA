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

{ #category : #enumerating }
Def_Enum >> childrenDo: aBlock [
	"Enum has no children, it contains just a list of names."
	
]

{ #category : #accessing }
Def_Enum >> id [
	^ id
]

{ #category : #printing }
Def_Enum >> printOn: aStream [
	aStream
		nextPutAll: 'enum ';
		nextPutAll: id;
		nextPutAll: ' {…}'
]
