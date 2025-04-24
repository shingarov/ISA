Class {
	#name : #'Ty_RoundingMode',
	#superclass : #Ty,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_RoundingMode class >> inducedParser [
	^ '%rounding_mode' asParser
	==> [ :_ | self new ]
]

{ #category : #printing }
Ty_RoundingMode >> unparseOn: aStream [
	aStream nextPutAll:'%rounding_mode'
]
