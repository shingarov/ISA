Class {
	#name : #'Op_Not',
	#superclass : #JibOp,
	#category : #'Sail-Jib'
}

{ #category : #accessing }
Op_Not class >> id [
	^ '@not'
]

{ #category : #evaluating }
Op_Not >> evaluateWithArguments: args [
	^ args first not
]

{ #category : #accessing }
Op_Not >> numArgs [
	^1
]

{ #category : #semantics }
Op_Not >> spriteRType [
	| bool |

	bool := TBase b: TBool instance r: Reft new known.

	^bool ==> bool
]
