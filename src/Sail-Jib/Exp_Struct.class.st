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
