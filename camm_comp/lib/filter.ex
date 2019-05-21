defmodule Filter do
  def filter_lexer(tokens) when tokens != [] do
    top = hd(tokens)
    rest = tl(tokens)

    if is_list(top) do
      top
    else
      filter_lexer(rest)
    end
  end

  def filter_lexer(_tokens) do
    []
  end
end
