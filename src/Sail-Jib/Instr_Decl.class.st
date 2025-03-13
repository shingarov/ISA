Class {
	#name : #'Instr_Decl',
	#superclass : #JibInstr,
	#instVars : [
		'id',
		'ty'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Instr_Decl class >> inducedParser [
	^ JibParser id
	, $: asParser trim
	, Ty asParser
	, JibSourceLoc asParser
	construct: #(id - ty sourceLoc)

"
Instr_Decl inducedParser parse: 'zz40 : %bool `6 131:25-134:1'
"
]

{ #category : #enumerating }
Instr_Decl >> childrenDo: aBlock [
	aBlock value: ty.
	aBlock value: sourceLoc 
	
]

{ #category : #accessing }
Instr_Decl >> id [
	^ id
]

{ #category : #printing }
Instr_Decl >> printOn: aStream [
	"BOGUS: why id is not Loc_Id?"
	aStream nextPutAll: id.
	aStream nextPutAll: ' : '.
	ty printOn: aStream
]
