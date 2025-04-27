Class {
	#name : #'SourceLoc_Unknown',
	#superclass : #JibSourceLoc,
	#instVars : [
		'u'
	],
	#category : #'Sail-Jib'
}

{ #category : #parsing }
SourceLoc_Unknown class >> inducedParser [
	^ nil asParser ==> [ :_ | self new ]
]

{ #category : #comparing }
SourceLoc_Unknown >> = another [
	^ self == another
]

{ #category : #comparing }
SourceLoc_Unknown >> hash [
	^ self identityHash
]

{ #category : #printing }
SourceLoc_Unknown >> unparseOn: aStream [
	"Nothing"

]
