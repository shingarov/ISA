Class {
	#name : #JibInterpreterTests,
	#superclass : #TestCaseWithZ3Context,
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

val zmain : (%i) ->  %bv32

fn zmain(_) {
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

	interpreter := JibInterpreter for: main arguments: { 1 }.

	interpreter interpret.

	self assert: interpreter retVal = 16r2A.
	self assert:(interpreter getRegister: 'zPC') = 16r2A.
]

{ #category : #tests }
JibInterpreterTests >> test_04 [
	| program main interpreter |
	program := JibParser parse:'
val zmain : (%bool) ->  %bool

fn zmain(zarg) {
  zz1 : %bool;
  zz1 = @neq(zarg, false);
  zz1 = @not(zarg);
  return = zz1;
  end;
}

'.

	main := program lookupFunction: 'zmain'.

	interpreter := JibInterpreter for: main arguments: { true toBool }.

	interpreter interpret.

	self assert: interpreter retVal = false.



]

{ #category : #tests }
JibInterpreterTests >> test_05 [
	| program main interpreter |
	program := JibParser parse:'

val zsign_extend = "sign_extend" : (%bv, %i) ->  %bv	

val zmain : (%bv16) ->  %bv32

fn zmain(zarg) {
  zz1 : %bv32;
  zz1 = zsign_extend(zarg, 32);
  return = zz1;
  end;
}

'.

	main := program lookupFunction: 'zmain'.

	interpreter := JibInterpreter for: main arguments: { -1 toBitVector: 16 }.

	interpreter interpret.

	self assert: interpreter retVal simplify = (-1 toBitVector: 32).



]

{ #category : #tests }
JibInterpreterTests >> test_06l [
	| program main interpreter |
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

	interpreter interpret.

	self assert: interpreter retVal  = 64.



]

{ #category : #tests }
JibInterpreterTests >> test_06r [
	| program main interpreter |
	program := JibParser parse:'

register zxlen_val : %i64 {
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

	interpreter := JibInterpreter for: main arguments: { -1 toBitVector: 16 }.

	interpreter interpret.

	self assert: interpreter retVal  = 64.



]

{ #category : #tests }
JibInterpreterTests >> test_07 [
	| program main interpreter |
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

	interpreter := JibInterpreter for: main arguments: { 1 }.

	interpreter interpret.

	self assert: interpreter retVal  = 64.



]

{ #category : #tests }
JibInterpreterTests >> test_08a [
	| program main interpreter |
	program := JibParser parse:'

enum ziop {
  zRISCV_ADDI,
  zRISCV_SLTI,
  zRISCV_SLTIU,
  zRISCV_XORI,
  zRISCV_ORI,
  zRISCV_ANDI
}

val zmain : (%i) -> %enum ziop
fn  zmain(_) {
  return = zRISCV_ADDI;
  end;
}

'.

	main := program lookupFunction: 'zmain'.

	interpreter := JibInterpreter for: main arguments: { 1 }.

	interpreter interpret.

	self assert: interpreter retVal isDatatype.
	self assert: interpreter retVal printString = 'zRISCV_ADDI'


]

{ #category : #tests }
JibInterpreterTests >> test_08b [
	| program main interpreter |
	program := JibParser parse:'

enum ziop {
  zRISCV_ADDI,
  zRISCV_SLTI,
  zRISCV_SLTIU,
  zRISCV_XORI,
  zRISCV_ORI,
  zRISCV_ANDI
}

val zmain : (%i) -> %enum ziop
fn  zmain(_) {
	zz1 : %enum ziop;
	zz1 = zRISCV_ANDI;
  return = zz1;
  end;
}

'.

	main := program lookupFunction: 'zmain'.

	interpreter := JibInterpreter for: main arguments: { 1 }.

	interpreter interpret.

	self assert: interpreter retVal isDatatype.
	self assert: interpreter retVal printString = 'zRISCV_ANDI'


]

{ #category : #tests }
JibInterpreterTests >> test_08c [
	| program main interpreter |
	program := JibParser parse:'

enum ziop {
  zRISCV_ADDI,
  zRISCV_SLTI,
  zRISCV_SLTIU,
  zRISCV_XORI,
  zRISCV_ORI,
  zRISCV_ANDI
}

val zmain : (%i) -> %enum ziop
fn  zmain(_) {
	zz1 : %enum ziop;
  return = zz1;
  end;
}

'.

	main := program lookupFunction: 'zmain'.

	interpreter := JibInterpreter for: main arguments: { 1 }.

	interpreter interpret.

	self assert: interpreter retVal isDatatype.
	self assert: interpreter retVal printString = 'undefined!1'


]

{ #category : #tests }
JibInterpreterTests >> test_09a [
	| program main interpreter |
	program := JibParser parse:'

val zmain : (%i) -> %unit
fn  zmain(_) {
  return = ();
  end;
}

'.

	main := program lookupFunction: 'zmain'.

	interpreter := JibInterpreter for: main arguments: { 1 }.

	interpreter interpret.

	self assert: interpreter retVal isDatatype.
	self assert: interpreter retVal sort name asString = '__unit__'.
	self assert: interpreter retVal printString = '__unit__'.
	

]

{ #category : #tests }
JibInterpreterTests >> test_09b [
	| program main interpreter |
	program := JibParser parse:'

val zmain : (%i) -> %unit
fn  zmain(_) {
	zz1 : %unit;
	zz1 = ();
  return = zz1;
  end;
}

'.

	main := program lookupFunction: 'zmain'.

	interpreter := JibInterpreter for: main arguments: { 1 }.

	interpreter interpret.

	self assert: interpreter retVal isDatatype.
	self assert: interpreter retVal sort name asString = 'unit__'.
	self assert: interpreter retVal printString = 'unit__'.
	

]

{ #category : #tests }
JibInterpreterTests >> test_09c [
	| program main interpreter |
	program := JibParser parse:'

val zmain : (%i) -> %unit
fn  zmain(_) {
	zz1 : %unit;
  return = zz1;
  end;
}

'.

	main := program lookupFunction: 'zmain'.

	interpreter := JibInterpreter for: main arguments: { 1 }.

	interpreter interpret.

	self assert: interpreter retVal isDatatype.
	self assert: interpreter retVal sort name asString = '__unit__'.
	

]
