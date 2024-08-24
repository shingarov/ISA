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

{ #category : #accessing }
Exp_Id >> id [
	^ id
]

{ #category : #printing }
Exp_Id >> printOn: aStream [
	aStream nextPutAll: id
]

{ #category : #'formal semantics' }
Exp_Id >> toSpriteExprIn: aJibFnEnvironment [ 
	^EImm imm: (EVar of: id)
]

{ #category : #enumerating }
Exp_Id >> usedIdsDo: aBlock [
	aBlock value: id
	
]

{ #category : #'deterministic interpretation' }
Exp_Id >> valueIn: aContext [ 
	^aContext at: id
]
