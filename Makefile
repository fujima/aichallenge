
TARGET = mybot

.PHONY: all clean test

all: nativecode
	./play_one_game.sh "./$(TARGET).native" > /dev/null &
	tail -f _build/mybot_err.log &

bytecode: ants.ml $(TARGET).ml 
	ocamlbuild $(TARGET).byte

nativecode: ants.ml $(TARGET).ml
	ocamlbuild $(TARGET).native

test: bytecode
	cd tools; ./test_bot.sh

clean:
	ocamlbuild -clean