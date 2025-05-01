Class {
	#name : #JibInterpreter,
	#superclass : #Object,
	#instVars : [
		'program',
		'context',
		'lets',
		'registers',
		'entry',
		'retval',
		'todo',
		'breakpoints'
	],
	#category : #'Sail-Jib-Interpreter-Interpreter'
}

{ #category : #'tests - instance' }
JibInterpreter class >> for: fn arguments: args [
	^self basicNew initializeWithFunction: fn arguments: args
]

{ #category : #'adding & removing breakpoints' }
JibInterpreter >> addBreakpoint: aJibInterpreterBreakpoint [
	self assert: aJibInterpreterBreakpoint instr program == program.
	self assert:(breakpoints includesKey: aJibInterpreterBreakpoint instr) not.
	
	breakpoints at: aJibInterpreterBreakpoint instr put: aJibInterpreterBreakpoint
	
 
]

{ #category : #accessing }
JibInterpreter >> breakpoints [
	^ breakpoints 
]

{ #category : #accessing }
JibInterpreter >> context [
	"Return the currently executing context"

	^ context
]

{ #category : #'accessing - variables' }
JibInterpreter >> get: id [
	(lets includesKey: id) ifTrue:[
		^ lets at: id
	] ifFalse:[(registers includesKey: id) ifTrue:[
		^ registers at: id
	] ifFalse:[
		^ context get: id
	]]
]

{ #category : #'accessing - globals' }
JibInterpreter >> getRegister: id [
	self assert:(registers includesKey: id).

	^ registers at: id
]

{ #category : #initialization }
JibInterpreter >> initializeWithFunction: fn arguments: args [
	entry := fn.
	program := fn program.
	registers := OrderedDictionary new.
	lets := OrderedDictionary new.
	todo := OrderedCollection new.
	breakpoints := IdentityDictionary new.

	program registersDo: [ :register |
		registers at: register id put: register regType newUndefined.

		register hasInitializer ifTrue:[
			todo add: (JibInterpreterContext for: register arguments: #())
		]
	].

	program letsDo: [ :let |
		let variables do: [ :nameAndType |
			lets at: nameAndType key put: nameAndType value newUndefined.
		].

		let hasInitializer ifTrue:[
			todo add: (JibInterpreterContext for: let arguments: #())
		]
	].

	todo add: (JibInterpreterContext for: fn arguments: args).

	context := todo removeFirst.


]

{ #category : #interpreting }
JibInterpreter >> interpret [
	"Interpret until the initial context returns."

	^self interpretWhileTrue: [ context notNil ].
]

{ #category : #interpreting }
JibInterpreter >> interpret1 [
	"Interpret exactly one instruction."
	| instr breakpoint |

	instr := context function instrs at: context pc.
	
	"Check for breakpoint."
	breakpoint := breakpoints at: instr ifAbsent:[nil].
	breakpoint notNil ifTrue:[				
		breakpoint stopIn: self.
	].
	
	"Here we advance pc to following instruction. However, the pc
	 can be changed as part of interpreting that instruction (for
	 example to implement jumps). This is done here eagerly so one
	 does not need to do 'pc := pc + 1' at the end of most
	 instructions. Maybe not a great idea, will see."
	context pc: context pc + 1.
	instr interpretIn: self.

	(context notNil and:[context function isFn not]) ifTrue:[
		"For some unknown reason, let and register initializers do not
		 have an 'end' instruction. So here we check if PC is past the
		 instruction sequence of current initilalizer and if so, finish
		 its execution by interpreting fabricated Instr_End (this is
		 merely a trick to have function return logic at one place)."
		(context pc) == (context function instrs size + 1) ifTrue:[
			self interpretEnd: Instr_End new.
		].
	].
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
	| args func |

	args := insn argExprs collect:[:expr | expr interpretIn: self ].
	func := insn function.
	
	func isExtern ifTrue:[
		| retv |
		
		retv := func extern evaluateWithArguments: args.
		insn location assign: retv in: self.		
	] ifFalse:[	
		context := JibInterpreterContext for: insn function arguments: args caller: context.
	].



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
		todo isEmpty ifTrue:[
			"We're done, just note the resulting value."
			retval := callee getRetVal.
		] ifFalse:[
			context := todo removeFirst.
		]
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
JibInterpreter >> interpretWhileFalse: condition [
	"Interpret instruction by instruction as long as `condition` evaluates to `false`"

	condition whileFalse:[
		self interpret1.
	]
]

{ #category : #interpreting }
JibInterpreter >> interpretWhileTrue: condition [
	"Interpret instruction by instruction as long as `condition` evaluates to `true`"

	condition whileTrue:[
		self interpret1.
	]
]

{ #category : #'adding & removing breakpoints' }
JibInterpreter >> removeBreakpoint: aJibInterpreterBreakpoint [
	self assert: aJibInterpreterBreakpoint instr program == program.
	self assert:(breakpoints includesKey: aJibInterpreterBreakpoint instr).
	
	breakpoints removeKey: aJibInterpreterBreakpoint instr
	
 
]

{ #category : #accessing }
JibInterpreter >> retVal [
	^retval
]

{ #category : #'accessing - variables' }
JibInterpreter >> set: id to: value [
	(lets includesKey: id) ifTrue:[
		lets at: id put: value.
	] ifFalse:[(registers includesKey: id) ifTrue:[
		registers at: id put: value.
	] ifFalse:[
		context set: id to: value
	]]
]

{ #category : #'accessing - globals' }
JibInterpreter >> setRegister: id to: value [
	self assert:(registers includesKey: id).

	registers at: id put: value
]

{ #category : #'debugging support' }
JibInterpreter >> todo [
	"Return the 'TODO' list. Private, use with care!"
	^ todo
]
