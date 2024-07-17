Class {
	#name : #'Exp_Bits',
	#superclass : #JibExp,
	#instVars : [
		'x'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Exp_Bits class >> inducedParser [
	^ (PPSequenceParser with:
		('bitzero' asParser ==> [ :_ | 0 toBitVector: 1 ]) /
		('bitone'  asParser ==> [ :_ | 1 toBitVector: 1 ]) /
		('emptybitvec' asParser ==> [ :_ | BitVector empty ]) /
		(PPParser cHexNumber ==> [ :x | AnyBitVector with: x ]) /
		BitVector parser0b
	) construct: #(x)
]

{ #category : #'formal semantics' }
Exp_Bits >> toSpriteExprIn: _ [
	^EImm imm: (ECon prim: (PBitVector
		length: x length
		value: x unsignedValue))

]
