Class {
	#name : #JibVerificationTest,
	#superclass : #JibTest,
	#category : #'Sail-Jib-Tests'
}

{ #category : #'tests - 42' }
JibVerificationTest >> mainExpecting42 [
 ^'
⟦val main : bv32 => bv32[v|v===42]⟧
let main = (x) => {
    zf(x)
};
'
]

{ #category : #'tests - 42' }
JibVerificationTest >> proveReturns42: jibSource [
	| ir prog |
	ir := self parseString: jibSource.
	prog := ir toSpriteProgWithMainSource: self mainExpecting42.
	self assert: prog solve isSafe
]

{ #category : #'tests - 42' }
JibVerificationTest >> refuteReturns42: jibSource [
	| ir prog |
	ir := self parseString: jibSource.
	prog := ir toSpriteProgWithMainSource: self mainExpecting42.
	self deny: prog solve isSafe
]

{ #category : #'tests - 42' }
JibVerificationTest >> testExecuteReturn42a_n [
	self refuteReturns42: '
val zf : (%bv32) -> %bv32

fn zf(zarg) {
  zz39 : %bv32 `1;
  zz39 = 0b10000000000000000000000000101010 `2;
  return = zz39 `3;
  end;
}

'
]

{ #category : #'tests - 42' }
JibVerificationTest >> testExecuteReturn42a_p [
	self proveReturns42: '
val zf : (%bv32) -> %bv32

fn zf(zarg) {
  zz39 : %bv32 `1;
  zz39 = 0b00000000000000000000000000101010 `2;
  return = zz39 `3;
  end;
}

'
]
