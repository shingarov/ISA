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

{ #category : #accessing }
Box >> l [
	^ l
]

{ #category : #accessing }
Box >> l: anObject [
	l := anObject
]
