Class {
	#name : #'Ty_Union',
	#superclass : #Ty,
	#instVars : [
		'id'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_Union class >> inducedParser [
	^ '%union' asParser trim
	, JibParser id
	construct: #(- id)
]

{ #category : #printing }
Ty_Union >> printOn: aStream [
	aStream nextPutAll: '%union '.
	aStream nextPutAll: id
]

{ #category : #'formal semantics' }
Ty_Union >> spriteType [
	^Data
		name: #ident
		vars: #idents
		rvars: #rvars
		ctors: #bindToRType_Assocs
		inv: #inv
]
