install:
	dune build @install

all:
	dune build @all

test:
	dune runtest

clean:
	dune clean
