Class {
	#name : #'Exp_Bits',
	#superclass : #JibExp,
	#instVars : [
		'x'
	],
	#category : #'Sail-Jib'
}

{ #category : #enumerating }
Exp_Bits >> childrenDo: aBlock [
	"Leaf node, nothing to do."
	
]

{ #category : #semantics }
Exp_Bits >> spriteExpr [
	^ ΛEApp
			expr: (EImm imm: (EVar of: 'toBitVector'))
			imm: (ECon prim: (PInt integer: x signedValue))
]

{ #category : #'printing & storing' }
Exp_Bits >> unparseOn: aStream [
	x length == 0 ifTrue:[
		aStream nextPutAll: 'emptybitvec'
	] ifFalse: [
		(x length \\ 4) == 0 ifTrue:[
			aStream nextPutAll: '#x'.
			x unsignedValue printOn: aStream base: 16 length: x length // 4 padded: true.
		] ifFalse:[
			aStream nextPutAll: '#b'.
			x unsignedValue printOn: aStream base: 2 length: x length padded: true.
		]
	]
]

{ #category : #accessing }
Exp_Bits >> value [
	^ x
]
