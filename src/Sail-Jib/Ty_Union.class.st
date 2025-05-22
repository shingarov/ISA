Class {
	#name : #'Ty_Union',
	#superclass : #Ty,
	#instVars : [
		'id'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_Union class >> inducedParser [
	^ '%union' asParser trim
	, JibParser id
	construct: #(- id)
]

{ #category : #accessing }
Ty_Union >> def [
	^self program lookupUnion: id
]

{ #category : #accessing }
Ty_Union >> id [
	^ id
]

{ #category : #semantics }
Ty_Union >> spriteRType [
	^TCon
		c: id
		ts: {}
		ars: {}
		r: Reft new known
]

{ #category : #printing }
Ty_Union >> unparseOn: aStream [
	aStream nextPutAll: '%union '.
	aStream nextPutAll: id
]
