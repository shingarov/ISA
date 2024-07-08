Class {
	#name : #'Def_Let',
	#superclass : #JibDef,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Def_Let class >> inducedParser [
^'let' asParser
]
