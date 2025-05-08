Class {
	#name : #'Ty_I128',
	#superclass : #Ty,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_I128 class >> inducedParser [
	^'%i' asParser
	==> [ :_ | self new ]
]

{ #category : #accessing }
Ty_I128 >> sort [
	^ self environment context mkIntSort 
]

{ #category : #printing }
Ty_I128 >> unparseOn: aStream [
	aStream nextPutAll: '%i128'
]
