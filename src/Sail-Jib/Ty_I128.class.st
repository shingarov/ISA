Class {
	#name : #'Ty_I128',
	#superclass : #Ty,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_I128 class >> inducedParser [
	^'%i' asParser
	==> [ :_ | self uniqueInstance ]
]

{ #category : #'instance creation' }
Ty_I128 class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self basicNew ]
]

{ #category : #copying }
Ty_I128 >> copy [
	^self
]

{ #category : #printing }
Ty_I128 >> printOn: aStream [
	aStream nextPutAll: '%i128'
]
