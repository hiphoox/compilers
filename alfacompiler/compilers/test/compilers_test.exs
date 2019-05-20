defmodule CompilersTest do
  use ExUnit.Case
  doctest Compilers

  setup_all do
    {:ok,
     tokens: [
       :int_keyword,
       :main_keyword,
       :a_parentesis,
       :c_parentesis,
       :a_llave,
       :return_keyword,
       {:constant, 2},
       :semicolon,
       :c_llave
     ]}
  end

  test "elements separated just by spaces", state do
    assert Lexer.scan_words(["int", "main(){return", "2;}"]) == state[:tokens]
  end

  test "function name separated of function body", state do
    assert Lexer.scan_words(["int", "main()", "{return", "2;}"]) == state[:tokens]
  end

  test "everything is separated", state do
    assert Lexer.scan_words(["int", "main", "(", ")", "{", "return", "2", ";", "}"]) ==
             state[:tokens]
  end

  test "main and body separated", state do 
     assert Lexer.scan_words(["int", "main", "(", ")", "{return2;}"]) == state[:tokens]
  end


  test "todo junto", state do
    assert Lexer.scan_words(["intmain(){return2;}"]) == state[:tokens]
  end
  
  test "Nora_spaces", state do
    assert Compilers.parser_test(["test/Nora/valid/spaces.c"]) == state[:tokens]
    IO.puts("Spaces.c OK!!!!\n")
  end

  test "Nora_multidigit", state do
    assert Compilers.parser_test(["test/Nora/valid/multi_digit.c"]) == state[:tokens]
    IO.puts("multi_digit.c OK!!!!\n")
  end

  test "Nora_newlines", state do
    assert Compilers.parser_test(["test/Nora/valid/newlines.c"]) == state[:tokens]
    IO.puts("newlines.c OK!!!!\n")
  end

  test "Nora_no_newlines", state do
    assert Compilers.parser_test(["test/Nora/valid/no_newlines.c"]) == state[:tokens]
    IO.puts("no_newlines.c OK!!!!\n")
  end

  test "Nora_return_2", state do
    assert Compilers.parser_test(["test/Nora/valid/return_2.c"]) == state[:tokens]
    IO.puts("return_2.c OK!!!!\n")
  end

  test "Nora_missing_paren", state do
    assert Compilers.parser_test(["test/Nora/invalid/missing_paren.c"]) == state[:tokens]
  end

  test "Nora_missing_retval", state do
    assert Compilers.parser_test(["test/Nora/invalid/missing_retval.c"]) == state[:tokens]
  end

  test "Nora_no_brace", state do
    assert Compilers.parser_test(["test/Nora/invalid/no_brace.c"]) == state[:tokens]
  end

  test "Nora_no_semicolon", state do
    assert Compilers.parser_test(["test/Nora/invalid/no_semicolon.c"]) == state[:tokens]
  end

  test "Nora_no_space", state do
    assert Compilers.parser_test(["test/Nora/invalid/no_space.c"]) == state[:tokens]
  end

  test "Nora_wrong_case", state do
    assert Compilers.parser_test(["test/Nora/invalid/wrong_case.c"]) == state[:tokens]
  end


end
