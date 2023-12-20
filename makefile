.PHONY: %

%: src/%.exs
	@elixir src/$@.exs
