Class {
	#name : #JibDebuggerSessionTests,
	#superclass : #TestCaseWithZ3Context,
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

	session stepIntoI: interpreter context. "zz39 : %bv32 `1;"
	session stepIntoI: interpreter context. "zz39 = 0b00000000000000000000000000101010 `2;"
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
	session stepIntoI: interpreter context. "zz1 : %bv32 `1;"
	session stepIntoI: interpreter context. "zz1 = zf(zarg) `2;"

	self assert: interpreter context function id = 'zf'.
	self assert: interpreter context caller function id = 'zmain'.

	session stepIntoI: interpreter context. "zz39 : %bv32 `1;"
	session stepIntoI: interpreter context. "zz39 = 0b00000000000000000000000000101010 `2;"
	session stepIntoI: interpreter context. "return = zz39 `3;"
	session stepIntoI: interpreter context. "end;"

	self assert: interpreter context function id = 'zmain'.
	self assert: (interpreter context get: 'zz1') = 42.

	session stepIntoI: interpreter context. "return = zz1 `3"
	self assert: (interpreter context get: 'return') = 42.

	session stepIntoI: interpreter context. "end"
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

val zmain : (%i) -> %i64

fn zmain(_) {
  return = zxlen_val;
  end;
}

'.

	main := program lookupFunction: 'zmain'.

	interpreter := JibInterpreter for: main arguments: #(1).
	session := JibDebuggerSession for: interpreter.

	"
	JibDebugger openOn: session.
	"
	self assert: interpreter context function isRegister.
	session stepIntoI: interpreter context. "zz40 : %i64;"
	session stepIntoI: interpreter context. "zz40 = 64;"
	session stepIntoI: interpreter context. "zxlen_val = zz40;"

	self assert: interpreter context function isLet.
]

