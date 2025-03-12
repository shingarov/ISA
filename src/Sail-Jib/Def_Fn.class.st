Class {
	#name : #'Def_Fn',
	#superclass : #JibDef,
	#instVars : [
		'id',
		'ids',
		'instrs',
		'blocks'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Def_Fn class >> inducedParser [
	^ 'fn' asParser trim
	, JibParser id trim
	, JibParser id trim commaList
	, (JibInstr asParser, $; asParser trim ==> #first) star braces
	construct: #(- id ids instrs)
]

{ #category : #accessing }
Def_Fn >> argNames [
	^ ids
]

{ #category : #accessing }
Def_Fn >> blocks [
	blocks isNil ifTrue:[
		blocks := JibFnBodyBlock analyze: self.
	].
	^ blocks
]

{ #category : #enumerating }
Def_Fn >> childrenDo: aBlock [
	instrs do: aBlock
	
]

{ #category : #inspecting }
Def_Fn >> gtInstrsIn: composite [
	<gtInspectorPresentationOrder: 40>

	^ composite fastList
		title: 'Instructions';
		display: [ instrs ];
		format: [ :insn | insn ]
]

{ #category : #accessing }
Def_Fn >> id [
	^ id
]

{ #category : #accessing }
Def_Fn >> instrs [
	^ instrs
]

{ #category : #testing }
Def_Fn >> isFn [
	^true
]

{ #category : #printing }
Def_Fn >> printOn: aStream [
	aStream
		nextPutAll: 'fn ';
		nextPutAll: id zdecode
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
