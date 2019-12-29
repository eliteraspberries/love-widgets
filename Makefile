.PHONY: widgets
widgets:
	$(MAKE) -C widgets

.PHONY: check-widgets
check-widgets: widgets
	$(MAKE) -C widgets check

.PHONY: clean-widgets
clean-widgets:
	$(MAKE) -C widgets clean

.PHONY: love
love: widgets widgets.love

.PHONY: clean-love
clean-love:
	rm -f widgets.love

%.lua: %.moon
	moonc $<

.PHONY: widgets.love
widgets.love: main.lua
	zip widgets.zip main.lua widgets/*.lua
	cp widgets.zip widgets.love

.PHONY: check
check: check-widgets main.moon main.lua
	moonc -l *.moon
	moonpick *.moon
	luacheck main.lua

.PHONY: test
test: love
	love widgets.love

.PHONY: cleanup
cleanup:
	rm -f widgets.zip

.PHONY: clean
clean: cleanup clean-widgets clean-love
	rm -f *.lua
