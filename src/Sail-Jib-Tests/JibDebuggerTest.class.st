Class {
	#name : #JibDebuggerTest,
	#superclass : #TestCase,
	#category : #'Sail-Jib-Tests'
}

{ #category : #tests }
JibDebuggerTest >> progCALL [
	| prog |
	prog := JibParser new parse: '
	
val zf : (%bv32) ->  %bv32

fn zf(zarg) {
  zz39 : %bv32 `1;
  zz39 = 0b00000000000000000000000000101010 `2;
  return = zz39 `3;
  end;
}

val zmain : (%bv32) ->  %bv32

fn zmain(zarg) {
  zz1 : %bv32 `1;
  zz1 = zf(zarg) `2;
  return = zz1 `3;
  end;
}

'.
	self assert: (prog isKindOf: JibProgram).
	^prog
]

{ #category : #tests }
JibDebuggerTest >> progZF [
	| prog |
	prog := JibParser new parse: '
	
val zf : (%bv32) ->  %bv32

fn zf(zarg) {
  zz39 : %bv32 `1;
  zz39 = 0b00000000000000000000000000101010 `2;
  return = zz39 `3;
  end;
}

'.
	self assert: (prog isKindOf: JibProgram).
	^prog
]

{ #category : #tests }
JibDebuggerTest >> test1 [
	| context process session debugger printedString |
	context := "[ 20 factorial ] asContext" JibDeterministicContext new .
	process := DeterministicProcess new
		"forContext: context
		priority: Processor userInterruptPriority".
	session := "JibDebugSession new. "process newDebugSessionNamed: 'test debugging' startedAt: context.
1 halt.
	JibDebugger openOn: session withFullView: false.
	
	debugger := JibDebugger on: session.
	self assert: debugger stackPresentation selection equals: context.
	printedString := '[ 20 factorial ] in GTGenericStackDebuggerTest>>testBasic'.
	self assert: debugger selectedContext printString equals: printedString.
	debugger send.
	debugger send.
	debugger update.
	self
		assert: debugger codePresentation entity sourceCode equals: (Integer >> #factorial) sourceCode.
	self
		assert:
			debugger stackPresentation selection printString
		equals: 'SmallInteger(Integer)>>factorial'.
	process terminate

]

{ #category : #tests }
JibDebuggerTest >> test2 [
	| prog zf context |
	prog := self progZF.
	zf := prog values at: 'zf'.
	context := JibDeterministicContext new.
	context
		fn: zf;
		temps: (Dictionary newFromAssociations: {'return'->zf returnSort undefinedElement});
		pc: 1.
	context interpretNextInstruction interpretNextInstruction interpretNextInstruction interpretNextInstruction.
]

{ #category : #tests }
JibDebuggerTest >> test3 [
	| prog zmain context |
	prog := self progCALL.
	zmain := prog values at: 'zmain'.
	context := JibDeterministicContext new.
	context
		fn: zmain;
		temps: (Dictionary newFromAssociations: {'return'->zmain returnSort undefinedElement});
		globals: prog values;
		pc: 1.
	context interpretNextInstruction interpretNextInstruction interpretNextInstruction interpretNextInstruction interpretNextInstruction interpretNextInstruction.
]
