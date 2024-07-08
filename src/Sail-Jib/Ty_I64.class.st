Class {
	#name : #'Ty_I64',
	#superclass : #Ty,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_I64 class >> inducedParser [
	^'%i64' asParser
	==> [ :_ | self uniqueInstance ]
]

{ #category : #'instance creation' }
Ty_I64 class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self basicNew ]
]

{ #category : #printing }
Ty_I64 >> printOn: aStream [
	aStream nextPutAll: '%i64'
]
