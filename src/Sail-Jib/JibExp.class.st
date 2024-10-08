Class {
	#name : #JibExp,
	#superclass : #Object,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
JibExp class >> adtSummands [
	^{
		Exp_Kind.
		Exp_Unwrap.
		Exp_Bool.
		Exp_Bits.
		Exp_Unit.
		Exp_String.
		Exp_Struct.
		Exp_I128.
		Exp_I64.
		Exp_Field.
		Exp_Call.
		Exp_Id
	}
]

{ #category : #enumerating }
JibExp >> usedIdsDo: aBlock [
	"Evaluate `aBlock` for each id used (read, accessed) by this expression"
	
]
