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

{ #category : #accessing }
Def_Fn >> id [
	^ id
]

{ #category : #accessing }
Def_Fn >> instrs [
	^ instrs
]

{ #category : #printing }
Def_Fn >> printOn: aStream [
	aStream
		nextPutAll: 'fn ';
		nextPutAll: id zdecode
]
