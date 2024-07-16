Class {
	#name : #'Ty_Bit',
	#superclass : #Ty,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_Bit class >> inducedParser [
	^'%bit' asParser
]
