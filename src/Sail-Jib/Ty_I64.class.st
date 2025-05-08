Class {
	#name : #'Ty_I64',
	#superclass : #Ty,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_I64 class >> inducedParser [
	^'%i64' asParser
	==> [ :_ | self new ]
]

{ #category : #accessing }
Ty_I64 >> sort [
	^ self environment context mkIntSort 
]

{ #category : #printing }
Ty_I64 >> unparseOn: aStream [
	aStream nextPutAll: '%i64'
]
