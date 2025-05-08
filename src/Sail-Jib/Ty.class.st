Class {
	#name : #Ty,
	#superclass : #JibProgramNode,
	#classVars : [
		'UndefinedValue'
	],
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

{ #category : #initialization }
Ty class >> initialize [
	UndefinedValue := '<undefined>' copy.
]

{ #category : #testing }
Ty class >> isAbstract [
	^self == Ty
]

{ #category : #enumerating }
Ty >> childrenDo: aBlock [
	"Most of types are leaf nodes, do nothing by default"
	
]

{ #category : #accessing }
Ty >> sort [
	"Return the Z3 sort representing this (Jib) type."
	^ self subclassResponsibility 
]

{ #category : #'instance creation' }
Ty >> newUndefined [
	"Return 'undefined' value of this type. This will be the initial
	 value before first assignment."
	
	^UndefinedValue "BOGUS, fix once we have type elaboration in place"
]
