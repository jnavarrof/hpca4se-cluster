maindoc := hpca4se-cluster
markdown := $(wildcard *.part.md)

all: $(maindoc).docx

$(maindoc).pdf:
	pandoc -s -o $(maindoc).pdf index.md $(markdown)

$(maindoc).docx:
	pandoc -s -o $(maindoc).docx index.md $(markdown)

clean:
	rm -f $(maindoc).docx $(maindoc).pdf

