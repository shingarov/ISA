Class {
	#name : #'Op_Neq',
	#superclass : #JibOp,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Op_Neq class >> inducedParser [
	^ '@neq' asParser
	==> self uniqueInstance
]