{ #category : #tests }
JibDebuggerSessionTests >> test_03c [
	| program main interpreter session |

	program := JibParser parse:'

let (zxlen_val: %i64) {
  zxlen_val = zf(());
}

val zf : (%unit) -> %i64

fn zf(_) {
  return = 64;
  end;
}

val zmain : (%i) -> %i64

fn zmain(_) {
  return = zxlen_val;
  end;
}

'.

	main := program lookupFunction: 'zmain'.

	interpreter := JibInterpreter for: main arguments: #(1).
	session := JibDebuggerSession for: interpreter.

	"
	JibDebugger openOn: session.
	"
	self assert: interpreter context function isLet.
	session stepIntoI: interpreter context. " zxlen_val = zf();"

	self assert: interpreter context function isFn.
	self assert: interpreter context function id = 'zf'.
	self assert: interpreter context caller function isLet.

	session stepIntoI: interpreter context caller.

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
	session stepOverI: interpreter context. "zz1 : %bv32 `1;"
	session stepOverI: interpreter context. "zz1 = zf(zarg) `2;"

	self assert: interpreter context function id = 'zmain'.
	self assert: interpreter context pc = 3.

	session stepOverI: interpreter context. "return = zz1 `3"
	self assert: (interpreter context get: 'return') = 42.

	session stepOverI: interpreter context. "end"
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
	session stepIntoI: interpreter context. "zz1 : %bv32 `1;"
	session stepIntoI: interpreter context. "zz1 = zf(zarg) `2;"

	self assert: interpreter context function id = 'zf'.
	self assert: interpreter context pc = 1.

	session stepOverI: interpreter context caller. "return = zz1 `3;"

	self assert: interpreter context function id = 'zmain'.
	self assert: interpreter context pc = 3.
]

{ #category : #tests }
JibDebuggerSessionTests >> test_04c [
	| program main interpreter session |

	program := JibParser parse:'

let (zxlen_val: %i64) {
  zxlen_val = zf(());
}

val zf : (%unit) -> %i64

fn zf(_) {
  return = 64;
  end;
}

val zmain : (%i) -> %i64

fn zmain(_) {
  return = zxlen_val;
  end;
}

'.

	main := program lookupFunction: 'zmain'.

	interpreter := JibInterpreter for: main arguments: #(1).
	session := JibDebuggerSession for: interpreter.

	"
	JibDebugger openOn: session.
	"
	self assert: interpreter context function isLet.
	session stepIntoI: interpreter context. " zxlen_val = zf();"

	self assert: interpreter context function isFn.
	self assert: interpreter context function id = 'zf'.
	self assert: interpreter context caller function isLet.

	session stepOverI: interpreter context caller.

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
	session stepIntoI: interpreter context. "zz1 : %bv32 `1;"
	session stepIntoI: interpreter context. "zz1 = zf(zarg) `2;"

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
	session stepIntoI: interpreter context. "zz1 : %bv32 `1;"
	session stepIntoI: interpreter context. "zz1 = zf(zarg) `2;"

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

val zmain : (%i) -> %i64

fn zmain(_) {
  return = zxlen_val;
  end;
}

'.

	main := program lookupFunction: 'zmain'.

	interpreter := JibInterpreter for: main arguments: { 1 }.
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

{ #category : #tests }
JibDebuggerSessionTests >> test_06a [
	| program main interpreter session |
	
	program := JibParser parse:'
val ze : (%i) -> %i
val zf : (%i) -> %i
val zg : (%i) -> %i

fn ze(zarg) {
  zz1 : %i `1;
  zz1 = 42 `1;
  return = zz1 `2;
  end;
}

fn zf(zarg) {
  zz2 : %i `3;
  zz2 = ze(zarg) `3;
  return = zz2 `4;
  end;
}

fn zg(zarg) {
  zz3 : %i `5;
  zz3 = zf(zarg) `5;
  return = zz3 `6;
  end;
}

'.

	main := program lookupFunction: 'zg'.

	interpreter := JibInterpreter for: main arguments: { 1 }.
	session := JibDebuggerSession for: interpreter.

	"
	JibDebugger openOn: session.
	"

	session stepInto: interpreter context. "zz3 : %i `5; zz3 = zf(zarg) `3"	
	self assert: (interpreter context function id = 'zf'). 
	
	session stepInto: interpreter context. "zz2 : %i `5; zz2 = ze(zarg) `3"	
	self assert: (interpreter context function id = 'ze'). 
	
	session stepInto: interpreter context. "zz1 : %i `1; 42 `1"	
	self assert: (interpreter context function id = 'ze'). 
	self assert: (interpreter context pc = 3). 
	
	session stepInto: interpreter context. "return = zz1 `2"	
	self assert: (interpreter context function id = 'ze'). 
	self assert: (interpreter context pc = 4). 
	
	session stepInto: interpreter context. "return = zz2 `4"	
	self assert: (interpreter context function id = 'zf'). 
	self assert: (interpreter context pc = 3). 
	
	self assert: (interpreter context caller function id = 'zg'). 
	self assert: (interpreter context caller pc = 3). 
	
	"
	JibDebugger openOn: session.
	"
	session stepInto: interpreter context caller. "	return = zz3 `6;"
	self assert: (interpreter context function id = 'zg'). 
	self assert: (interpreter context pc = 4). 
	
	session cont.
	self assert: (interpreter context isNil). 
	self assert: (interpreter retVal = 42). 
	

]

{ #category : #tests }
JibDebuggerSessionTests >> test_07a [
	| program main interpreter session |
	
	program := JibParser parse:'
val ze : (%i) -> %i
val zf : (%i) -> %i
val zg : (%i) -> %i

fn ze(zarg) {
  zz1 : %i `1;
  zz1 = 42 `1;
  return = zz1 `2;
  end;
}

fn zf(zarg) {
  zz2 : %i `3;
  zz2 = ze(zarg) `3;
  return = zz2 `4;
  end;
}

fn zg(zarg) {
  zz3 : %i `5;
  zz3 = zf(zarg) `5;
  return = zz3 `6;
  end;
}

'.

	main := program lookupFunction: 'zg'.

	interpreter := JibInterpreter for: main arguments: { 1 }.
	session := JibDebuggerSession for: interpreter.

	"
	JibDebugger openOn: session.
	"

	session stepInto: interpreter context. "zz3 : %i `5; zz3 = zf(zarg) `3"	
	self assert: (interpreter context function id = 'zf'). 
	
	session stepOver: interpreter context. "zz2 : %i `5; zz2 = ze(zarg) `3"	
	self assert: (interpreter context function id = 'zf'). 
	self assert: (interpreter context pc = 3). 
	
	session stepOver: interpreter context caller. "	return = zz3 `6;"
	self assert: (interpreter context function id = 'zg'). 
	self assert: (interpreter context pc = 4). 
	
	session stepOver: interpreter context.
	self assert: (interpreter context isNil). 
	self assert: (interpreter retVal = 42). 
	

]

{ #category : #tests }
JibDebuggerSessionTests >> test_08a_resume [
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

	self assert: interpreter context pc equals: 1.
	session stepIntoI: interpreter context. "zz39 : %bv32 `1;"

	self assert: interpreter context pc equals: 2.
	session resume.

	self assert: interpreter context isNil.
	self assert: interpreter retVal = 2r00000000000000000000000000101010.
]

{ #category : #tests }
JibDebuggerSessionTests >> test_08b_resume [
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
	session stepIntoI: interpreter context. "zz1 : %bv32 `1;"
	session stepIntoI: interpreter context. "zz1 = zf(zarg) `2;"

	self assert: interpreter context function id = 'zf'.
	self assert: interpreter context caller function id = 'zmain'.

	session stepIntoI: interpreter context. "zz39 : %bv32 `1;"

	session resume.

	self assert: interpreter context isNil.
	self assert: interpreter retVal = 2r00000000000000000000000000101010.
]

{ #category : #tests }
JibDebuggerSessionTests >> test_09a_restart [
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

	self assert: interpreter context pc equals: 1.
	self should: [interpreter context get: 'zz39' ] raise: AssertionFailure.

	session stepIntoI: interpreter context. "zz39 : %bv32 `1;"
	session stepIntoI: interpreter context. "zz39 = 0b00000000000000000000000000101010 `2;"

	self assert: (interpreter context get: 'zz39') = 42.
	self assert: interpreter context pc equals: 3.

	session restart: interpreter context.

	self assert: interpreter context pc equals: 1.
	self should: [interpreter context get: 'zz39' ] raise: AssertionFailure.
]

{ #category : #tests }
JibDebuggerSessionTests >> test_09b_restart [
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
	session stepIntoI: interpreter context. "zz1 : %bv32 `1;"
	session stepIntoI: interpreter context. "zz1 = zf(zarg) `2;"

	self assert: interpreter context function id = 'zf'.
	self assert: interpreter context caller function id = 'zmain'.

	session stepIntoI: interpreter context. "zz39 : %bv32 `1;"

	session restart: interpreter context caller.

	self assert: interpreter context function id equals: 'zmain'.
	self assert: interpreter context pc equals: 1.
	self should: [interpreter context get: 'zz1' ] raise: AssertionFailure.
]
