Class {
	#name : #JibDebuggerSession,
	#superclass : #Object,
	#instVars : [
		'interpreter'
	],
	#category : #'Sail-Jib-Interpreter-Debugger'
}

{ #category : #'actions registration' }
JibDebuggerSession class >> debuggingActionsForPragma: aSymbol for: aDebugger [
	^ {
		"ResumeDebugAction ."
		"RestartDebugAction ."
		StepIntoDebugAction .
		StepOverDebugAction .
	} inject: OrderedCollection new
		into: [ :currentActions :aClass |
			currentActions
				addAll: (self debuggingActionsFromClass: aClass forPragma: aSymbol forDebugger: aDebugger);
				yourself ]
]

{ #category : #'actions registration' }
JibDebuggerSession class >> debuggingActionsForPragmas: aSymbolsCollection for: aDebugger [
	self flag: 'split me'.
	^ (((aSymbolsCollection
		inject: OrderedCollection new
		into: [ :currentActions :aSymbol |
			currentActions
				addAll: (self debuggingActionsForPragma: aSymbol for: aDebugger);
				yourself ])
					select: [ :aDebugAction |
						aDebugAction appliesToDebugger: aDebugger ])
					collect: [ :aDebugAction |
						aDebugAction
							forDebugger: aDebugger;
							yourself ])
					sort: [ :action1 :action2 |
						action1 order < action2 order ]
]

{ #category : #'actions registration' }
JibDebuggerSession class >> debuggingActionsFromClass: aClass forPragma: aSymbol forDebugger: aDebugger [
	| pragmas actions |
	pragmas := Pragma
		allNamed: aSymbol
		from: aClass class
		to: aClass class.
	actions := OrderedCollection new.
	pragmas
		do: [ :aPragma |
			actions
				addAll:
					((aPragma methodClass soleInstance
						perform: aPragma methodSelector
						withEnoughArguments: {aDebugger}) asOrderedCollection
						collect: [ :each | each asDebugAction ]) ].
	^ actions
]

{ #category : #'instance creation' }
JibDebuggerSession class >> for: aJibInterpreter [
	^self basicNew initializeWithInterpreter: aJibInterpreter
]

{ #category : #'debugging actions' }
JibDebuggerSession >> clear [
	interpreter := nil.
]

{ #category : #private }
JibDebuggerSession >> cont [
	"Continue until a breakpoint is hit or intepreter terminates."

	[
		interpreter interpret
	] on: JibInterpreterBreakpointHitNotification do: [ :hit |
		"Stop"
	].
]

{ #category : #initialization }
JibDebuggerSession >> initializeWithInterpreter: aJibInterpreter [
	self assert: (aJibInterpreter isKindOf: JibInterpreter).

	interpreter := aJibInterpreter
]

{ #category : #accessing }
JibDebuggerSession >> interruptedContext [
	^ interpreter context
]

{ #category : #accessing }
JibDebuggerSession >> name [
	^'Jib Debugger'
]

{ #category : #'debugging actions' }
JibDebuggerSession >> restart: context [
	self notYetImplemented
]

{ #category : #'debugging actions' }
JibDebuggerSession >> resume [
	self notYetImplemented
]

{ #category : #accessing }
JibDebuggerSession >> stack [
	| stack context |

	stack := OrderedCollection new.
	context := interpreter context.
	[ context notNil ] whileTrue:[
		stack add: context.
		context := context caller
	].
	^stack
]

{ #category : #private }
JibDebuggerSession >> step [
	"Execute exactly one instruction."

	interpreter interpret1
]

{ #category : #'debugging actions' }
JibDebuggerSession >> stepInto: context [
	context == interpreter context ifTrue:[
		"If we're stepping in top-most context, just
		 execute one instruction and stop."
		self step.
	] ifFalse:[
		"If we're stepping in any other context, 'step-into' means
		 'step to next instruction in this context'. So we setup a
		 temporary breakpoint on that instruction and continue until
		 this (or some other) breakpoint hits."

		| instr break |

		instr := context function instrs at: context pc.
		break := JibInterpreterBreakpoint at: instr.
		break temporary: true.

		interpreter addBreakpoint: break.

		self cont.
	].

	self triggerEvent: #stepInto
]

{ #category : #'debugging actions' }
JibDebuggerSession >> stepOver: context [
	self notYetImplemented
]

{ #category : #'debugging actions' }
JibDebuggerSession >> terminate [
	"Do nothing for now."
]
