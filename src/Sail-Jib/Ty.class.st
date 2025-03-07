Class {
	#name : #Ty,
	#superclass : #JibProgramNode,
	#category : #'Sail-Jib'
}

{ #category : #parsing }
Ty class >> inducedParser [
	^	Ty_I64 asParser
	/	Ty_I128 asParser
	/	Ty_Bits asParser
	/	Ty_AnyBits asParser
	/	Ty_Unit asParser
	/	Ty_Bool asParser
	/	Ty_Bit asParser
	/	Ty_String asParser
	/	Ty_Real asParser
	/	Ty_Enum asParser
	/	Ty_Vector asParser
	/	Ty_FixedVector asParser
	/	Ty_Float asParser
	/	Ty_List asParser
	/	Ty_RoundingMode asParser
	/	Ty_Ref asParser
	/	Ty_Union asParser
	/	Ty_Struct asParser

]

{ #category : #testing }
Ty class >> isAbstract [
	^self == Ty
]

{ #category : #'formal semantics' }
Ty >> spriteType [
	^self subclassResponsibility
]
