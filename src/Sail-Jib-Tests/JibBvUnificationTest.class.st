Class {
	#name : #JibBvUnificationTest,
	#superclass : #TestCase,
	#category : #'Sail-Jib-Tests'
}

{ #category : #tests }
JibBvUnificationTest >> test32vs32 [
	self
		assert: ( (Ty_Bits new: 32) unify: (Ty_Bits new: 32) ) length
		equals: 32
]

{ #category : #tests }
JibBvUnificationTest >> test32vs33 [
	self
		should: [ (Ty_Bits new: 32) unify: (Ty_Bits new: 33) ]
		raise: Incompatible
]

{ #category : #tests }
JibBvUnificationTest >> test32vsHole [
	self
		assert: ( (Ty_Bits new: 32) unify: (Ty_Bits new) ) length
		equals: 32
]

{ #category : #tests }
JibBvUnificationTest >> testChainBad [
	| a b c |
	a := Ty_Bits new.
	b := Ty_Bits new.
	c := Ty_Bits new.
	a unify: b.
	b unify: c.
	a unify: (Ty_Bits new: 32).
	self assert: a length equals: 32.
	self assert: b length equals: 32.
	self assert: c length equals: 32.
	self
		should: [c unify: (Ty_Bits new: 33)]
		raise: Incompatible
]

{ #category : #tests }
JibBvUnificationTest >> testChainGood3 [
	| a b c |
	a := Ty_Bits new.
	b := Ty_Bits new.
	c := Ty_Bits new.
	a unify: b.
	a unify: c.
	b unify: (Ty_Bits new: 32).
	self assert: a length equals: 32.
	self assert: b length equals: 32.
	self assert: c length equals: 32.
	c unify: (Ty_Bits new: 32)
]

{ #category : #tests }
JibBvUnificationTest >> testChainGood4 [
	| a b c d |
	a := Ty_Bits new.
	b := Ty_Bits new.
	c := Ty_Bits new.
	d := Ty_Bits new.
	a unify: b.
	b unify: c.
	c unify: d.
	a unify: (Ty_Bits new: 32).
	self assert: a length equals: 32.
	self assert: b length equals: 32.
	self assert: c length equals: 32.
	self assert: d length equals: 32.
	c unify: (Ty_Bits new: 32)
]

{ #category : #tests }
JibBvUnificationTest >> testHoleVs32 [
	self
		assert: ( (Ty_Bits new) unify: (Ty_Bits new: 32) ) length
		equals: 32
]
