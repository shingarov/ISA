Class {
	#name : #'Ty_Bool',
	#superclass : #Ty,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_Bool class >> inducedParser [
	^'%bool' asParser
	==> [ :_ | self uniqueInstance ]
]

{ #category : #'instance creation' }
Ty_Bool class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self basicNew ]
]

{ #category : #printing }
Ty_Bool >> printOn: aStream [
	aStream nextPutAll: '%bool'
]
