# CVQC-Talk

Slides for *Classical Verification of Quantum Sampling with Negligible Error*,
following the visual style of `reference-slides/` and the plan in `outline.md`.

## Build

Requires `make`, `latexmk`, and a TeX Live installation with pdfLaTeX, Beamer,
Metropolis, TikZ/PGF, `braket`, `booktabs`, `microtype`, and `tabularx`.

```sh
make        # build/cvqc-slides.pdf
make notes  # build/cvqc-slides-notes.pdf (notes on the right)
make watch  # rebuild when sources change; Ctrl-C to stop
make clean  # remove generated PDFs and auxiliary files
```

## Editing

- `cvqc-slides.tex`: title, authors, affiliations, occasion/date, and slide order.
- `preamble.tex`: shared theme, colors, packages, and callout commands.
- `slides/01-title.tex`: the title page; add later slides as separate files and
  include them from `cvqc-slides.tex`.
- Add speaker notes inside a frame with `\note{...}`. They are hidden in the
  normal deck and shown by `make notes`.

The paper and reference talk are submodules; the slide build does not modify or
compile either one.
