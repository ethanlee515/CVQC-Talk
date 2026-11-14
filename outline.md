# Outline for the Slides

Draft outline to be turned into LaTeX

## Title page

Boilerplate

## CVQC

Two parties, one "Verifier" one "Prover".

Speaker note: Say client-server things

Also motivate with quantum supremacy, proof of quantumness, or however Mahadev used to sell these things...

### Slide 2 (transition)

Callout on Verifier, maybe just "`C(x)`: quantum circuit"?

### Next transition

Double-ended arrow between verifier and prover

Speaker note: Parties exchange some messages

### Next transition

Callout on Verifier, maybe `y` or something

### Next transition

`y <- C(x)` or reject

Speaker note: security notion

## CVQC strategy

Two parties, one "weak quantum verifier" one "prover", protocol `pi` between.
Box surrounding both parties labelled "QPIP1"

Arrow from this box, say "compile"

Bottom, also two parties, one "classical verifier" one "prover"
Box surrounding both parties labelled "QPIP0"

## CVQC strategy, paradigm 1: prepare-and-send

Similar to last slide, version above has one-directional arrow,
verifier to prover, `ket{+_theta}`

Version below replaces with arrow with `RSP`

## CVQC strategy, paradigm 1: receive-and-measure

Similar to last slide, version above has the other directional arrow, `ket{psi_hist}`

Version below replaces with arrow with "commit-and-measure"

## Literature survey

Something like this, unsure about precise wording/label

Maybe do animation, reveal one row each transition

---
| Work | Paradigm | Problem type | Soundness errors |
| GV, ??? | prepare-and-send | Decision problems | negligible |
| Mahadev, Chung-Yamagawa-??, ?? | receive-and-measure | Decision problems | negligible |
| CLLW | receive-and-measure | Sampling problems | inverse-poly |
| This work | prepare-and-send | Sampling problems | negligible |
| Justin Raizes and others (?) | receive-and-measure | Sampling problems | negligible |
---

Speaker note: Mention that the last row is concurrent work, submission 598 to STOC

## Main contributions

Not sure how to do this as nice visuals, but...
1. QPIP1 with negligible soundness errors, statistically secure
2. QPIP0 with negligible soundness errors using QFHE

## Background: Distillation

漏斗-shaped, trapezoid-shaped box maybe?
Bunch of `\ket{CCZ}` goes in, one comes out

* Standard tool in QC impl. (?)
* Imperfect copies go in, perfect copies out
* Verifiable

Change the diagram above,
"garbage" in, and "rej" out.
(One of the slides in the reference does something like this I think.)
^
TODO this is untrue.
Need most copies good or distillation outcomme is straight up wrong.

Question: For distillation of `ket{T}`, if input is all conjugated, is the output also conjugated?
(I guess it is and will be a good counter-example?)

* Transition to next slide: Assumes honest distiller. For dishonest distiller, need authentication.
* Change figure to `auth(ket(CCZ))`?

## Background: Quantum Authentication

* Maybe take from reference slides: `x -> Enc -> Atk -> Dec -> x` or some figure like that...
* Trap code construction and intuition I guess? The reference slides are an old version, think the newest version (see git) has a decent figure

## Background: Homomorphic Eval. over QAS

* Homomorphic eval, maybe the typical commutative diagram. There might be one here to copy/paste: https://github.com/ethanlee515/Mending-Slides
* Maybe CNOT example? Maybe just assume knowledge of QEC, say "transversal" and assume audience know what that means...

## Our protocol overview

Similar to the flowchart in the reference slides, top to bottom
3 steps

RSP (rounded rect box?)
-> (make vertical arrow)
ket{+ theta}, ket{0/1}
->
MBQC (box)
->
TEnc{CCZ}
->
Authenticated distillation (rounded rect box)
->
TEnc{CCZ}
->
Eval (rounded rect box)
->
output

### Transition

Put box over everything except RSP, label it QPIP1

## Challenges

Don't know what is good visual here either...

Maybe stay on the same slide, just arrow at the `ket{CCZ}` between MBQC and Distill?

Challenges:
* What does MBQC guarantee?
* What is distillable?

