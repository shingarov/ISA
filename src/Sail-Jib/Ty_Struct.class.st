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
