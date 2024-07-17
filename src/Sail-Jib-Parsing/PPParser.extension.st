Extension { #name : #PPParser }

{ #category : #'*Sail-Jib-Parsing' }
PPParser >> construct: fields [
	| cls |
	cls := Object class findContextReceivingMe receiver.
	^self ==> (cls constructNewFrom: □ accordingTo: fields)
]

{ #category : #'*Sail-Jib-Parsing' }
PPParser class >> doubleQuoted [
	^ $" asParser
	, (PPPredicateObjectParser on: (PPCharSetPredicate on: [ :x | x ~= $" ] ) message: 'Non-" expected') star flatten
	, $" asParser
	==> #second
]
