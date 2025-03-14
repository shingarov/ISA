Class {
	#name : #JibInterpreterTests,
	#superclass : #TestCase,
	#category : #'Sail-Jib-Interpreter-Tests'
}

{ #category : #tests }
JibInterpreterTests >> test_01a [
	| program main interpreter |
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

	interpreter
		interpret1; "zz39 : %bv32 `1;"
		interpret1; "zz39 = 0b00000000000000000000000000101010 `2;"
		interpret1; "return = zz39 `3"
		interpret1. "end"

	self assert: interpreter retVal = 2r00000000000000000000000000101010.



]

{ #category : #tests }
JibInterpreterTests >> test_01b [
	| program main interpreter |
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

	interpreter interpret.

	self assert: interpreter retVal = 2r00000000000000000000000000101010.



]

{ #category : #tests }
JibInterpreterTests >> test_02 [
	| program main interpreter |
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

	interpreter interpret.

	self assert: interpreter retVal = 2r00000000000000000000000000101010.



]

{ #category : #tests }
JibInterpreterTests >> test_03 [
	| program main interpreter |
	program := JibParser parse:'
register zPC : %bv32

val zmain : () ->  %bv32

fn zmain() {
  zz39 : %bv32;
  zz39 = 0x0000002A;
  zPC = zz39;
  zz40 : %bv32;
  zz40 = zPC;
  return = zz40;
  end;
}


'.

	main := program lookupFunction: 'zmain'.

	interpreter := JibInterpreter for: main arguments: { }.

	interpreter interpret.

	self assert: interpreter retVal = 16r2A.
	self assert:(interpreter getRegister: 'zPC') = 16r2A.



]
