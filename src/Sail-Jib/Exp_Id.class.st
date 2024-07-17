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

{ #category : #'as yet unclassified' }
Exp_Id >> toSpriteExprIn: aJibFnEnvironment [ 
	^EImm imm: (EVar of: id)
]
