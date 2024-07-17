Class {
	#name : #Ty,
	#superclass : #Object,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty class >> adtSummands [
	^{
		Ty_I64.
		Ty_I128.
		Ty_Bits.
		Ty_AnyBits.
		Ty_Unit.
		Ty_Bool.
		Ty_Bit.
		Ty_String.
		Ty_Real.
		Ty_Enum.
		Ty_Vector.
		Ty_FixedVector.
		Ty_Float.
		Ty_List.
		Ty_RoundingMode.
		Ty_Ref.
		Ty_Union.
		Ty_Struct
	}
]

{ #category : #syntax }
Ty class >> constructNewFrom: anArray accordingTo: fields [
	^(super constructNewFrom: anArray accordingTo: fields) spriteType
]

{ #category : #'formal semantics' }
Ty >> spriteType [
	^self subclassResponsibility
]
