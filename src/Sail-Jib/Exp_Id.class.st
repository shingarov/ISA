Class {
	#name : #'Exp_Id',
	#superclass : #JibExp,
	#instVars : [
		'id'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Exp_Id class >> inducedParser [
	^ (PPSequenceParser with: JibParser id)
	construct: #(id)
	
"
JibExp inducedParser parse: 'xyz'
"
]

{ #category : #'formal semantics' }
Exp_Id >> toSpriteExprIn: aJibFnEnvironment [ 
	^EImm imm: (EVar of: id)
]

{ #category : #'deterministic interpretation' }
Exp_Id >> valueIn: aContext [ 
	^aContext at: id
]
