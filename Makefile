.PHONY: test fmt

# The suite runs in a bare headless nvim: no config, no framework. The sibling
# lvim-* checkouts beside this one are picked up when they exist (or from
# $LVIM_PLUGINS_DIR); specs that need one they cannot find skip.
#
# The XDG homes are redirected into a throwaway directory FIRST, so a spec that
# opens a store, writes a cache or persists state cannot reach the real editor's
# data. tests/run.lua refuses to run if that redirection is missing.
test:
	@LVIM_TEST_HOME="$$(mktemp -d)" ; \
	XDG_DATA_HOME="$$LVIM_TEST_HOME/data" \
	XDG_STATE_HOME="$$LVIM_TEST_HOME/state" \
	XDG_CACHE_HOME="$$LVIM_TEST_HOME/cache" \
	XDG_CONFIG_HOME="$$LVIM_TEST_HOME/config" \
	LVIM_TEST_HOME="$$LVIM_TEST_HOME" \
	nvim --headless -u NONE -l tests/run.lua ; \
	status=$$? ; rm -rf "$$LVIM_TEST_HOME" ; exit $$status

fmt:
	stylua lua tests
