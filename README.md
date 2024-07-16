# Complete, authoritative ISA Semantics

This repo contains tools for machine reasoning about the ISA semantics
of processors.  These tools are part of our larger Smalltalk-25 project
(described e.g. in our
[Towards a Dynabook for verified VM construction](https://doi.org/10.1016/j.cola.2024.101275)
paper),
which uses them for verification of the Tinyrossa compiler
and for synthesis of the PIG superoptimizer.

There exists a long tradition of mechanized reasoning about processor
semantics.  In the recent decade, the field has enjoyed significant progress.
We have advanced from ad-hoc fragmentary axiomatizations and vendors'
semi-formal specification documents,
to systems such as Armstrong _et al._'s
[Sail](https://dl.acm.org/doi/10.1145/3290384) /
[Isla](https://link.springer.com/article/10.1007/s10703-023-00409-y)
which compute with full-scale authoritative definitions taking into accout
both sequential and nondeterministic aspects of the semantics.

Our tooling builds on top of Armstrong _et al._'s Isla
and Alglave _et al._'s Cat.
We take
[Jib IR](https://github.com/rems-project/sail/blob/sail2/language/jib.ott)
and from there we have a few usage scenatios:

- proving invariants about running code by transforming into MachineArithmetic core; or
- the simpler scenario of simulating a sequential machine by symbolic interpretation.

## Other sources of ISA semantics

One would wish to hope that formal semantics specifications were available
for all ISAs of interest (RISC-V, OpenPOWER, AArch64, MIPS) via some uniform
way; unfortunately, this is not the case, therefore we have to consider
alternative forms of ISA definitions.

For example, even if the now-deprecated partial Sail definition of POWER
were alive, the authoritative definition is still the detailed
pseudocode in the "Green Cloth".
[Libre-SOC OpenPOWER core](https://git.libre-soc.org/git/openpower-isa.git)
machine-processes this pseudocode to arrive at "ISACaller";
we adopt this to serve as our POWER definition.

