Class {
	#name : #'SourceLoc_UnknownUnique',
	#superclass : #JibSourceLoc,
	#instVars : [
		'u'
	],
	#category : #'Sail-Jib'
}

{ #category : #parsing }
SourceLoc_UnknownUnique class >> inducedParser [
	| nat |

	nat := #digit asParser plus flatten trim ==> #asInteger.

	^ $` asParser trim
	, nat
	construct: #(- u)

]

{ #category : #comparing }
SourceLoc_UnknownUnique >> = another [
	^ self class == another class and:[u = another fileIndex]
]

{ #category : #accessing }
SourceLoc_UnknownUnique >> fileIndex [
	^u
]

{ #category : #comparing }
SourceLoc_UnknownUnique >> hash [
	^(self class hash + u hash) hashMultiply
]

{ #category : #printing }
SourceLoc_UnknownUnique >> unparseOn: aStream [
	aStream space; space.
	aStream nextPut: $`.
	u printOn: aStream
]
