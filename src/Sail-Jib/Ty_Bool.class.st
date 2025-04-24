Class {
	#name : #'Ty_Bool',
	#superclass : #Ty,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_Bool class >> inducedParser [
	^'%bool' asParser
	==> [ :_ | self new ]
]

{ #category : #printing }
Ty_Bool >> unparseOn: aStream [
	aStream nextPutAll: '%bool'
]
