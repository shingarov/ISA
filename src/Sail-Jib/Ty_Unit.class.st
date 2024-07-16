Class {
	#name : #'Ty_Unit',
	#superclass : #Ty,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_Unit class >> inducedParser [
	^'%unit' asParser
]
