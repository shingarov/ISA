Class {
	#name : #'Ty_Real',
	#superclass : #Ty,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_Real class >> inducedParser [
	^'%real' asParser
]
