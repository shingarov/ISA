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
JibInterpreterContext class >> for: code [
	self assert: (code isRegister or:[code isLet]).

	^self for: code arguments: #()
]

{ #category : #'instance creation' }
JibInterpreterContext class >> for: code arguments: args [
	^self for: code arguments: args caller: nil
]

{ #category : #'instance creation' }
JibInterpreterContext class >> for: code arguments: args caller: caller [
	^self basicNew initializeWith: code arguments: args caller: caller
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
JibInterpreterContext >> initializeWith: code arguments: args caller: callr [
	self assert: code hasCode.

	values := OrderedDictionary new.
	function := code.
	caller := callr.
	pc := 1.

	function isFn ifTrue:[
		"Initialize arguments and return value. We do this only
		 for real functions (Def_Fn) since let and register initializers
		 do not take arguments and have no return value"

		| signature |

		signature := function signature.
		values at: function retName put: signature retType newUndefined.
		function argNames with: args do:[:argName :argValue  |
			values at: argName put: argValue.
		].
	].




]

{ #category : #accessing }
JibInterpreterContext >> pc [
	^ pc
]

{ #category : #accessing }
JibInterpreterContext >> pc: anInteger [
	"Set the current PC (index into instrs sequence) in this context.
	 Here we allow to set the PC one beyond the size of an instruction
	 sequence - this is to signal end of initializer execution. See
	 JibInterpreter >> interpret1."
	self assert: (pc between: 1 and: function instrs size + 1).

	pc := anInteger
]

{ #category : #'accessing - variables' }
JibInterpreterContext >> set: id to: value [
	self assert: (values includesKey: id).

	values at: id put: value
]
