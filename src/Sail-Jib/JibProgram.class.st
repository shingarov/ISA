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

{ #category : #lookup }
JibProgram >> lookupFunction: id [
	^ defs detect:[:def | def isFn and:[def id = id]] ifNone:[self error:'No ''fn'' named ''' , id , ''''].

]

{ #category : #lookup }
JibProgram >> lookupFunctionSignature: id [
	^ defs detect:[:def | def isVal and:[def id = id]] ifNone:[self error:'No ''val'' named ''' , id , ''''].

]

{ #category : #accessing }
JibProgram >> program [
	^ self
]
