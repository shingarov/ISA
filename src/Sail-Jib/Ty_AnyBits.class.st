Class {
	#name : #'Ty_AnyBits',
	#superclass : #Ty,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_AnyBits class >> inducedParser [
	^'%bv' asParser
	==> [ :_ | self uniqueInstance ]
]

{ #category : #'instance creation' }
Ty_AnyBits class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self basicNew ]
]

{ #category : #printing }
Ty_AnyBits >> printOn: aStream [
	aStream nextPutAll: '%bv'
]
