.PHONY: test

ERL=erl
BEAMDIR=./deps/*/ebin ./ebin
REBAR=./rebar
REBAR_GEN=../../rebar
DIALYZER=dialyzer
EDOWN=./make_doc

all: update-deps get-deps clean compile xref edoc

dev: compile xref edoc

update-deps:
	@$(REBAR) update-deps

get-deps:
	@$(REBAR) get-deps

compile:
	@$(REBAR) compile

xref:
	@$(REBAR) xref skip_deps=true

clean:
	@$(REBAR) clean
	rm -rf  ./rel/marionet-device-001/marionet-device-001
	rm -rf  ./rel/marionet-device-002/marionet-device-002

test:
	@$(REBAR) skip_deps=true eunit

edoc:
	@$(EDOWN)

generate:
	cd rel/marionet-device-001 && $(REBAR_GEN) generate
	cd ../../
	cd rel/marionet-device-002 && $(REBAR_GEN) generate

generate-001:
	cd rel/marionet-device-001 && $(REBAR_GEN) generate

generate-002:
	cd rel/marionet-device-002 && $(REBAR_GEN) generate

generate-plc:
	cd rel/plc && $(REBAR_GEN) generate

dialyzer: compile
	@$(DIALYZER) ebin deps/serial/ebin

setup-dialyzer:
	@$(DIALYZER) --build_plt \
                 --apps kernel stdlib mnesia eunit erts crypto
