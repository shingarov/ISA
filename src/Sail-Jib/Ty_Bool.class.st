Class {
	#name : #'Ty_Bool',
	#superclass : #Ty,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_Bool class >> inducedParser [
	^'%bool' asParser
]
