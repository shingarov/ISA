Class {
	#name : #JibExp,
	#superclass : #JibProgramNode,
	#category : #'Sail-Jib'
}

{ #category : #parsing }
JibExp class >> inducedParser [
	^	Exp_Field asParser
	/	Exp_Kind asParser
	/	Exp_Unwrap asParser


	/	Exp_Bits asParser
	/	Exp_Bool asParser
	/	Exp_I128 asParser
	/	Exp_I64 asParser
	/	Exp_String asParser
	/	Exp_Struct asParser
	/	Exp_Unit asParser
	/	Exp_Id asParser
	/	Exp_Call asParser





"
JibExp asParser end parse:'xyz'
JibExp asParser end parse:'xyz.foo'
Exp_Field asParser end parse:'xyz.foo'
"



]

{ #category : #testing }
JibExp class >> isAbstract [
	^self == JibExp
]

{ #category : #enumerating }
JibExp >> usedIdsDo: aBlock [
	"Evaluate `aBlock` for each id used (read, accessed) by this expression"
	
]
