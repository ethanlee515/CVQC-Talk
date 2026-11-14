DECK := cvqc-slides
NOTES := $(DECK)-notes
BUILD_DIR := build
LATEXMK := latexmk
LATEXMK_FLAGS := -pdf -interaction=nonstopmode -halt-on-error -file-line-error -outdir=$(BUILD_DIR)
SOURCES := $(DECK).tex preamble.tex $(wildcard slides/*.tex)
ASSETS := $(wildcard assets/* assets/*/*)

.DEFAULT_GOAL := all

.PHONY: all notes watch clean

all: $(BUILD_DIR)/$(DECK).pdf

notes: $(BUILD_DIR)/$(NOTES).pdf

$(BUILD_DIR)/$(DECK).pdf: $(SOURCES) $(ASSETS) Makefile | $(BUILD_DIR)
	$(LATEXMK) $(LATEXMK_FLAGS) $(DECK).tex

$(BUILD_DIR)/$(NOTES).pdf: $(NOTES).tex $(SOURCES) $(ASSETS) Makefile | $(BUILD_DIR)
	$(LATEXMK) $(LATEXMK_FLAGS) $(NOTES).tex

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

watch: | $(BUILD_DIR)
	$(LATEXMK) $(LATEXMK_FLAGS) -pvc $(DECK).tex

clean:
	$(LATEXMK) -C -outdir=$(BUILD_DIR) $(DECK).tex
	$(LATEXMK) -C -outdir=$(BUILD_DIR) $(NOTES).tex
