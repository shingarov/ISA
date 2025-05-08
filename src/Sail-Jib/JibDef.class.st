Class {
	#name : #JibDef,
	#superclass : #JibProgramNode,
	#instVars : [
		'loc'
	],
	#category : #'Sail-Jib'
}

{ #category : #parsing }
JibDef class >> inducedParser [
	"Return a parser that parses this node. Never call this
	 directly from other #inducedParser implementations, use
	 #asParser instead!"

	^ Def_Enum asParser
	/ Def_Files asParser
	/ Def_Fn asParser
	/ Def_Let asParser
	/ Def_Mangled asParser
	/ Def_TupleStruct asParser
	/ Def_Register asParser
	/ Def_Struct asParser
	/ Def_Union asParser
	/ Def_Val asParser
	/ Def_Extern asParser

]

{ #category : #testing }
JibDef class >> isAbstract [
	^self == JibDef
]

{ #category : #testing }
JibDef >> isEnum [
	^ false
]

{ #category : #testing }
JibDef >> isExtern [
	^false
]

{ #category : #testing }
JibDef >> isFiles [
	^false
]

{ #category : #testing }
JibDef >> isFn [
	^false
]

{ #category : #testing }
JibDef >> isLet [
	^ false
]

{ #category : #testing }
JibDef >> isRegister [
	^false
]

{ #category : #testing }
JibDef >> isVal [
	^false
]

{ #category : #initialization }
JibDef >> setParent: aJibProgram [
	self assert:(aJibProgram isKindOf: JibProgram).
	self assert: parent isNil description: 'Attempting to set parent twice'.

	parent := aJibProgram

]
