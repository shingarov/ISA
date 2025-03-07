Class {
	#name : #Ty,
	#superclass : #JibProgramNode,
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

{ #category : #testing }
Ty class >> isAbstract [
	^self == Ty
]

{ #category : #'formal semantics' }
Ty >> spriteType [
	^self subclassResponsibility
]
