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

{ #category : #printing }
Exp_Struct >> unparseOn: aStream [
	super unparseOn: aStream.
	"
	aStream 
		nextPutAll:'...';
		nextPutAll:'...'.
	"

]
