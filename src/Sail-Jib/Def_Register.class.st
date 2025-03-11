Class {
	#name : #'Def_Register',
	#superclass : #JibDef,
	#instVars : [
		'id',
		'ty',
		'instrs'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Def_Register class >> inducedParser [
	^ 'register' asParser trim
	, JibParser id trim
	, $: asParser trim
	, Ty asParser trim
	, (JibInstr asParser, $; asParser trim ==> #first) star braces optional
	construct: #(- id - ty -)
]

{ #category : #enumerating }
Def_Register >> childrenDo: aBlock [
	aBlock value: ty.
	instrs notNil ifTrue:[
		instrs do: aBlock
	].
	
]

{ #category : #accessing }
Def_Register >> id [
	^ id
]

{ #category : #printing }
Def_Register >> printOn: aStream [
	aStream nextPut: (Character codePoint: 16rAE).
	aStream nextPutAll: id zdecode.
	aStream nextPutAll: ' ∷ '.
	ty printOn: aStream
]
