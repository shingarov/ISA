Class {
	#name : #'Ty_I64',
	#superclass : #Ty,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_I64 class >> inducedParser [
	^'%i64' asParser
]
