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
Op_Neq >> spriteRType [
	| t bool |

	t := TBase b: (TVar symbol: 't') r: Reft new known.
	bool := TBase b: TBool instance r: Reft new known.

	^TAll
		var: 't'
		type: (t ==> (t ==> bool))
]
