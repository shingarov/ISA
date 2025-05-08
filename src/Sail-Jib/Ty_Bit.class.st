Class {
	#name : #'Ty_Bit',
	#superclass : #Ty,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_Bit class >> inducedParser [
	^'%bit' asParser
	==> [ :_ | self new ]
]

{ #category : #accessing }
Ty_Bit >> sort [
	^ self environment context mkBvSort: 1
]

{ #category : #printing }
Ty_Bit >> unparseOn: aStream [
	aStream nextPutAll:'%bit'
]
