Class {
	#name : #'Ty_AnyBits',
	#superclass : #Ty,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_AnyBits class >> inducedParser [
	^'%bv' asParser
	==> [ :_ | self new ]
]

{ #category : #accessing }
Ty_AnyBits >> sort [
	^ self shouldNotImplement 
]

{ #category : #semantics }
Ty_AnyBits >> spriteRType [
	^TCon
		c: 'BitVec'
		ts: { TBvSize c: 'SizeXX' ts: #() ars: #() r: Reft new known }
		ars: {}
		r: Reft new known
		
	"
	Ty_AnyBits new spriteRType 
	"
]

{ #category : #printing }
Ty_AnyBits >> unparseOn: aStream [
	aStream nextPutAll: '%bv'
]
