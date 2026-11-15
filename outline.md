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

Current slide: vertical funnel in the upper right, with five builds: standard building block; resource-state error from inverse-polynomial to negligible; mostly good inputs per batch; a correlated all-bad batch with inverse-polynomial probability can leave inverse-polynomial accepted error; untrusted distillation needs authentication. On the final build, wrap the resources in Enc and make the distillation label red. Keep the input-quality precondition distinct from honest execution.

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

Current implementation: two slides. QAS is a single Enc -> Attack -> Dec diagram, returning the state or rejection. The trap code has two builds: encoded data plus two trap types, then "one-time pad + permute" and the hidden qubits. Explain the symmetric key, security guarantee, and decryption checks in words; keep these details in speaker notes.

* Save the question "Who do we trust to run the distillation?" for this later slide, following the background slide's authentication bullet.
* Maybe take from reference slides: `x -> Enc -> Atk -> Dec -> x` or some figure like that...
* Trap code construction and intuition I guess? The reference slides are an old version, think the newest version (see git) has a decent figure

## Background: Homomorphic Eval. over QAS

Current implementation: two slides. First, the desired computation and then the authenticated route around a commutative diagram. Second, transversal CNOT on two trap-code blocks with the same permutation; a transition reveals the matched data and trap positions. Explain key updates and correctness in words, with details in speaker notes.

* Homomorphic eval, maybe the typical commutative diagram. There might be one here to copy/paste: https://github.com/ethanlee515/Mending-Slides
* Maybe CNOT example? Maybe just assume knowledge of QEC, say "transversal" and assume audience know what that means...

## Our protocol overview

Current implementation: the full top-to-bottom flowchart appears immediately. One transition adds a QPIP1 box around the single-qubit inputs, MBQC, authenticated distillation, evaluation, and output, leaving remote state preparation outside.

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

Current implementation: keep the shaded overview flowchart on the left, highlight the MBQC output entering distillation, and point to it from the two challenge questions on the right. Recall the correlated all-bad-batch counterexample verbally; its explanation is in speaker notes.

Don't know what is good visual here either...

Maybe stay on the same slide, just arrow at the `ket{CCZ}` between MBQC and Distill?

Challenges:
* What does MBQC guarantee?
* What is distillable?

(Recall earlier, 1/poly all garbage = can be cheated)

Recall the background counterexample: per-copy error p = 1/poly can come from a single correlated branch of mass p in which the whole batch is maliciously bad. Need a joint few-bad-copies guarantee, except for negligible accepted weight, rather than only accurate individual marginals.

## MBQC Construction

Current implementation: "Measurement-Based Quantum Computation" keeps the verifier-to-prover preparation figure visible and reveals four bullets one at a time. "Plaintext MBQC" shows the paper's gate-teleportation circuit with outputs labelled m and X^m HT^c |psi>; explain its action and correction in words, with details in speaker notes.

Start with picture before, verifier sends `ket{+ theta}` to prover

(somehow connect here?)

Gate teleportation circuit from the paper's intro

Say we have this and CZ, it's universal.

## MBQC Trap copy?

Current implementation: two motivation bullets, revealed one at a time, followed by the plaintext trap circuit. The second bullet copies the paper's FK17 comparison. The example uses |+> and |0> with c=0 (gate H), and labels the honest outputs m=0 and |0>. Explain why the trap must be hidden before the encrypted version.

Gate teleportation again with different inputs

Remark this is different from Fitzsimons-Keshefi, we have separate copies. (There is good one-sentence wording in paper, forgot what was it.)

Say we have to encrypt everything

## MBQC OTP...

