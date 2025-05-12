Class {
	#name : #'Ty_Enum',
	#superclass : #Ty,
	#instVars : [
		'id'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_Enum class >> inducedParser [
	^ '%enum' asParser trim
	, JibParser id
	construct: #(- id)
]

{ #category : #accessing }
Ty_Enum >> sort [
	^ self environment lookupSortForTypename: id
]

{ #category : #semantics }
Ty_Enum >> spriteRType [
	^TCon
		c: id
		ts: {}
		ars: {}
		r: Reft new known
]

{ #category : #printing }
Ty_Enum >> unparseOn: aStream [	
	aStream 
		nextPutAll:'%enum ';
		nextPutAll:id.

]
