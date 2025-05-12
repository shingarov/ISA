Class {
	#name : #'Ty_Struct',
	#superclass : #Ty,
	#instVars : [
		'id'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_Struct class >> inducedParser [
	^ '%struct' asParser trim
	, JibParser id
	construct: #(- id)
]

{ #category : #semantics }
Ty_Struct >> spriteRType [
	^TCon
		c: id
		ts: {}
		ars: {}
		r: Reft new known
]

{ #category : #printing }
Ty_Struct >> unparseOn: aStream [
	aStream nextPutAll: '%struct '.
	aStream nextPutAll: id
]
