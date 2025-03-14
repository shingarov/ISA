Class {
	#name : #JibPrim,
	#superclass : #Object,
	#instVars : [
		'signature'
	],
	#category : #'Sail-Jib'
}

{ #category : #accessing }
JibPrim class >> id [
	^ self subclassResponsibility
]

{ #category : #testing }
JibPrim class >> isAbstract [
	^self == JibPrim
]

{ #category : #accessing }
JibPrim class >> signature [
	"Return this primt's signature (as fabricated instance of `Def_Val`).
	 This is needed for type unification."

	^ self subclassResponsibility



]

{ #category : #evaluating }
JibPrim >> evaluateWithArguments: args [
	^ self subclassResponsibility 
]

{ #category : #accessing }
JibPrim >> id [
	"Return the name (id) of this prim.

	 Do not override this method, override class-side #id!"

	^self class id
]

{ #category : #testing }
JibPrim >> isExtern [
	^ false
]

{ #category : #accessing }
JibPrim >> signature [
	"Return this prim's signature (as fabricated instance of `Def_Val`).

	 Do not override this method, override class-side #signature!"

	signature isNil ifTrue:[
		signature := self class signature
	].
	^signature
]
