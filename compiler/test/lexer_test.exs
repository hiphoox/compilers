defmodule LexerTest do
  use ExUnit.Case
  doctest Lexer

  setup_all do
    {:ok,
     tokens: [
  {:int_keyword, 0},
  {:main_keyword, 0},
  {:open_paren, 0},
  {:close_paren, 0},
  {:open_brace, 0},
  {:return_keyword, 0},
  {{:constant, 2}, 0},
  {:semicolon, 0},
  {:close_brace, 0}
],
tokens1: [
{:open_brace, 0},
{:return_keyword, 0},
{{:constant, 2}, 0},
{:semicolon, 0},
{:close_brace, 0}
],
tokens2: [
{:int_keyword, 0},
{:main_keyword, 0},
{:open_paren, 0},
{:close_paren, 0},
]

}
  end

  test "elements", state do
    assert Lexer.scan_words([{"int", 0}, {"main", 0}, {"()", 0}, {"{", 0}, {"return", 0}, {"2;}", 0}]) == state[:tokens]
  end
  test "elements separated just by spaces", state do
    assert Lexer.scan_words([
  {"int", 0},
  {"main", 0},
  {"(", 0},
  {")", 0},
  {"{", 0},
  {"return", 0},
  {"2;}", 0}
]
) == state[:tokens] or state[:tokens2]
  end
  test "y spaces", state do
    assert Lexer.scan_words([{"int", 0}, {"main(){return", 0}, {"2;}", 0}]) == state[:tokens]
  end

  test "me separated of function body", state do
    assert Lexer.scan_words([{"{return", 0}, {"2;}", 0}]) == state[:tokens1]
  end
  test "function name separated of function ", state do
    assert Lexer.scan_words([{"{", 0}, {"return", 0}, {"2", 0}, {";", 0}, {"}", 0}]) == state[:tokens1]
  end
  test "function name separated of  body", state do
    assert Lexer.scan_words([{"{return2;}", 0}]) == state[:tokens1]
  end

  test "function name separated  function body", state do
    assert Lexer.scan_words([{"int", 0}, {"main", 0}, {"(", 0}, {")", 0}]) == state[:tokens2]
  end
  test "function name  of function body", state do
    assert Lexer.scan_words([{"intmain()", 0}]) == state[:tokens2]
  end
  test "function  separated of function body", state do
    assert Lexer.scan_words([{"int", 0}, {"main()", 0}]) == state[:tokens2]
  end


end
