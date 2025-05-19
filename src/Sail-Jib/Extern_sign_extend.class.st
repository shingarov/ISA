Class {
	#name : #'Extern_sign_extend',
	#superclass : #JibExtern,
	#category : #'Sail-Jib'
}

{ #category : #accessing }
Extern_sign_extend class >> id [
	^ 'sign_extend'" : %bv , %i -> %bv "
]

{ #category : #evaluating }
Extern_sign_extend >> evaluateWithArguments: args [
	^ args first signExtend: args second value - args first length
]
