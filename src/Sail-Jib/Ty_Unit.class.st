Class {
	#name : #'Ty_Unit',
	#superclass : #Ty,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Ty_Unit class >> inducedParser [
	^'%unit' asParser
	==> [ :_ | self new ]
]

{ #category : #accessing }
Ty_Unit >> sort [
	^ self environment lookupSortForUnit.
]

{ #category : #printing }
Ty_Unit >> unparseOn: aStream [
	aStream nextPutAll:'%unit'

]
