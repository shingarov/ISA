Class {
	#name : #'Def_Fn',
	#superclass : #JibDefWithCode,
	#instVars : [
		'id',
		'ids'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Def_Fn class >> inducedParser [
	^ 'fn' asParser trim
	, JibParser id trim
	, (JibParser id trim commaList ==> [ :x|x ifNil:#() ])
	, (JibInstr asParser, $; asParser trim ==> #first) star braces
	construct: #(- id ids instrs)
]

{ #category : #analysis }
Def_Fn >> analyzeUsing: analyzer [
	analyzer analyzeFn: self
]

{ #category : #accessing }
Def_Fn >> argNames [
	^ ids
]

{ #category : #enumerating }
Def_Fn >> childrenDo: aBlock [
	instrs do: aBlock
	
]

{ #category : #accessing }
Def_Fn >> id [
	^ id
]

{ #category : #testing }
Def_Fn >> isFn [
	^true
]

{ #category : #accessing }
Def_Fn >> retName [
	^ 'return'
]

{ #category : #accessing }
Def_Fn >> signature [
	"Return this function's signature (as instance of `Def_Val`)."

	self assert: parent notNil.

	^parent lookupFunctionSignature: id



]

{ #category : #printing }
Def_Fn >> unparseOn: aStream [
	aStream
		nextPutAll: 'fn ';
		nextPutAll: id zdecode
]
