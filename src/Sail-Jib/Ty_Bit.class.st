Class {
	#name : #'Ty_Bit',
	#superclass : #Ty,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_Bit class >> inducedParser [
	^'%bit' asParser
	==> [ :_ | self uniqueInstance ]
]

{ #category : #'instance creation' }
Ty_Bit class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self basicNew ]

]

{ #category : #copying }
Ty_Bit >> copy [
	^self
]
