Class {
	#name : #JibVerificationTest,
	#superclass : #JibTest,
	#category : #'Sail-Jib-Tests'
}

{ #category : #tests }
JibVerificationTest >> prove: check jibProgramSource: j [
	| finalCheck jib prog |
	finalCheck := (ΛοParser parse: check) expr.
	jib := JibParser parse: j.
	jib topExpr: finalCheck.
	jib doSemanticAnalysis
]

{ #category : #tests }
JibVerificationTest >> refute: check jibProgramSource: j [
	| finalCheck jib prog |
	finalCheck := (ΛοParser parse: check) expr.
	jib := JibParser parse: j.
	jib topExpr: finalCheck.
	self should: [jib doSemanticAnalysis] raise: Error
]

{ #category : #tests }
JibVerificationTest >> test_le_p [
	self prove: '
    ⟦val final_result : bool[v|v]⟧
    let final_result = zmain(0);
	' jibProgramSource: '
val zmain : (%i) -> %bool
fn zmain(zx) {
    zz1 : %bool;
    zz1 = @lt(0, 1);
    return = zz1;
    end;
}
'

]

{ #category : #tests }
JibVerificationTest >> test_neq_p [
	self prove: '
    ⟦val final_result : bool[v|v]⟧
    let final_result = zmain(0);
	' jibProgramSource: '
val zmain : (%i) -> %bool
fn zmain(zx) {
    zz1 : %bool;
    zz1 = @neq(0, 1);
    return = zz1;
    end;
}
'

]

{ #category : #tests }
JibVerificationTest >> test_return_42_n [
	self refute: '
    ⟦val final_result : int[v|v === 42]⟧
    let final_result = zmain(0);
	' jibProgramSource: '
val zmain : (%i) -> %i
fn  zmain(mainArg) {
  zz39 : %i;
  zz39 = 43;
  return = zz39;
  end;
}
'
]

{ #category : #tests }
JibVerificationTest >> test_return_42_p [
	self prove: '
    ⟦val final_result : int[v|v === 42]⟧
    let final_result = zmain(0);
	' jibProgramSource: '
val zmain : (%i) -> %i
fn  zmain(mainArg) {
  zz39 : %i;
  zz39 = 42;
  return = zz39;
  end;
}
'
]

{ #category : #tests }
JibVerificationTest >> test_true_n [
	self refute: '
    ⟦val final_result : bool[v|v]⟧
    let final_result = zmain(0);
	' jibProgramSource: '
val zmain : (%i) -> %bool
fn zmain(zx) {
    zz1 : %bool;
    zz1 = false;
    return = zz1;
    end;
}
'

]

{ #category : #tests }
JibVerificationTest >> test_true_p [
	self prove: '
    ⟦val final_result : bool[v|v]⟧
    let final_result = zmain(0);
	' jibProgramSource: '
val zmain : (%i) -> %bool
fn zmain(zx) {
    zz1 : %bool;
    zz1 = true;
    return = zz1;
    end;
}
'

]
