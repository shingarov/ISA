Class {
	#name : #'Ty_Unit',
	#superclass : #Ty,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_Unit class >> inducedParser [
	^'%unit' asParser
	==> [ :_ | self uniqueInstance ]
]

{ #category : #'instance creation' }
Ty_Unit class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self basicNew ]
]
