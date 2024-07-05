Class {
	#name : #'Ty_FixedVector',
	#superclass : #Ty,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_FixedVector class >> inducedParser [
	^ '%fvec' asParser trim
	, (
	    PPParser decimalNat,
	    $, asParser trim,
	    (Context readState: #parentInducedParser)
	  ) parens
]