(Recall earlier, 1/poly all garbage = can be cheated)

## MBQC Construction

Start with picture before, verifier sends `ket{+ theta}` to prover

(somehow connect here?)

Gate teleportation circuit from the paper's intro

Say we have this and CZ, it's universal.

## MBQC Trap copy?

Gate teleportation again with different inputs

Remark this is different from Fitzsimons-Keshefi, we have separate copies. (There is good one-sentence wording in paper, forgot what was it.)

Say we have to encrypt everything

## MBQC OTP...

* Draw the encrypted version of real copy.
  * `X^x T^t` on input
  * `delta = ...`
  * `XOR r` on wire

## MBQC Analysis: Iterative Pauli twirling

Idea: *Iterative* twirling. Once per round of communication.

Figure: two circuits with arrow between:
`OTP -> A -> OTP^dag` -> `Q`
Math: `A = sum Q`

Iterative: change first circuit to two wires, temporarily remove second circuit.
`OTP -> A1 -> OTP^dag -> A2 -> OTP^dag`

Challenge: `CNOT_21 = I otimes dyad{0} + X otimes dyad{1}`.
Treat subnormalization carefully.

## MBQC Analysis:

Circuit mutation.
* Start from real copy before
* Add attack right before measurement
* Commute encryption (?)
* Used to be sequence of circuits on the paper, check if they're still around in git history?

Interpretation:
* Attack is `X^aZ^b`.
  * `a = 0` is no-op
  * `a = 1` is plaintext-level attack, leaves OTP unchanged.

We call this *factorizable attack*
* Subsumes blindness
* Comparison with isometry: This is statistical, but ct-level attack looks like an isometry.

## Distillation Challenges

Don't know what is good figure here... hm.

Story:
* Existing MPQC uses distillation in a modular way
* Good authentication, possibly bad plaintext
* ^ Maybe same trapezoid thing, but TEnc(ket(CCZ)) in and out, and only the ket(CCZ) is red?
* In our setting, the entire TEnc is red.

## Distillation construction

4-to-1 circuit (as in paper's intro)

Speaker note: say this works for ancilla, this can extended to other states

Say (maybe extra bullet point?), run recursively, `ket{0^{4^L}} \mapsto ket{0}`.

## Distillation construction cont.

Change the inputs from ket(0) to TEnc(ket(0))

## Distillation Analysis/Challenges (?)

* No "good" TEnc => Adversary *can* cheat a priori during distillation
* Side note: privacy matters, adversary cannot learn secret key. Factorizability subsumes blindness
* Verification: In general, can't say output is always "good". At best up to isometry.
* => Only correct up to ciphertext-level attack.
* Guarantees:
  * 3x ct-level + 1x factorizable `mapsto` 1x ct-level
  * 4x factorizable `mapsto` factorizable

## Distillation Analysis Intuitions

Maybe more circuits

* One plaintext-attacked wire (maybe fixed as X3), `OTP`, (unfolded) `C_dist`, ct-level attack (3-wires), `OTP^dag`
* Move OTP
* Twirl, make ct-level attack Pauli
* Propagate, X3 becomes X1 + X3 + X4
* Conditioned on acc, Q4 = X4
* => Final attack = Q4

Key observation, final attack can be written in terms of just attacked wire + ct-level attacks

## QPIP0: RSP construction

* 4-message thing, used to be a figure in the paper that was deleted, find in git history
* Call that once for each `ket{+ theta}`, maybe just `pi_RSP pi_RSP ... pi_RSP` boxes, each with output `ket{+ theta}`
  Speaker note: say that most of the output copies would be good => distillable
* Here replace some outputs with `ket{+ theta}` with overlines over them.
  Speaker note: describe complex conjugate attacks in words
* Change each output to be `(ket(+ theta))_{i=1}^9`
  Say check consistency in pairs, analysis says 8 neighbor checks are enough.
* Caveat: Need factorizability too. Check our paper for the full analysis.

## Future work

* Weaken assumptions from FHE to TCF
* Check MPQC literature? Pseudo-determism reqs and stuff...

## Thank you slide?
