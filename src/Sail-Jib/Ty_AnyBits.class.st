Class {
	#name : #'Ty_AnyBits',
	#superclass : #Ty,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_AnyBits class >> inducedParser [
	^'%bv' asParser
]
