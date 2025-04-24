Class {
	#name : #'Ty_Ref',
	#superclass : #Ty,
	#instVars : [
		'ty'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_Ref class >> inducedParser [
	^ $& asParser
	, Ty asParser parens
	construct: #(- ty)
]

{ #category : #enumerating }
Ty_Ref >> childrenDo: aBlock [
	aBlock value: ty
]

{ #category : #printing }
Ty_Ref >> unparseOn: aStream [
	super unparseOn: aStream.
	"
	aStream 
		nextPutAll:'...';
		nextPutAll:'...'.
	"

]
