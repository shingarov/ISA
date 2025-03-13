Class {
	#name : #JibInterpreter,
	#superclass : #Object,
	#instVars : [
		'context',
		'retval'
	],
	#category : #'Sail-Jib-Interpreter-Interpreter'
}

{ #category : #'tests - instance' }
JibInterpreter class >> for: fn arguments: args [
	^self basicNew initializeWithFunction: fn arguments: args
]

{ #category : #accessing }
JibInterpreter >> context [
	"Return the currently executing context"

	^ context
]

{ #category : #initialization }
JibInterpreter >> initializeWithFunction: fn arguments: args [
	context := JibInterpreterContext for: fn arguments: args
]

{ #category : #interpreting }
JibInterpreter >> interpret [
	"Interpret until the initial context returns."

	^self interpretUntil: [ context notNil ].
]

{ #category : #interpreting }
JibInterpreter >> interpret1 [
	"Interpret exactly one instruction."
	| instr |

	self assert: (context pc between: 1 and: context function instrs size).

	instr := context function instrs at: context pc.
	"Here we advance pc to following instruction. However, the pc
	 can be changed as part of interpreting that instruction (for
	 example to implement jumps). This is done here eagerly so one
	 does not need to do 'pc := pc + 1' at the end of most
	 instructions. Maybe not a great idea, will see."
	context pc: context pc + 1.
	instr interpretIn: self.
]

{ #category : #'interpreting - insns' }
JibInterpreter >> interpretArbitrary: insn [
	self notYetImplemented


]

{ #category : #'interpreting - exprs' }
JibInterpreter >> interpretBits: expr [
	^ expr value

]

{ #category : #'interpreting - insns' }
JibInterpreter >> interpretCall: insn [
	| args fn |

	args := insn argExprs collect:[:expr | expr interpretIn: self ].
	context := JibInterpreterContext for: insn function arguments: args caller: context.



]

{ #category : #'interpreting - insns' }
JibInterpreter >> interpretCopy: insn [
	| val loc |

	val := insn expression interpretIn: self.
	loc := insn location.

	insn location assign: val in: self.


]

{ #category : #'interpreting - insns' }
JibInterpreter >> interpretDecl: insn [
	context def: insn id to: insn varType newUndefined

]

{ #category : #'interpreting - insns' }
JibInterpreter >> interpretEnd: insn [
	| callee caller |

	callee := context.
	caller := context caller.

	"Drop the current context"
	context := caller.


	caller isNil ifTrue:[
		"We're done, just note the resulting value."
		retval := callee getRetVal.
	] ifFalse:[
		| call |

		call := caller function instrs at: caller pc - 1.
		call location assign: callee getRetVal in: self.
	].
]

{ #category : #'interpreting - insns' }
JibInterpreter >> interpretExit: insn [
	self notYetImplemented


]

{ #category : #'interpreting - insns' }
JibInterpreter >> interpretGoto: insn [
	self notYetImplemented


]

{ #category : #'interpreting - exprs' }
JibInterpreter >> interpretId: expr [
	^ context get: expr id

]

{ #category : #'interpreting - insns' }
JibInterpreter >> interpretInit: insn [
	self notYetImplemented


]

{ #category : #'interpreting - insns' }
JibInterpreter >> interpretMonomorphize: insn [
	self notYetImplemented


]

{ #category : #interpreting }
JibInterpreter >> interpretUntil: condition [
	"Interpret until condition holds"

	condition whileTrue:[
		self interpret1.
	]
]

{ #category : #accessing }
JibInterpreter >> retVal [
	^retval
]

{ #category : #'debugging support' }
JibInterpreter >> stepInto: steppingContext [
	context == steppingContext ifTrue:[
		self interpret1.
	] ifFalse:[
		self notYetImplemented
	]
]
