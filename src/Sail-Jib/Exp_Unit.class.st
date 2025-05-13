Class {
	#name : #'Exp_Unit',
	#superclass : #JibExp,
	#category : #'Sail-Jib'
}

{ #category : #enumerating }
Exp_Unit >> childrenDo: aBlock [
	"Leaf node, nothing to do."
	
]

{ #category : #semantics }
Exp_Unit >> spriteExpr [
	^EImm imm: (EVar of: '__unit__')
]

{ #category : #printing }
Exp_Unit >> unparseOn: aStream [
	aStream nextPutAll:'()'

]
