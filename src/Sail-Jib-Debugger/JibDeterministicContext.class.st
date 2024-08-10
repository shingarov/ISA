Class {
	#name : #JibDeterministicContext,
	#superclass : #Object,
	#instVars : [
		'fn',
		'pc',
		'args',
		'temps',
		'globals',
		'sender'
	],
	#category : #'Sail-Jib-Debugger'
}

{ #category : #accessing }
JibDeterministicContext >> args [
	^ args
]

{ #category : #accessing }
JibDeterministicContext >> args: anObject [
	args := anObject
]

{ #category : #accessing }
JibDeterministicContext >> at: name [
	^temps
		at: name
		ifAbsent: [
			globals
				at:name
				ifAbsent: [ self shouldBeImplemented ]
		]
]

{ #category : #accessing }
JibDeterministicContext >> at: name put: v [
	| newTemps |  "BOGUS, for now experimenting"
	newTemps := temps copy
		at: name
		put: v;
		yourself.
	^self copy temps: newTemps
]

{ #category : #'as yet unclassified' }
JibDeterministicContext >> declareTemp: name ofSort: aZ3Sort [
	| newTemps |
	newTemps := temps copy
		at: name
		ifPresent: [ self error: 'duplicate temp decl' ]
		ifAbsentPut: [ aZ3Sort undefinedElement ];
		yourself.
	^self copy temps: newTemps
]

{ #category : #accessing }
JibDeterministicContext >> fn [
	^ fn
]

{ #category : #accessing }
JibDeterministicContext >> fn: anObject [
	fn := anObject
]

{ #category : #accessing }
JibDeterministicContext >> globals [
	^ globals
]

{ #category : #accessing }
JibDeterministicContext >> globals: anObject [
	globals := anObject
]

{ #category : #'as yet unclassified' }
JibDeterministicContext >> incrPC [
	^self copy pc: pc+1
]

{ #category : #'as yet unclassified' }
JibDeterministicContext >> interpretNextInstruction [
	| instr |
	instr := fn instrAt: pc.
	^instr interpretIn: self
]

{ #category : #'as yet unclassified' }
JibDeterministicContext >> method [
	^nil
]

{ #category : #accessing }
JibDeterministicContext >> pc [
	^ pc
]

{ #category : #accessing }
JibDeterministicContext >> pc: anObject [
	pc := anObject
]

{ #category : #accessing }
JibDeterministicContext >> sender [
	^ sender
]

{ #category : #accessing }
JibDeterministicContext >> sender: anObject [
	sender := anObject
]

{ #category : #'as yet unclassified' }
JibDeterministicContext >> stack [
	^self stackOfSize: 9999
]

{ #category : #'as yet unclassified' }
JibDeterministicContext >> stackOfSize: limit [ 
	"Answer an OrderedCollection of the top 'limit' contexts
	 on the receiver's sender chain."

	| stack context |
	stack := OrderedCollection new.
	stack addLast: (context := self).
	[(context := context sender) ~~ nil
	 and: [stack size < limit]] whileTrue: [
		stack addLast: context ].
	^ stack
]

{ #category : #accessing }
JibDeterministicContext >> temps [
	^ temps
]

{ #category : #accessing }
JibDeterministicContext >> temps: anObject [
	temps := anObject
]
