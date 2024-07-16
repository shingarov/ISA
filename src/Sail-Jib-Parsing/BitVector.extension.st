Extension { #name : #BitVector }

{ #category : #'*Sail-Jib-Parsing' }
BitVector class >> parser0b [
	^ '0b' asParser
	, (($0 asParser / $1 asParser) plus flatten
	   ==> [ :x | (Integer readFrom: x base: 2) toBitVector: x size ])
	==> #second
]
