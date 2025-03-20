Class {
	#name : #JibExp,
	#superclass : #JibProgramNode,
	#category : #'Sail-Jib'
}

{ #category : #parsing }
JibExp class >> asParser [
	"
	Expressions are parsed traditionally, using JibParser.
	"
	^ JibParser new productionAt: #exp

	"
	JibExp asParser end parse:'xyz'
	JibExp asParser end parse:'xyz.foo'
	Exp_Field asParser end parse:'xyz.foo'
	"



]

{ #category : #parsing }
JibExp class >> inducedParser [
	"
	Expressions are parsed traditionally, using JibParser.
	"
	self shouldNotImplement 




"
JibExp asParser end parse:'xyz'
JibExp asParser end parse:'xyz.foo'
Exp_Field asParser end parse:'xyz.foo'
"



]

{ #category : #testing }
JibExp class >> isAbstract [
	^self == JibExp
]

{ #category : #enumerating }
JibExp >> usedIdsDo: aBlock [
	"Evaluate `aBlock` for each id used (read, accessed) by this expression"
	
]
