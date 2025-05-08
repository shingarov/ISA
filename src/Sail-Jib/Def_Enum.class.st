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

{ #category : #analysis }
Def_Enum >> analyzeUsing: analyzer [
	analyzer analyzeEnum: self
]

{ #category : #enumerating }
Def_Enum >> childrenDo: aBlock [
	"Enum has no children, it contains just a list of names."
	
]

{ #category : #accessing }
Def_Enum >> id [
	^ id
]

{ #category : #accessing }
Def_Enum >> ids [
	^ ids
]

{ #category : #testing }
Def_Enum >> isEnum [
	^ true
]

{ #category : #printing }
Def_Enum >> unparseOn: aStream [
	aStream
		nextPutAll: 'enum ';
		nextPutAll: id;
		nextPutAll: ' {…}'
]
