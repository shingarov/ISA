Class {
	#name : #'Ty_AnyBits',
	#superclass : #Ty,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_AnyBits class >> inducedParser [
	^'%bv' asParser
	==> [ :_ | self new ]
]

{ #category : #printing }
Ty_AnyBits >> printOn: aStream [
	aStream nextPutAll: '%bv'
]
