Extension { #name : #PPParser }

{ #category : #'*Sail-Jib-Parsing' }
PPParser >> construct: fields [
	| cls |
	cls := Object class findContextReceivingMe receiver.
	^self ==> [ :x |
			| inst |
			inst := cls basicNew.
			(fields zip: x) do: [ :ivarNameAndVal |
				ivarNameAndVal key = #- ifFalse: [ inst instVarNamed: ivarNameAndVal key put: ivarNameAndVal value ] ].
			inst initialize; yourself ]
]

{ #category : #'*Sail-Jib-Parsing' }
PPParser class >> doubleQuoted [
	^ $" asParser
	, (PPPredicateObjectParser on: (PPCharSetPredicate on: [ :x | x ~= $" ] ) message: 'Non-" expected') star flatten
	, $" asParser
	==> #second
]