Current implementation: one "Need trap approx real => encrypt everything" bullet. First build wraps the plaintext real-copy circuit in OTP(...); the next replaces it with padded inputs, the masked HT^delta gate, the verifier's XOR-r outcome correction, and the encrypted output in standard X^{x'}T^{t'} form. Below the circuit, display delta and the final-pad formulas for x' and t', making their dependence on beta explicit. The formulas include the CZ key update; details are in speaker notes.

* Draw the encrypted version of real copy.
  * `X^x T^t` on input
  * `delta = ...`
  * `XOR r` on wire

## MBQC Analysis: Iterative Pauli twirling

Current implementation: five builds. Start with a Pauli OTP around an attack; a vertical "reduce" arrow leads to a single Pauli circuit, with the expansion and probability equations below it. Replace this with two wires and successive decryption rounds, expanding the first attack only on the outgoing qubit. The next build removes the first-wire pad pair and shows Q on that wire and B_Q on the still-encrypted second wire. Finally specialize to CNOT from wire 2 to wire 1, whose remaining coefficients are projectors. Omit wire-number labels and the outgoing measurement from this abstract picture. Explain one twirl per round and subnormalization verbally; details and the link to the MBQC pads are in speaker notes.

Idea: *Iterative* twirling. Once per round of communication.

Figure: two circuits with arrow between:
`OTP -> A -> OTP^dag` -> `Q`
Math: `A = sum Q`

Iterative: change first circuit to two wires, temporarily remove second circuit.
`OTP -> A1 -> OTP^dag -> A2 -> OTP^dag`

Challenge: `CNOT_21 = I otimes dyad{0} + X otimes dyad{1}`.
Treat subnormalization carefully.

## MBQC Analysis:

Current implementation: seven builds of the masked real-copy circuit with a joint attack A immediately before measurement. Start with pads in the input labels, then explicit pad gates before CZ. Commute them through CZ, then through HT^delta to expose HT^c and a consumed X-Z pad. Move the XOR-r decoder before measurement as the inverse Pauli pad. Twirl to X^aZ^b on the first wire and B_Q on the second, then label the final component B_Q X^{x'}T^{t'} X^a HT^c |psi>. Keep calculations and branch-weight conventions in speaker notes.

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

Current implementation: the final MBQC output colors B_Q and X^a red. The following "Factorizable Attacks" slide uses a centered Beamer definition box for A_ct OTP_k A_pt |psi>, with both attacks independent of the pad key. Two builds add the blindness point and an informal statistical comparison with an "up to isometry" guarantee, explicitly labelled by red A_ct. Speaker notes specialize OTP_k to X^x T^t and |psi> to |+>: with A_pt = I, the correct |+_theta> is followed by a key-independent outside operation, analogous to GV19's accepted-state representation. Individual components can decrease norm; the isometry interpretation concerns a dilation of the complete operation.

## Distillation Challenges

Don't know what is good figure here... hm.

Story:
* Existing MPQC uses distillation in a modular way
* Good authentication, possibly bad plaintext
* ^ Maybe same trapezoid thing, but TEnc(ket(CCZ)) in and out, and only the ket(CCZ) is red?
* In our setting, the entire TEnc is red.

Current implementation: three builds alongside the distillation funnel. First, MPQC [DGJ+20] uses modular distillation, with only the bad plaintext in red. Second, MBQC does not guarantee correct QAS: the entire rightmost TEnc turns red and the output becomes a question mark. Third, the adversary can cheat during distillation, and the process label turns red too. The joint input-quality promise and the distinction between plaintext and ciphertext faults stay in the speaker notes.

## Distillation construction

4-to-1 circuit (as in paper's intro), with all four inputs labelled `ket(0)`.

Current implementation: a static slide copies the paper's bare four-wire circuit: CNOTs 1-to-2 and 3-to-4, then 3-to-1, followed by Z/X/Z measurements on wires 2/3/4. Speaker notes explain acceptance of either X outcome; the deterministic Z outcomes must both be zero.

## Distillation observations

Same circuit, smaller and in the upper right. Bullet points appear one by one:

* Correctness: `ket(0)^4 -> ket(0)`.
* Soundness: one wrong input -> `ket(0)` or reject.
* Can be nested recursively: `ket{0^{4^L}} -> ket(0)`.
* Generalizes to EPR pairs.

Speaker notes: these are plaintext guarantees under honest execution. State the generalization without proof, referring to the paper. The recursive map on the slide is honest correctness; noisy-input analysis uses the joint bad-support promise and the fact that every bad parent needs at least two bad children.

## Distillation over the trap code

* Compatible with TEnc; replace the circuit's inputs and surviving output by `TEnc(ket(0))`.
* Each wire is a ciphertext block, marked by a bundle slash.
* Reject if (one check per build):
  * Any trap check fails.
  * Any QEC syndrome is nonzero.
  * Any decoded measurement outcome is unexpected.

Speaker notes: transversal CNOTs and Pauli measurements implement the logical circuit; the verifier updates keys, unmasks outcomes, and undoes the permutation before checking. Check only traps deterministic in the measured basis. The data decoder is a strict codeword check. For zero-state distillation, the Z outcomes on copies two and four must be zero; either X outcome on copy three is allowed. The circuit shows honest correctness, with no attack-closure claim on this slide.

## Distillation Analysis: Setting the stage

* Notation: `TEnc_{pi,x,z}(|psi>) = X^x Z^z pTEnc_pi(|psi>)`.
* `pTEnc_pi` includes the QEC encoding, traps, and permutation, before the Pauli pad.
* Work with one component having one plaintext-bad copy `i`, under a potentially global ciphertext attack:
  `A_ct X^x Z^z A_{pt,i} (pTEnc_pi(|0>))^{tensor 4}`.

Current implementation: two builds, introducing the encoding/pad notation first and then the one-bad-copy input component. Both attack operators are red. The output characterization is deferred until after the calculations.

Speaker notes: the pad strings concatenate the four blocks. Auxiliary registers, uniform reference keys, and mixture/Kraus labels are suppressed on the slide; preserve subnormalization and the joint invariant in the analysis. The outside operation is independent of the secret keys; the plaintext operator is pad-independent and may depend on the hidden permutation as in the paper.

## Distillation Analysis Intuitions

Current implementation: one circuit slide with seven builds. Active gates are laid out afresh with even spacing on each build, so no empty columns are reserved.

1. Inputs `pTEnc_pi(|0>)`, local `A_pt` on copy 3, then four-copy OTP and `A_ct`, the unfolded three-CNOT circuit, Z/X/Z measurements on copies 2/3/4, and classical `OTP^{-1}` outcome unmasking.
2. Move `A_ct` after the Clifford, before measurement, silently updating the attack.
3. Move OTP through the Clifford, with the updated keys implicit.
4. Move the measured-copy unmasking before measurement as `OTP^dagger`.
5. Partially twirl: replace the outside attack by `B_Q` on the survivor and three separate `Q_2`, `Q_3`, `Q_4` gates on the measured copies. Remove only the measured pads; keep `OTP_1` explicitly on the first wire, before `B_Q`.
6. Follow a Pauli term `X^x Z^z` of the plaintext attack on copy 3.
7. Propagate it through the Clifford: `X^x` on copies 1 and 4, `X^x Z^z` on copy 3, identity on copy 2.

Speaker notes distinguish the secret pad coordinates from the later plaintext-Pauli indices x,z. The twirled figure is one subnormalized Kraus component; B_Q retains its weight and private memory. The general plaintext attack is a coherent Pauli expansion, to be recombined after the accepted-output calculation.

## Distillation Analysis: The Reduction

Two builds of the comparison circuit:

1. Remove all attacks on the measured copies. On the first wire, show `Q_4`, then the live `OTP_1`, then `B_Q`.
2. Swap `Q_4` and `OTP_1`, using Pauli commutation up to phase. All remaining attacks are outside the pad.

Speaker notes: this is an accepted-output reduction, not an operator identity for arbitrary plaintext-Pauli terms. The paper's output representative for bad copy 3 is the X-type component of `Q_4`. The short label follows that convention; interpreting it as the full Pauli is also possible after absorbing its complementary component into the outside `B_Q`. Accepted-component linearity handles the coherent plaintext operator and retains its accepted mass.

## Distillation: One Bad Input

Centered informal lemma, on acceptance:

`1x factorizable attack + 3x ciphertext-level attack`
`mapsto ciphertext-level attack`.

The map uses a mapsto arrow, after the calculation and the explicit output-Pauli/pad swap. Speaker notes retain the joint invariant, potentially global outside attack, uniform live key, and subnormalization qualifications.

Interpretation below the lemma block: Plaintext-level attacks are distilled away.

Later: explain closure for several bad copies, `4x factorizable -> factorizable`.

## Protocol Overview (reprise)

Repeat the complete overview with the QPIP1 enclosure already visible, using the same flowchart as before. No stepwise reveal or extra slide text. Explain verbally that distillation gives the ciphertext-level attack form needed by authenticated evaluation, while the paper supplies the remaining QPIP1 details. Turn attention to the remote-preparation stage for the rest of the talk.

## QPIP0: RSP construction

* Presentation choice: keep QFHE inside the RSP implementation; no separate QFHE introduction for now. Retain the classical-client and subexponential-security assumptions in the notes and paper.
* Current implementation: restore the HN four-message diagram, adapted from the paper's `figures/compiled-test-messages.tex`. Its inclusion was removed by commit `017f09b` on November 2; the source was retained. First show the encrypted question/answer and private preparation description, then reveal the two clear test messages and check. Preparation ends after the first pair; testing uses all four messages.
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
