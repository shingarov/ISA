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
JibPrim >> numArgs [
	^self subclassResponsibility
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

{ #category : #semantics }
JibPrim >> spriteEFun [
		^ (self numArgs to: 1 by: -1)
			inject: (EImm imm: (ECon prim: PUnknown new))
			into: [ :expr :argIdx | EFun bind: (SpriteBind id: 'a' , argIdx printString) expr: expr ]
]

{ #category : #semantics }
JibPrim >> spriteRType [
	^ self subclassResponsibility
]

{ #category : #semantics }
JibPrim >> spriteVal [
	^Val
		symbol: self id
		rtype: self spriteRType
		metric: nil
]
