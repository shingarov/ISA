Class {
	#name : #JibInterpreter,
	#superclass : #Object,
	#instVars : [
		'program',
		'context',
		'registers',
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

{ #category : #'accessing - variables' }
JibInterpreter >> get: id [
	(registers includesKey: id) ifTrue:[
		^ registers at: id
	] ifFalse:[
		^ context get: id
	]
]

{ #category : #'accessing - registers' }
JibInterpreter >> getRegister: id [
	self assert:(registers includesKey: id).

	^ registers at: id
]

{ #category : #initialization }
JibInterpreter >> initializeWithFunction: fn arguments: args [
	program := fn program.
	context := JibInterpreterContext for: fn arguments: args.
	registers := OrderedDictionary new.
	program registersDo: [ :register |
		register instrs notEmpty ifTrue:[
			self notYetImplemented
		].

		registers at: register id put: register regType newUndefined
	]


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

{ #category : #'interpreting - exprs' }
JibInterpreter >> interpretBool: expr [
	^ expr value

]

{ #category : #'interpreting - insns' }
JibInterpreter >> interpretCall: insn [
	| args fn |

	args := insn argExprs collect:[:expr | expr interpretIn: self ].
	context := JibInterpreterContext for: insn function arguments: args caller: context.



]

{ #category : #'interpreting - exprs' }
JibInterpreter >> interpretCallOp: expr [
	"This is called #interpretCallOp: and not #interpretCall: since the
	 latter is already used for Instr_Call."

	| args |

	args := expr argExprs collect:[:argExpr | argExpr interpretIn: self ].
	^expr op evaluateWithArguments: args.


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
JibInterpreter >> interpretI64: expr [
	^ expr value

]

{ #category : #'interpreting - exprs' }
JibInterpreter >> interpretId: expr [
	^ self get: expr id

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

{ #category : #'accessing - variables' }
JibInterpreter >> set: id to: value [
	(registers includesKey: id) ifTrue:[
		registers at: id put: value.
	] ifFalse:[
		context set: id to: value
	]
]

{ #category : #'accessing - registers' }
JibInterpreter >> setRegister: id to: value [
	self assert:(registers includesKey: id).

	registers at: id put: value
]

{ #category : #'debugging support' }
JibInterpreter >> stepInto: steppingContext [
	context == steppingContext ifTrue:[
		self interpret1.
	] ifFalse:[
		self notYetImplemented
	]
]
