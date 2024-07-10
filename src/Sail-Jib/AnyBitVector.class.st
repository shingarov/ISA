Class {
	#name : #AnyBitVector,
	#superclass : #Object,
	#instVars : [
		'v'
	],
	#category : #'Sail-Jib'
}

{ #category : #'instance creation' }
AnyBitVector class >> with: anInteger [ 
	^self basicNew
		v: anInteger;
		yourself
]

{ #category : #'Hindley-Milner' }
AnyBitVector >> length [
	^nil
]

{ #category : #accessing }
AnyBitVector >> v [
	^ v
]

{ #category : #accessing }
AnyBitVector >> v: anObject [
	v := anObject
]
