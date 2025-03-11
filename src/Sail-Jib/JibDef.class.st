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
