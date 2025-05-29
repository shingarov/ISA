Class {
	#name : #'Op_Neq',
	#superclass : #JibOp,
	#category : #'Sail-Jib'
}

{ #category : #accessing }
Op_Neq class >> id [
	^ '@neq'
]

{ #category : #evaluating }
Op_Neq >> evaluateWithArguments: args [
	^ args first ~= args second
]

{ #category : #accessing }
Op_Neq >> numArgs [
	^2
]

{ #category : #semantics }
Op_Neq >> spriteExpr [
	^EImm imm: (ECon prim: (PBin primOp: BNe new))
]
