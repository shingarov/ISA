Class {
	#name : #'Def_Register',
	#superclass : #JibDefWithCode,
	#instVars : [
		'id',
		'ty'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Def_Register class >> inducedParser [
	^ 'register' asParser trim
	, JibParser id trim
	, $: asParser trim
	, Ty asParser trim
	, ((JibInstr asParser, $; asParser trim ==> #first) star braces optional ==> [ :x|x ifNil:#() ])
	construct: #(- id - ty instrs)
]

{ #category : #enumerating }
Def_Register >> childrenDo: aBlock [
	aBlock value: ty.
	instrs notNil ifTrue:[
		instrs do: aBlock
	].
	
]

{ #category : #printing }
Def_Register >> displayStringOn: aStream [
	aStream nextPutAll: 'register '.
	aStream nextPutAll: id zdecode.

]

{ #category : #accessing }
Def_Register >> id [
	^ id
]

{ #category : #testing }
Def_Register >> isRegister [
	^ true
]

{ #category : #accessing }
Def_Register >> regType [
	^ ty

]

{ #category : #printing }
Def_Register >> unparseOn: aStream [
	aStream nextPutAll: 'register '.
	aStream nextPutAll: id.
	aStream nextPutAll: ' : '.
	ty unparseOn: aStream.
	instrs notNil ifTrue:[
		aStream nextPutAll: ' {…}'
	]

]
