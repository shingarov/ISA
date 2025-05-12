Class {
	#name : #'Ty_I128',
	#superclass : #'Ty_I',
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_I128 class >> inducedParser [
	^'%i' asParser
	==> [ :_ | self new ]
]

{ #category : #printing }
Ty_I128 >> unparseOn: aStream [
	aStream nextPutAll: '%i128'
]
