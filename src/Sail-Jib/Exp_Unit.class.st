Class {
	#name : #'Exp_Unit',
	#superclass : #JibExp,
	#category : #'Sail-Jib'
}

{ #category : #syntax }
Exp_Unit class >> inducedParser [
	^ '()'  asParser ==> [ :_ | Exp_Unit new ]
]
