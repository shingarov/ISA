Class {
	#name : #'Ty_Struct',
	#superclass : #Ty,
	#instVars : [
		'id'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_Struct class >> inducedParser [
	^(PPSequenceParser with:
		( '%struct' asParser trim
		, JibParser id
		) ==> #second
	) construct: #(id)
]

{ #category : #'formal semantics' }
Ty_Struct >> spriteType [
	^Data
		name: #ident
		vars: #idents
		rvars: #rvars
		ctors: #bindToRType_Assocs
		inv: #inv
]
