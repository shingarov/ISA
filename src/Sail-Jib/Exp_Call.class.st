Class {
	#name : #'Exp_Call',
	#superclass : #JibExp,
	#instVars : [
		'op',
		'args'
	],
	#category : #'Sail-Jib'
}

{ #category : #accessing }
Exp_Call >> argExprs [
	^ args
]

{ #category : #enumerating }
Exp_Call >> childrenDo: aBlock [
	args do: aBlock
	
]

{ #category : #accessing }
Exp_Call >> op [
	^ op
]

{ #category : #semantics }
Exp_Call >> spriteExpr [
	^ΛEApp mkEApp: op spriteEImm args: (args collect:#spriteExpr)
]

{ #category : #printing }
Exp_Call >> unparseOn: aStream [
	aStream nextPutAll: op id.
	aStream nextPut: $(.
	args do:[:arg | arg unparseOn: aStream ] separatedBy:[aStream nextPutAll: ', '].
	aStream nextPut: $).

]

{ #category : #enumerating }
Exp_Call >> usedIdsDo: aBlock [
	args do:[:e|e usedIdsDo: aBlock]
	
]
