Class {
	#name : #'Ty_Bits',
	#superclass : #Ty,
	#instVars : [
		'length'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_Bits class >> inducedParser [
	^ '%bv' asParser
	, (#digit asParser plus flatten ==> #asInteger)
	construct: #(- length)
]

{ #category : #accessing }
Ty_Bits >> sort [
	^ self environment context mkBvSort: length 
]

{ #category : #semantics }
Ty_Bits >> spriteRType [
	^TCon
		c: 'BitVec'
		ts: { TBvSize c: 'Size', length printString ts: #() ars: #() r: Reft new known }
		ars: {}
		r: Reft new known
]

{ #category : #printing }
Ty_Bits >> unparseOn: aStream [
	aStream nextPutAll: '%bv'.
	length printOn: aStream
]
