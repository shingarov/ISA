Class {
	#name : #JibSemanticAnalysisTest,
	#superclass : #JibTest,
	#category : #'Sail-Jib-Tests'
}

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
JibSemanticAnalysisTest >> test_return_true [

	| jib |
	jib := JibParser parse:'

val zmain : (%i) -> %bool
fn  zmain(mainArg) {
  return = true;
  end;
}
'.

	jib doSemanticAnalysis 
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
