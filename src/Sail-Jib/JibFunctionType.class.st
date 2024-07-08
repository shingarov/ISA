Class {
	#name : #JibFunctionType,
	#superclass : #Ty,
	#instVars : [
		'dom',
		'cod'
	],
	#category : #'Sail-Jib'
}

{ #category : #'instance creation' }
JibFunctionType class >> dom: d cod: c [
	^self basicNew
		dom: d;
		cod: c;
		yourself
]

{ #category : #accessing }
JibFunctionType >> cod [
	^ cod
]

{ #category : #accessing }
JibFunctionType >> cod: anObject [
	cod := anObject
]

{ #category : #accessing }
JibFunctionType >> dom [
	^ dom
]

{ #category : #accessing }
JibFunctionType >> dom: anObject [
	dom := anObject
]

{ #category : #printing }
JibFunctionType >> printOn: aStream [
	aStream nextPut: $(.
	dom do: (□ printOn: aStream) separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPutAll: ') -> '.
	cod printOn: aStream
]
