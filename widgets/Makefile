.PHONY: all
all: button.lua init.lua

%.lua: %.moon
	moonc $<

.PHONY: check
check:
	moonc -l *.moon
	moonpick *.moon

.PHONY: clean
clean:
	rm -f *.lua
