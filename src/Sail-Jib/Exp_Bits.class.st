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

{ #category : #'printing & storing' }
Exp_Bits >> printOn: aStream [
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

{ #category : #'as yet unclassified' }
Exp_Bits >> toSpriteExpr: _ [ 
	^ΛEApp
		expr: (ΛEApp expr: (EImm imm: (EVar of: 'bv')) imm: (ECon prim: (PInt integer: x length))) imm: (ECon prim: (PInt integer: x value))
]

{ #category : #accessing }
Exp_Bits >> value [
	^ x
]
