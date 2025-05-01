Class {
	#name : #JibInsnArray,
	#superclass : #Array,
	#type : #variable,
	#category : #'Sail-Jib'
}

{ #category : #'as yet unclassified' }
JibInsnArray >> toSpriteExpr: Γ [ 
	self assert: self isEmpty not.
	^self first toSpriteExpr: Γ andThen: self allButFirst
]
