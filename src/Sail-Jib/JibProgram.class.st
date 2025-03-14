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

{ #category : #enumerating }
JibProgram >> functionSignaturesDo: aBlock [
	defs do: [ :def | def isVal ifTrue:[ aBlock value: def ] ]
	
]

{ #category : #enumerating }
JibProgram >> functionsDo: aBlock [
	defs do: [ :def | (def isFn or:[def isExtern]) ifTrue:[ aBlock value: def ] ]
]

{ #category : #lookup }
JibProgram >> lookupFunction: id [
	self functionsDo: [ :fn | fn id = id ifTrue:[ ^fn ] ].
	self error:'No ''fn'' named ''' , id , ''''.
]

{ #category : #lookup }
JibProgram >> lookupFunctionSignature: id [
	self functionSignaturesDo: [ :fn | fn id = id ifTrue:[ ^fn ] ].
	self error:'No ''val'' named ''' , id , ''''.

]

{ #category : #accessing }
JibProgram >> program [
	^ self
]

{ #category : #enumerating }
JibProgram >> registersDo: aBlock [
	defs do: [ :def | def isRegister ifTrue:[ aBlock value: def ] ]

]
