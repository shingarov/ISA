Class {
	#name : #'Ty_String',
	#superclass : #Ty,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_String class >> inducedParser [
	^ '%string' asParser
	==> [ :_ | self new ]
]

{ #category : #printing }
Ty_String >> unparseOn: aStream [
	super unparseOn: aStream.
	"
	aStream 
		nextPutAll:'...';
		nextPutAll:'...'.
	"

]
