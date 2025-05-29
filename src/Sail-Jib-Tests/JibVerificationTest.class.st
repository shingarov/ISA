Class {
	#name : #JibVerificationTest,
	#superclass : #JibTest,
	#category : #'Sail-Jib-Tests'
}

{ #category : #tests }
JibVerificationTest >> test_return_42_n [
	| finalCheck jib prog |
	finalCheck := (ΛοParser parse: '
    ⟦val final_result : int[v|v === 42]⟧
    let final_result = zmain(0);
	') expr.
	
	jib := JibParser parse:'
val zmain : (%i) -> %i
fn  zmain(mainArg) {
  zz39 : %i;
  zz39 = 43;
  return = zz39;
  end;
}
'.

	jib topExpr: finalCheck.
	self should: [jib doSemanticAnalysis] raise: Error
]

{ #category : #tests }
JibVerificationTest >> test_return_42_p [
	| finalCheck jib prog |
	finalCheck := (ΛοParser parse: '
    ⟦val final_result : int[v|v === 42]⟧
    let final_result = zmain(0);
	') expr.
	
	jib := JibParser parse:'
val zmain : (%i) -> %i
fn  zmain(mainArg) {
  zz39 : %i;
  zz39 = 42;
  return = zz39;
  end;
}
'.

	jib topExpr: finalCheck.
	jib doSemanticAnalysis
]
