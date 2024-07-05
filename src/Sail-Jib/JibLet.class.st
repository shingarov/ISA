Class {
	#name : #JibLet,
	#superclass : #JibDef,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
JibLet class >> inducedParser [
^'let' asParser
]
