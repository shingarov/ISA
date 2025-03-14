Class {
	#name : #JibInterpreterContext,
	#superclass : #Object,
	#instVars : [
		'values',
		'function',
		'caller',
		'pc'
	],
	#category : #'Sail-Jib-Interpreter-Interpreter'
}

{ #category : #'instance creation' }
JibInterpreterContext class >> for: fn arguments: args [
	^self for: fn arguments: args caller: nil
]

{ #category : #'instance creation' }
JibInterpreterContext class >> for: fn arguments: args caller: caller [
	^self basicNew initializeWithFunction: fn arguments: args caller: caller
]

{ #category : #accessing }
JibInterpreterContext >> caller [
	^ caller
]

{ #category : #'accessing - variables' }
JibInterpreterContext >> def: id to: value [
	"Define new variable and set value to value"
	self assert: (values includesKey: id) not.
	values at: id put: value
]

{ #category : #accessing }
JibInterpreterContext >> function [
	^ function
]

{ #category : #'accessing - variables' }
JibInterpreterContext >> get: id [
	self assert: (values includesKey: id).
	^ values at: id.

]

{ #category : #'accessing - variables' }
JibInterpreterContext >> getRetVal [
	"Return the return value once function returns.
	 Should only be called after function interpretation
	 reaches 'end' instruction."

	^ self get: function retName
]

{ #category : #inspecting }
JibInterpreterContext >> gtLocalsIn: composite [
	<gtInspectorPresentationOrder: 40>

	composite fastTable
		title: 'Locals';
		display: [ :ctx | values associations ];
		column: 'Name' evaluated: [ :nameAndValue | nameAndValue key ];
		column: 'Value' evaluated: [ :nameAndValue | nameAndValue value ];
		yourself.


]

{ #category : #initialization }
JibInterpreterContext >> initializeWithFunction: fn arguments: args caller: callr [
	| signature |

	self assert: (fn isKindOf: Def_Fn).

	values := OrderedDictionary new.
	function := fn.
	caller := callr.
	pc := 1.

	signature := function signature.
	values at: function retName put: signature retType newUndefined.
	function argNames with: args do:[:argName :argValue  |
		values at: argName put: argValue.
	].




]

{ #category : #accessing }
JibInterpreterContext >> pc [
	^ pc
]

{ #category : #accessing }
JibInterpreterContext >> pc: anInteger [
	self assert: (pc between: 1 and: function instrs size).

	pc := anInteger
]

{ #category : #'accessing - variables' }
JibInterpreterContext >> set: id to: value [
	self assert: (values includesKey: id).

	values at: id put: value
]
