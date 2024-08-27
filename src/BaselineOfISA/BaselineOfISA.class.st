Class {
	#name : #BaselineOfISA,
	#superclass : #BaselineOf,
	#category : #BaselineOfISA
}

{ #category : #baselines }
BaselineOfISA >> baseline: spec [
	<baseline>

	spec for: #'pharo' do: [
		spec baseline: 'MachineArithmetic' with: [
				spec repository: 'github://shingarov/MachineArithmetic:pure-z3'
		].

		spec baseline: 'Roassal3' with: [
			spec repository: 'github://ObjectProfile/Roassal3:v0.9.2'
		].


		spec package: 'Sail-Jib' with:[
			spec requires: 'Sail-Jib-Debugger';
			     requires: 'Sail-Jib-Parsing';
			     requires: 'Roassal3'.

		].

		spec package: 'Sail-Jib-Debugger' with:[
		].

		spec package: 'Sail-Jib-Parsing' with:[
			"spec requires: 'Sail-Jib'."
		].

		spec package: 'Sail-Jib-Tests' with:[
			spec requires: 'Sail-Jib-Debugger';
			     requires: 'Sail-Jib-Parsing';
			     requires: 'Sail-Jib'.
		].
 ]
]
