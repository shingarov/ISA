Class {
	#name : #'Ty_String',
	#superclass : #Ty,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_String class >> inducedParser [
	^'%string' asParser
]
