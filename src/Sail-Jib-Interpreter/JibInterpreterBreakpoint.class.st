Class {
	#name : #JibInterpreterBreakpoint,
	#superclass : #Object,
	#instVars : [
		'instr',
		'temporary'
	],
	#category : #'Sail-Jib-Interpreter-Interpreter'
}

{ #category : #'instance creation' }
JibInterpreterBreakpoint class >> at: aJibInstr [
	^self basicNew initializeWithInstruction: aJibInstr 

]

{ #category : #initialization }
JibInterpreterBreakpoint >> initializeWithInstruction: i [
	instr := i.
	temporary := false.
]

{ #category : #accessing }
JibInterpreterBreakpoint >> instr [
	^ instr
]

{ #category : #processing }
JibInterpreterBreakpoint >> stopIn: interpreter [
	"This method is called just before interpeter is about to execute
	 instruction associated with this breakpoint."
	
	temporary ifTrue:[
		interpreter removeBreakpoint: self.
	].
	JibInterpreterBreakpointHitNotification signal
]

{ #category : #accessing }
JibInterpreterBreakpoint >> temporary [
	"Return if this breakpoint is temporary. Temporary breakpoints hit only once -
	 in other words they're automatically removed once they hit."
	
	^ temporary
]

{ #category : #accessing }
JibInterpreterBreakpoint >> temporary: aBoolean [
	temporary := aBoolean
]
