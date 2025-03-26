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

{ #category : #tests }
JibDebuggerSessionTests >> test_03 [
	| program main interpreter session |

	program := JibParser parse:'

let (zxlen_val: %i64) {
  zz40 : %i64;
  zz40 = 64;
  zxlen_val = zz40;
}

register zPC : %bv64 {
	zPC = 0xCAFE0000CAFE0000;
}

val zmain : () -> %i64

fn zmain() {
  return = zxlen_val;
  end;
}

'.

	main := program lookupFunction: 'zmain'.

	interpreter := JibInterpreter for: main arguments: #().
	session := JibDebuggerSession for: interpreter.

	"
	JibDebugger openOn: session.
	"
	self assert: interpreter context function isRegister.
	session stepInto: interpreter context. "zz40 : %i64;"
	session stepInto: interpreter context. "zz40 = 64;"
	session stepInto: interpreter context. "zxlen_val = zz40;"

	self assert: interpreter context function isLet.
]

{ #category : #tests }
JibDebuggerSessionTests >> test_03c [
	| program main interpreter session |

	program := JibParser parse:'

let (zxlen_val: %i64) {
  zxlen_val = zf();
}

val zf : () -> %i64

fn zf() {
  return = 64;
  end;
}

val zmain : () -> %i64

fn zmain() {
  return = zxlen_val;
  end;
}

'.

	main := program lookupFunction: 'zmain'.

	interpreter := JibInterpreter for: main arguments: #().
	session := JibDebuggerSession for: interpreter.

	"
	JibDebugger openOn: session.
	"
	self assert: interpreter context function isLet.
	session stepInto: interpreter context. " zxlen_val = zf();"

	self assert: interpreter context function isFn.
	self assert: interpreter context function id = 'zf'.
	self assert: interpreter context caller function isLet.

	session stepInto: interpreter context caller.

	self assert: interpreter context function isFn.
	self assert: interpreter context function id = 'zmain'.
]

{ #category : #tests }
JibDebuggerSessionTests >> test_04a [
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
	session stepOver: interpreter context. "zz1 : %bv32 `1;"
	session stepOver: interpreter context. "zz1 = zf(zarg) `2;"

	self assert: interpreter context function id = 'zmain'.
	self assert: interpreter context pc = 3.

	session stepOver: interpreter context. "return = zz1 `3"
	self assert: (interpreter context get: 'return') = 42.

	session stepOver: interpreter context. "end"
	self assert: (interpreter context isNil).
]

{ #category : #tests }
JibDebuggerSessionTests >> test_04b [
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
	self assert: interpreter context pc = 1.

	session stepOver: interpreter context caller. "return = zz1 `3;"

	self assert: interpreter context function id = 'zmain'.
	self assert: interpreter context pc = 3.
]

{ #category : #tests }
JibDebuggerSessionTests >> test_04c [
	| program main interpreter session |

	program := JibParser parse:'

let (zxlen_val: %i64) {
  zxlen_val = zf();
}

val zf : () -> %i64

fn zf() {
  return = 64;
  end;
}

val zmain : () -> %i64

fn zmain() {
  return = zxlen_val;
  end;
}

'.

	main := program lookupFunction: 'zmain'.

	interpreter := JibInterpreter for: main arguments: #().
	session := JibDebuggerSession for: interpreter.

	"
	JibDebugger openOn: session.
	"
	self assert: interpreter context function isLet.
	session stepInto: interpreter context. " zxlen_val = zf();"

	self assert: interpreter context function isFn.
	self assert: interpreter context function id = 'zf'.
	self assert: interpreter context caller function isLet.

	session stepOver: interpreter context caller.

	self assert: interpreter context function isFn.
	self assert: interpreter context function id = 'zmain'.
]

{ #category : #tests }
JibDebuggerSessionTests >> test_05a [
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
	self assert: interpreter context pc = 1.

	session finish: interpreter context.

	self assert: interpreter context function id = 'zmain'.
	self assert: interpreter context pc = 3.
]

{ #category : #tests }
JibDebuggerSessionTests >> test_05b [
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
	self assert: interpreter context pc = 1.

	session finish: interpreter context caller. "finish zmain"

	self assert: interpreter context isNil.
]

{ #category : #tests }
JibDebuggerSessionTests >> test_05c [
	| program main interpreter session |

	program := JibParser parse:'
let (zxlen_val: %i64) {
  zz40 : %i64;
  zz40 = 64;
  zxlen_val = zz40;
}

val zmain : () -> %i64

fn zmain() {
  return = zxlen_val;
  end;
}

'.

	main := program lookupFunction: 'zmain'.

	interpreter := JibInterpreter for: main arguments: {  }.
	session := JibDebuggerSession for: interpreter.

	"
	JibDebugger openOn: session.
	"
	self assert: interpreter context function isLet.

	session finish: interpreter context. "finish let zxlen_val"

	self assert: interpreter context function id = 'zmain'.

	session finish: interpreter context. "finish zmain"

	self assert: interpreter context isNil.


]
