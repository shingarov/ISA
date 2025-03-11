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

{ #category : #printing }
SourceLoc_UnknownUnique >> printOn: aString [
	aString nextPut: $`.
	u printOn: aString
]
