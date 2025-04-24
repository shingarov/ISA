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
	    Ty asParser
	    construct: #(length - ty)
	  ) parens
	==> #second
]

{ #category : #enumerating }
Ty_FixedVector >> childrenDo: aBlock [
	aBlock value: ty
	
]

{ #category : #'instance creation' }
Ty_FixedVector >> newUndefined [
	^Array new: length withAll: ty newUndefined "BOGUS, fix once we have type elaboration in place"
]

{ #category : #printing }
Ty_FixedVector >> unparseOn: aStream [
	aStream nextPutAll: '%fvec ('.
	length printOn: aStream.
	aStream nextPutAll: ', '.
	ty unparseOn: aStream.
	aStream nextPut: $)
	
]
