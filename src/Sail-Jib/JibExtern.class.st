Class {
	#name : #JibExtern,
	#superclass : #JibPrim,
	#category : #'Sail-Jib'
}

{ #category : #testing }
JibExtern class >> isAbstract [
	^self == JibExtern 
]

{ #category : #accessing }
JibExtern class >> named: id [
	self allSubclassesDo: [ :cls |
		(cls isAbstract not and:[ cls id = id ]) ifTrue:[
			^cls new
		]
	].
	self error: 'No extern named ''' , id , ''''.
	
	"
	JibExtern named: 'sign_extend'
	"
]

{ #category : #testing }
JibExtern >> isExtern [
	^ true
]
