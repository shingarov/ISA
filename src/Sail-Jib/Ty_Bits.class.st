Class {
	#name : #'Ty_Bits',
	#superclass : #Ty,
	#instVars : [
		'aliases',
		'length'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_Bits class >> inducedParser [
	^ '%bv' asParser
	, (#digit asParser plus optional flatten ==> #asInteger)
	construct: #(- length)
]

{ #category : #'instance creation' }
Ty_Bits class >> new [
	"Instantiate a *new* %bv
	 (i.e., self new ≠ self new)"
	^self basicNew
]

{ #category : #'instance creation' }
Ty_Bits class >> new: N [
	"Instantiate %bvN"
	^self basicNew
		length: N;
		yourself
]

{ #category : #private }
Ty_Bits >> addAlias: someone [
	someone == self ifTrue: [ ^self ].
	self aliases add: someone
]

{ #category : #accessing }
Ty_Bits >> aliases [
	aliases isNil ifTrue: [ aliases := Set new ].
	^ aliases
]

{ #category : #accessing }
Ty_Bits >> aliases: anObject [
	aliases := anObject
]

{ #category : #private }
Ty_Bits >> ensureSameLength: rhs [
	length = rhs length ifFalse: [ Incompatible signal ].
	^self
			
]

{ #category : #accessing }
Ty_Bits >> length [
	^ length
]

{ #category : #accessing }
Ty_Bits >> length: anObject [
	length := anObject
]

{ #category : #printing }
Ty_Bits >> printOn: aStream [
	aStream nextPutAll: '%bv'.
	length isNil ifFalse: [length printOn: aStream]
]

{ #category : #'Hindley-Milner' }
Ty_Bits >> unify: rhs [
	(rhs isKindOf: Ty_Bits) ifFalse: [ ^Incompatible signal ]. "can't unify BV with anything else"
	^length isNil
		ifTrue: [ self unifyUnknownLength: rhs ]
		ifFalse: [ self unifyKnownLength: rhs ]	
	
]

{ #category : #private }
Ty_Bits >> unifyKnownLength: rhs [
	rhs length isNil ifFalse: [ ^self ensureSameLength: rhs ]	.
	^rhs unifyUnknownLength: self

]

{ #category : #'as yet unclassified' }
Ty_Bits >> unifyUnknownLength: rhs [
	rhs length isNil
		ifFalse: [
			"he knows"
			length := rhs length.
			self aliases do: [ :each | each unify: rhs ]
		] ifTrue: [
			"set up to notify the whole cloak as soon as one knows"
			self addAlias: rhs.
			rhs addAlias: self
		].
	^self
]
