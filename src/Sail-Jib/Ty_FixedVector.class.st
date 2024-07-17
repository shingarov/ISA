Class {
	#name : #'Ty_FixedVector',
	#superclass : #Ty,
	#instVars : [
		'length',
		'ty'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_FixedVector class >> inducedParser [
	^ '%fvec' asParser trim
	, (
	    PPParser decimalNat,
	    $, asParser trim,
	    (Context readState: #parentInducedParser)
	    construct: #(length - ty)
	  ) parens
	==> #second
]

{ #category : #printing }
Ty_FixedVector >> printOn: aStream [
	aStream nextPutAll: '%fvec ('.
	length printOn: aStream.
	aStream nextPutAll: ', '.
	ty printOn: aStream.
	aStream nextPut: $)
	
]

{ #category : #'formal semantics' }
Ty_FixedVector >> spriteType [
	self shouldBeImplemented.
]
