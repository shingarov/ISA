Class {
	#name : #JibSemanticAnalysisTest,
	#superclass : #JibTest,
	#category : #'Sail-Jib-Tests'
}

{ #category : #tests }
JibSemanticAnalysisTest >> test_duopod [
	| program |

	program := self parseFileNamed: JibExamples / 'Jib' / 'duopod.ir'.
	program doSemanticAnalysis.

]

{ #category : #tests }
JibSemanticAnalysisTest >> test_enum [
	| program |
	program := JibParser parse:'
enum ziop {
  zRISCV_ADDI,
  zRISCV_SLTI,
  zRISCV_SLTIU,
  zRISCV_XORI,
  zRISCV_ORI,
  zRISCV_ANDI
}

val zmain : (%enum ziop) -> %i
fn  zmain(mainArg) {
  return = 0;
  end;
}

'.

	program doSemanticAnalysis.
	self assert: (program environment lookupSortForTypename: 'ziop') numConstructors equals: 6
]

{ #category : #'tests - exp' }
JibSemanticAnalysisTest >> test_exp_call [

	| jib prog |
	jib := JibParser parse:'

val zmain : (%i) -> %bool
fn  zmain(mainArg) {
  return = @neq(mainArg, 0);
  end;
}
'.

	jib doSemanticAnalysis 
]

{ #category : #'tests - exp' }
JibSemanticAnalysisTest >> test_exp_field [
	| program |
	program := JibParser parse:'

struct i {
  g: %i
}

val zmain : (%struct i) -> %i
fn  zmain(x) {
	zz1 : %i;
	zz1 = x.g;
  return = zz1;
  end;
}

'.

	program doSemanticAnalysis.
]

{ #category : #'tests - exp' }
JibSemanticAnalysisTest >> test_exp_kind [
	| program |
	program := JibParser parse:'

union u {
  I: %struct i,
  B: %struct b
}

struct i {
  i: %i
}

struct b {
  b: %bool
}

val zmain : (%union u) -> %bool
fn  zmain(mainArg) {
	zz1 : %bool;
	zz1 = mainArg is I;
  return = zz1;
  end;
}

'.

	program doSemanticAnalysis.
]

{ #category : #'tests - exp' }
JibSemanticAnalysisTest >> test_exp_struct [
	| program |
	program := JibParser parse:'

struct p {
	x: %i,
	y: %i
}

val zmain : (%i, %i) -> %struct p
fn  zmain(a,b) {
	zz1 : %struct p;
	zz1 = struct p { y = b, x = a};
  return = zz1;
  end;
}

'.

	program doSemanticAnalysis.
]

{ #category : #'tests - exp' }
JibSemanticAnalysisTest >> test_exp_unwrap [
	| program |
	program := JibParser parse:'

union u {
  I: %struct i,
  B: %struct b
}

struct i {
  i: %i
}

struct b {
  b: %bool
}

val zmain : (%union u) -> %struct i
fn  zmain(mainArg) {
	zz1 : %struct i;
	zz1 = mainArg as I;
  return = zz1;
  end;
}

'.

	program doSemanticAnalysis.
]

{ #category : #'tests - instr' }
JibSemanticAnalysisTest >> test_instr_call_multiple_args [

	| jib |
	jib := JibParser parse:'
val zfoo : (%i, %i) -> %bool
fn  zfoo(a,b) {
	return = true;
	end;
}

val zmain : (%i) -> %bool
fn  zmain(mainArg) {
  return = zfoo(1, mainArg);
  end;
}
'.

	jib doSemanticAnalysis 
]

{ #category : #'tests - instr' }
JibSemanticAnalysisTest >> test_instr_call_onearg [

	| jib prog |
	jib := JibParser parse:'
val zfoo : (%i) -> %bool
fn  zfoo(a) {
	return = true;
	end;
}
val zmain : (%i) -> %bool
fn  zmain(mainArg) {
  return = zfoo(1);
  end;
}
'.

	jib doSemanticAnalysis 
]

{ #category : #tests }
JibSemanticAnalysisTest >> test_jump_goto_01 [
	| program |
	program := JibParser parse:'

    val zmain : (%i) -> %i

    fn zmain(zx) {
        zz1 : %i      			    `0;
        jump @neq(zx, 0) goto 4 `1;       
        zz1 = 1                 `2;
        goto 5;
        zz1 = 42                `4;
        return = zz1            `5;
        end;
    }

    register zPC : %bv64
'.
'
			
        
'.

	program doSemanticAnalysis.
]

{ #category : #tests }
JibSemanticAnalysisTest >> test_mutRecData [
	| program main interpreter |
	program := JibParser parse:'

union u {
  Nil: %i,
  NonNil: %struct s
}

struct s {
  x: %union u
}

val zmain : (%i) -> %i
fn  zmain(mainArg) {
  return = 0;
  end;
}

'.

	program doSemanticAnalysis.
]

{ #category : #tests }
JibSemanticAnalysisTest >> test_return42_bv32 [

	| jib  |
	jib := JibParser parse:'

val zmain : (%i) -> %bv32
fn  zmain(mainArg) {
  return = #x00112233;
  end;
}
'.

	jib doSemanticAnalysis 
]

{ #category : #tests }
JibSemanticAnalysisTest >> test_return42_i [

	| jib |
	jib := JibParser parse:'

val zmain : (%i) -> %i
fn  zmain(mainArg) {
  return = 42;
  end;
}
'.

	jib doSemanticAnalysis 
]

{ #category : #tests }
JibSemanticAnalysisTest >> test_return_true [

	| jib prog |
	jib := JibParser parse:'

val zmain : (%i) -> %bool
fn  zmain(mainArg) {
  return = true;
  end;
}
'.

	jib doSemanticAnalysis.
	prog := jib spriteProg.




]

{ #category : #tests }
JibSemanticAnalysisTest >> test_twoData [
	| program |
	program := JibParser parse:'

union u {
  NonNil: %struct s,
  MonMil: %struct t
}

struct s {
  x: %i
}

struct t {
  y: %i
}

val zmain : (%union u) -> %i
fn  zmain(mainArg) {
  return = 0;
  end;
}

'.

	program doSemanticAnalysis.
	self deny:   (program environment lookupSortForTypename: 'u') isTuple.
	self assert: (program environment lookupSortForTypename: 's') isTuple.
	self assert: (program environment lookupSortForTypename: 't') isTuple.

]
