Class {
	#name : #JibUnknownUniqueSourceLoc,
	#superclass : #Object,
	#instVars : [
		'u'
	],
	#category : #'Sail-Jib'
}

{ #category : #'instance creation' }
JibUnknownUniqueSourceLoc class >> u: u [
	^self basicNew
		u: u;
		yourself
]

{ #category : #printing }
JibUnknownUniqueSourceLoc >> printOn: aString [
	aString nextPut: $`.
	u printOn: aString
]

{ #category : #accessing }
JibUnknownUniqueSourceLoc >> u [
	^ u
]

{ #category : #accessing }
JibUnknownUniqueSourceLoc >> u: anObject [
	u := anObject
]
