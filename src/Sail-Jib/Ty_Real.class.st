Class {
	#name : #'Ty_Real',
	#superclass : #Ty,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_Real class >> inducedParser [
	^'%real' asParser
	==> [ :_ | self new ]
]

{ #category : #accessing }
Ty_Real >> sort [
	^ self environment context mkRealSort 
]

{ #category : #printing }
Ty_Real >> unparseOn: aStream [
	aStream nextPutAll:'%real'
]
