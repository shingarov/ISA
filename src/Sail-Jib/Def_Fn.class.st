Class {
	#name : #'Def_Fn',
	#superclass : #JibDef,
	#instVars : [
		'name',
		'args',
		'body'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Def_Fn class >> inducedParser [
	^ 'fn' asParser trim
	, JibParser id trim
	, JibParser id trim commaList
	, (JibInstr inducedParser, $; asParser trim ==> #first) star braces trim
	construct: #(- name args body)
]

{ #category : #initialization }
Def_Fn >> addTo: aJibProgram [
	aJibProgram values
		at: name
		put: self.
	self elaborateIn: aJibProgram
]

{ #category : #'Hindley-Milner' }
Def_Fn >> elaborateIn: aJibProgram [
	"self shouldBeImplemented."  "the most interesting thing!"
]

{ #category : #printing }
Def_Fn >> printOn: aStream [
	aStream
		nextPutAll: 'fn ';
		nextPutAll: name zdecode
]

{ #category : #'Hindley-Milner' }
Def_Fn >> unifyHmTypesIn: Γ₀ [
	| Γ myType argTypes returnType |
	Γ := Γ₀ copy.
	myType := Γ at: name.
	argTypes := myType dom.
	(args zip: argTypes) doAssociations: [ :arg :itsType | Γ
		at: arg
		ifPresent: [ self error: 'args cant shadow external names' ]
		ifAbsentPut: itsType
  ].
	returnType := myType cod.
	Γ
		at: 'return'
		ifPresent: [ self error: 'multiple types for return' ]
		ifAbsentPut: returnType. 
	body inject: Γ into: [ :soFarΓ :thisInstr | thisInstr unifyHmTypesIn: soFarΓ ].
	"shall we do anything else here?"
	^Γ₀

	 
]
