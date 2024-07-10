Class {
	#name : #'Op_Not',
	#superclass : #JibOp,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Op_Not class >> inducedParser [
	^ '@not' asParser
	==> self uniqueInstance
]
