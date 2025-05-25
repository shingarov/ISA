Class {
	#name : #'Exp_Struct',
	#superclass : #JibExp,
	#instVars : [
		'id',
		'fields'
	],
	#category : #'Sail-Jib'
}

{ #category : #enumerating }
Exp_Struct >> childrenDo: aBlock [
	fields do:[:field | aBlock value: field value ] 
	
]

{ #category : #accessing }
Exp_Struct >> fieldExprs [
	"Return just the field expresions (values) as an array in order
	 in which they appear in struct definition (which is the order of
	 parameters for its constructor)"

	| def map |

	def := self program lookupStruct: id.
	map := Dictionary newFromAssociations: fields.
	^def fields collect:[:nameAndType | map at: nameAndType key ].
]

{ #category : #semantics }
Exp_Struct >> spriteExpr [
	^ ΛEApp mkEApp: (EImm imm: (EVar of: id)) args: (self fieldExprs collect:#spriteExpr)

]

{ #category : #printing }
Exp_Struct >> unparseOn: aStream [
	aStream nextPutAll: 'struct '.
	aStream nextPutAll: id.
	aStream nextPutAll: ' { '.
	fields do:[:field|
		aStream nextPutAll: field key.
		aStream nextPutAll: ' = '.
		field value unparseOn: aStream.
	] separatedBy:[
		aStream nextPutAll: ', '.
	].
	aStream nextPutAll: ' }'.
]
