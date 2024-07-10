Class {
	#name : #'Loc_Id',
	#superclass : #JibLoc,
	#instVars : [
		'id'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Loc_Id class >> inducedParser [
	^ (PPSequenceParser with: JibParser id)
	construct: #(id)
	
"
JibLoc inducedParser parse: 'xyz'
"
]

{ #category : #'Hindley-Milner' }
Loc_Id >> typeIn: Γ [
	^Γ at: id
]
