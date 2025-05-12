Class {
	#name : #JibSpriteTest,
	#superclass : #SpriteLangTest,
	#category : #'Sail-Jib-Tests-Sprite'
}

{ #category : #tests }
JibSpriteTest >> test_mutRecData [
	self proveSafe: '
type u =
  | Nil (int)
  | NonNil (xs:s)
  ;

type s =
  | S (x:u)
  ;

⟦val main: x:int => int⟧
let main = (x) => {
    let myU = Nil(42);
    let myS = S(myU);
    let anotherU = NonNil(myS);
    switch (anotherU){
      | Nil => 1
      | NonNil(sx) => 0
    }
};
'
]

{ #category : #tests }
JibSpriteTest >> test_twoData [
	self proveSafe: '
type u =
  | NonNil (s)
  | MonMil (t)
  ;

type s =
  | S (int)
  ;

type t =
  | T (int)
  ;

⟦val main: u => int⟧
let main = (x) => {
    0
};
'
]
