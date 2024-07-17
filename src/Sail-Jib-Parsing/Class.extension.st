Extension { #name : #Class }

{ #category : #'*Sail-Jib-Parsing' }
Class >> adtSummands [
	^self subclasses asSortedCollection: [ :a :b | a name <= b name ]
]

{ #category : #'*Sail-Jib-Parsing' }
Class >> constructNewFrom: anArray accordingTo: fields [
	| inst |
	inst := self basicNew.
	(fields zip: anArray) do: [ :ivarNameAndVal |
				ivarNameAndVal key = #- ifFalse: [ inst instVarNamed: ivarNameAndVal key put: ivarNameAndVal value ] ].
	inst initialize.
	^inst
]

{ #category : #'*Sail-Jib-Parsing' }
Class >> inducedParser [
	| dp |
	dp := PPDelegateParser new.
	[ dp setParser: (PPChoiceParser withAll: (self adtSummands collect: #inducedParser)) ]
		runReader: #parentInducedParser
		initialState: dp.
	^dp
]
