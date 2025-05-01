Class {
	#name : #JibProgram,
	#superclass : #JibProgramNode,
	#instVars : [
		'defs'
	],
	#category : #'Sail-Jib'
}

{ #category : #parsing }
JibProgram class >> inducedParser [
	^(PPSequenceParser with: JibDef asParser plus)
	construct: #(defs)

]

{ #category : #enumerating }
JibProgram >> childrenDo: aBlock [
	defs do: aBlock
	
]

{ #category : #analysis }
JibProgram >> doSemanticAnalysis [
	"TODO: This remains to be implemented"
	self toSpriteProg
]

{ #category : #enumerating }
JibProgram >> functionDefs [
	^defs select: #isFn
]

{ #category : #enumerating }
JibProgram >> functionSignatures [
	^defs select: #isVal
]

{ #category : #enumerating }
JibProgram >> functionsDo: aBlock [
	defs do: [ :def | (def isFn or:[def isExtern]) ifTrue:[ aBlock value: def ] ]
]

{ #category : #enumerating }
JibProgram >> letDefs [
	^defs select: #isLet
]

{ #category : #enumerating }
JibProgram >> letsDo: aBlock [
	defs do: [ :def | def isLet ifTrue:[ aBlock value: def ] ]

]

{ #category : #lookup }
JibProgram >> lookupFunction: id [
	self functionsDo: [ :fn | fn id = id ifTrue:[ ^fn ] ].
	self error:'No ''fn'' named ''' , id , ''''.
]

{ #category : #lookup }
JibProgram >> lookupFunctionSignature: id [
	^self functionSignatures
		detect: [ :x | x id = id ]
		ifNone: [ self error:'No ''val'' named ''' , id , '''' ]
]

{ #category : #accessing }
JibProgram >> program [
	^ self
]

{ #category : #enumerating }
JibProgram >> registerDefs [
	^defs select: #isRegister
]

{ #category : #enumerating }
JibProgram >> registersDo: aBlock [
	defs do: [ :def | def isRegister ifTrue:[ aBlock value: def ] ]

]

{ #category : #'as yet unclassified' }
JibProgram >> terminalInt [
	^EImm imm: (ECon prim: (PInt integer: 0))
]

{ #category : #'as yet unclassified' }
JibProgram >> toSpriteProg [
	| fns expr |
	fns := self functionDefs.
	expr := fns reversed
		inject: self terminalInt
		into: [ :soFar :thisTime |
			ELet
				decl: thisTime toSpriteDecl
				expr: soFar
		]
]
