Class {
	#name : #JibParsingTest,
	#superclass : #JibTest,
	#category : #'Sail-Jib-Tests'
}

{ #category : #tests }
JibParsingTest >> testParseDuopod [
	(self parseFileNamed: '/home/boris/work/REMS/duopod.ir') inspect
]

{ #category : #tests }
JibParsingTest >> testParseZhexBits12forwards [
	"Function zhex_bits_12_forwards from riscv64.ir"
	| program function b0 b47 b49 |
	program := self parseString: '

fn zhex_bits_12_forwards(zargz3) {
  zz40 : %bv12 `251;
  zz40 = zargz3 `252;
  zz41 : %union zoptionzIszK `253;
  zz44 : %union zoptionzIszK `254;
  zz45 : %bv12 `4 100:46-100:61;
  zz45 = zz40 `4 100:46-100:61;
  zz46 : %bool `255;
  zz416 : %bv `256;
  zz416 = zz45 `257;
  zz46 = zhex_bits_forwards_matches(zz416) `258;
  jump @not(zz46) goto 12 `259;
  goto 13; 
  goto 39; 
  zz47 : %struct ztuplez3z5i64_z5string `4 100:46-100:61;
  zz414 : %bv `260;
  zz414 = zz45 `261;
  zz415 : %struct ztuplez3z5i_z5string `262;
  zz415 = zhex_bits_forwards(zz414) `263;
  zz47.ztuplez3z5i64_z5string0 = zz5izDzKz5i64(zz415.ztuplez3z5i_z5string0) `264;
  zz47.ztuplez3z5i64_z5string1 = zz415.ztuplez3z5i_z5string1 `265;
  zz48 : %union zoptionzIszK `4 100:46-100:61;
  zz49 : %i64 `4 100:55-100:57;
  zz49 = zz47.ztuplez3z5i64_z5string0 `4 100:55-100:57;
  zz410 : %string `4 100:59-100:60;
  zz410 = zz47.ztuplez3z5i64_z5string1 `4 100:59-100:60;
  zz411 : %i `266;
  zz411 = zz5i64zDzKz5i(12) `267;
  zz412 : %bool `4 100:46-100:61;
  zz413 : %i `268;
  zz413 = zz5i64zDzKz5i(zz49) `269;
  zz412 = zeq_int(zz413, zz411) `270;
  jump @not(zz412) goto 33 `4 100:46-100:61;
  goto 34; 
  goto 36; 
  zz48 = zSomezIszK(zz410) `271;
  goto 37; 
  zz48 = zNonezIszK(()) `272;
  zz44 = zz48 `4 100:46-100:61;
  goto 40; 
  zz44 = zNonezIszK(()) `273;
  zz41 = zz44 `274;
  zz42 : %string `275;
  jump zz41 is zSomezIszK goto 47 `276;
  zz43 : %string `277;
  zz43 = zz41 as zSomezIszK `278;
  zz42 = zz43 `279;
  goto 48; 
  exit match `280;
  return = zz42 `281;
  end;
}

'.

	function := program values at: 'zhex_bits_12_forwards'.

	self assert: (function body instrs at: 47 + 1) isExit.
	self assert: (function body instrs at: 49 + 1) isEnd.

	"Check that entry block has two successors..."
	b0 := function body blocks detect:[:bb | bb range first == 0].
	self assert: b0 successor1 notNil.
	self assert: b0 successor2 notNil.

	"Check that block with exit has no successors"
	b47 := function body blocks detect:[:bb | bb range last == 47"index of exit"].
	self assert: b47 successor1 isNil.
	self assert: b47 successor2 isNil.

	"Check that block with end has no successors"
	b49 := function body blocks detect:[:bb | bb range last == 49"index of end"].
	self assert: b49 successor1 isNil.
	self assert: b49 successor2 isNil.

	"Now, compute liveness..."
	JibFnBodyBlockLiveness compute: function body.
	"...and check that entry blocks' live-ins are only arguments"
	self assert: (b0 liveness liveIn allSatisfy:[:id|id beginsWith:'zarg']).
	"...and also that terminal blocks have no live-outs"
	self assert:  b47 liveness liveOut isEmpty.
	self assert:  b49 liveness liveOut isEmpty.



]
