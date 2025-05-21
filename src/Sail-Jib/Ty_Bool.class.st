Class {
	#name : #'Ty_Bool',
	#superclass : #Ty,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_Bool class >> inducedParser [
	^'%bool' asParser
	==> [ :_ | self new ]
]

{ #category : #accessing }
Ty_Bool >> sort [
	^ self environment context mkBoolSort 
]

{ #category : #semantics }
Ty_Bool >> spriteRType [
	^TBase
		b: TBool instance
		r: Reft new known
]

{ #category : #printing }
Ty_Bool >> unparseOn: aStream [
	aStream nextPutAll: '%bool'
]
