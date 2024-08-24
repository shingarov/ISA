Class {
	#name : #Box,
	#superclass : #Object,
	#instVars : [
		'l'
	],
	#category : #'Sail-Jib'
}

{ #category : #'instance creation' }
Box class >> new [
	self shouldNotImplement
]

{ #category : #'instance creation' }
Box class >> with: l [
	^self basicNew
		l: l;
		yourself
]

{ #category : #enumerating }
Box >> defdIdsDo: aBlock [
	l defdIdsDo: aBlock
]

{ #category : #accessing }
Box >> l [
	^ l
]

{ #category : #accessing }
Box >> l: anObject [
	l := anObject
]

{ #category : #printing }
Box >> printOn: aStream [
	l printOn: aStream
]
