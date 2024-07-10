Class {
	#name : #'Ty_Vector',
	#superclass : #Ty,
	#instVars : [
		'aliases',
		'length',
		'ty'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_Vector class >> fvecParser [
	^ '%fvec' asParser trim
	, (
	    PPParser decimalNat,
	    $, asParser trim,
	    (Context readState: #parentInducedParser)
	    construct: #(length - ty)
	  ) parens
	==> #second
]

{ #category : #syntax }
Ty_Vector class >> inducedParser [
	^ self fvecParser / self vecParser
]

{ #category : #syntax }
Ty_Vector class >> vecParser [
	^ '%vec' asParser
	, (Context readState: #parentInducedParser) parens
	construct: #(- ty)
]

{ #category : #private }
Ty_Vector >> addAlias: someone [
	someone == self ifTrue: [ ^self ].
	self aliases add: someone
]

{ #category : #accessing }
Ty_Vector >> aliases [
	aliases isNil ifTrue: [ aliases := Set new ].
	^ aliases
]

{ #category : #accessing }
Ty_Vector >> aliases: anObject [
	aliases := anObject
]

{ #category : #private }
Ty_Vector >> ensureSameLength: rhs [
	length = rhs length ifFalse: [ Incompatible signal ].
	^self
]

{ #category : #accessing }
Ty_Vector >> length [
	^ length
]

{ #category : #accessing }
Ty_Vector >> length: anObject [
	length := anObject
]

{ #category : #printing }
Ty_Vector >> printFixedOn: aStream [
	aStream nextPutAll: '%vec('.
	ty printOn: aStream.
	aStream nextPut: $)
	
]

{ #category : #printing }
Ty_Vector >> printOn: aStream [
	length isNil
		ifTrue: [ self printVariableOn: aStream ]
		ifFalse: [ self printFixedOn: aStream ]
]

{ #category : #printing }
Ty_Vector >> printVariableOn: aStream [
	aStream nextPutAll: '%fvec('.
	length printOn: aStream.
	aStream nextPutAll: ', '.
	ty printOn: aStream.
	aStream nextPut: $)
	
]

{ #category : #accessing }
Ty_Vector >> ty [
	^ ty
]

{ #category : #accessing }
Ty_Vector >> ty: anObject [
	ty := anObject
]

{ #category : #'Hindley-Milner' }
Ty_Vector >> unify: rhs [
	(rhs isKindOf: Ty_Vector) ifFalse: [ ^Incompatible signal ].
	^length isNil
		ifTrue: [ self unifyUnknownLength: rhs ]
		ifFalse: [ self unifyKnownLength: rhs ]
]

{ #category : #private }
Ty_Vector >> unifyKnownLength: rhs [
	rhs length isNil ifFalse: [ ^self ensureSameLength: rhs ]	.
	^rhs unifyUnknownLength: self
]

{ #category : #private }
Ty_Vector >> unifyUnknownLength: rhs [
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
