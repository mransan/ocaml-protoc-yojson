LIB_NAME=pbrt-yojson
OCAMLFIND_PKG_NAME=ocaml-protoc-yojson
LIB_FILES+=pbrt_yojson
LIB_DIR=src
LIB_DEPS=yojson

test:
	$(OCB) unit_tests.native
	./unit_tests.native

doc-gen:
	$(OCB) $(LIB_DIR)/$(LIB_NAME).docdir/index.html

## Generic library makefile ## 
include Makefile.opamlib

