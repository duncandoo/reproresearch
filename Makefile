# modified slightly from http://robjhyndman.com/hyndsight/makefiles/
# Usually, only these lines need changing
TEXFILE= paper
TEXDIR= ./tex
RDIR= .
FIGDIR= ./figures
KEYRFILES= load clean functions

#CONVENTIONS:
# load.R - loads the data from disk
# clean.R - cleans data, transforms, etc.
# functions.R - custom functions relied on by analysis
# main.R - will not be run.

# list R files, then exclude "main.R"
RFILES := $(wildcard $(RDIR)/*.R)
RFILES := $(filter-out $(RDIR)/main.R, $(RFILES))

# pdf figures created by R
PDFFIGS := $(wildcard $(FIGDIR)/*.pdf)

# Indicator files to show R file has run
OUT_FILES:= $(RFILES:.R=.Rout)

# Indicator files to show pdfcrop has run
CROP_FILES:= $(PDFFIGS:.pdf=.pdfcrop)

all: $(TEXDIR)/$(TEXFILE).pdf

# Compile main tex file
$(TEXDIR)/$(TEXFILE).pdf: $(TEXDIR)/$(TEXFILE).tex $(OUT_FILES) $(CROP_FILES)
#	latexmk -pdf -quiet $(TEXDIR)/$(TEXFILE)
	cd $(TEXDIR); latexmk -pdf -quiet $(TEXFILE)
#	rubber --pdf $(TEXFILE)
#	rubber-info $(TEXFILE)

# R file dependencies are listed here.
# The order goes load.R > clean.R > functions.R > the rest of the .R files

$(RDIR)/clean.Rout: $(RDIR)/load.Rout 

$(RDIR)/functions.Rout: $(RDIR)/clean.Rout 

$(filter-out $(RDIR)/$(KEYRFILES).Rout, $(RDIR)/$(OUTFILES)): $(RDIR)/$(KEYRFILES).Rout 

# RUN EVERY R FILE dependent on functions.R
$(RDIR)/%.Rout: $(RDIR)/%.R
	R CMD BATCH $< 

# CROP EVERY PDF FIG FILE
$(FIGDIR)/%.pdfcrop: $(FIGDIR)/%.pdf
	pdfcrop $< $< && touch $@

# View the resulting PDF file
view: $(TEXDIR)/$(TEXFILE).pdf
	"c:\Program Files\RStudio\bin\sumatra\sumatrapdf" $(TEXFILE).pdf &
#	evince $(TEXFILE).pdf &

.DELETE_ON_ERROR:
.PHONY: all clean

# Clean up stray files
clean:
	rm -fv $(OUT_FILES) 
	rm -fv $(CROP_FILES)
	rm -fv *.aux *.log *.toc *.blg *.bbl *.synctex.gz *.out *.bcf *blx.bib *.run.xml
	rm -fv *.fdb_latexmk *.fls
	rm -fv $(TEXFILE).pdf


