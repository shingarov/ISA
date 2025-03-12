Class {
	#name : #JibDebuggerSessionTests,
	#superclass : #TestCase,
	#category : #'Sail-Jib-Interpreter-Tests'
}

{ #category : #tests }
JibDebuggerSessionTests >> test_01 [
	| program main interpreter session |
	program := JibParser parse:'
val zf : (%bv32) ->  %bv32

fn zf(zarg) {
  zz39 : %bv32 `1;
  zz39 = 0b00000000000000000000000000101010 `2;
  return = zz39 `3;
  end;
}
'.

	main := program lookupFunction: 'zf'.

	interpreter := JibInterpreter for: main arguments: { 0 toBitVector: 32 }.
	session := JibDebuggerSession for: interpreter.

	"
	JibDebugger openOn: session.
	"

	session stepInto: interpreter context. "zz39 : %bv32 `1;"
	session stepInto: interpreter context. "zz39 = 0b00000000000000000000000000101010 `2;"
	self assert: (interpreter context get: 'zz39') = 42.






]

{ #category : #tests }
JibDebuggerSessionTests >> test_02 [
	| program main interpreter session |

	program := JibParser parse:'
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

	main := program lookupFunction: 'zmain'.

	interpreter := JibInterpreter for: main arguments: { 0 toBitVector: 32 }.
	session := JibDebuggerSession for: interpreter.

	"
	JibDebugger openOn: session.
	"
	self assert: interpreter context function id = 'zmain'.
	session stepInto: interpreter context. "zz1 : %bv32 `1;"
	session stepInto: interpreter context. "zz1 = zf(zarg) `2;"

	self assert: interpreter context function id = 'zf'.
	self assert: interpreter context caller function id = 'zmain'.

	session stepInto: interpreter context. "zz39 : %bv32 `1;"
	session stepInto: interpreter context. "zz39 = 0b00000000000000000000000000101010 `2;"
	session stepInto: interpreter context. "return = zz39 `3;"
	session stepInto: interpreter context. "end;"

	self assert: interpreter context function id = 'zmain'.
	self assert: (interpreter context get: 'zz1') = 42.

	session stepInto: interpreter context. "return = zz1 `3"
	self assert: (interpreter context get: 'return') = 42.

	session stepInto: interpreter context. "end"
	self assert: (interpreter context isNil).











]
