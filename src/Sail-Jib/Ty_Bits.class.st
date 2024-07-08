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

{ #category : #printing }
Ty_Bits >> printOn: aStream [
	aStream nextPutAll: '%bv'.
	length printOn: aStream
]
