Extension { #name : #Class }

{ #category : #'*Sail-Jib-Parsing' }
Class >> adtSummands [
	^self subclasses asSortedCollection: [ :a :b | a name <= b name ]
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
