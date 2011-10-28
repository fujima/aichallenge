

.PHONY: all clean

all: bytecode
	cd tools; ./play_one_game.sh > /dev/null &

bytecode: ants.ml MyBot.ml ants.ml
	ocamlbuild -lib unix MyBot.byte

clean:
	ocamlbuild -clean