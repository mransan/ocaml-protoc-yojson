LIB_NAME=pbrt-yojson
OCAMLFIND_PKG_NAME=ocaml-protoc-yojson
LIB_FILES+=pbrt_yojson
LIB_DIR=src
LIB_DEPS=ocaml-protoc,yojson

gen:
	ocaml-protoc -json -ml_out tests tests/message.proto

test: gen 
	$(OCB) unit_tests.native
	export OCAMLRUNPARAM="b" && ./unit_tests.native 
	$(OCB) message_test.native
	export OCAMLRUNPARAM="b" && ./message_test.native 

doc-gen:
	$(OCB) $(LIB_DIR)/$(LIB_NAME).docdir/index.html

## Generic library makefile ## 
include Makefile.opamlib

