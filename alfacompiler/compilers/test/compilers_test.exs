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
    assert Lexer.scan_words(["intmain(){return2;}"]) ==
             state[:tokens]
  end
  
  test "Nora_spaces", state do
    assert Compilers.call_nora_test([File.read!("test/Nora/valid/spaces.c")]) == state[:tokens]
    IO.puts("Spaces.c OK!!!!\n")
  end

  test "Nora_multidigit" do
    assert Compilers.call_nora_test([File.read!("test/Nora/valid/multi_digit.c")]) == :ok
    IO.puts("multi_digit.c OK!!!!\n")
  end

  test "Nora_newlines" do
    assert Compilers.call_nora_test([File.read!("test/Nora/valid/newlines.c")]) == :ok
    IO.puts("newlines.c OK!!!!\n")
  end

  test "Nora_no_newlines" do
    assert Compilers.call_nora_test([File.read!("test/Nora/valid/no_newlines.c")]) == :ok
    IO.puts("no_newlines.c OK!!!!\n")
  end

  test "Nora_newlines" do
    assert Compilers.call_nora_test([File.read!("test/Nora/valid/newlines.c")]) == :ok
    IO.puts("newlines.c OK!!!!\n")
  end

  test "Nora_return_2" do
    assert Compilers.call_nora_test([File.read!("test/Nora/valid/return_2.c")]) == :ok
    IO.puts("return_2.c OK!!!!\n")
  end

  


  test "Nora_missing_paren" do
    assert Compilers.call_nora_test([File.read!("test/Nora/invalid/missing_paren.c")]) == :ok
    IO.puts("missing_paren.c OK!!!!\n")
  end

  test "Nora_missing_retval" do
    assert Compilers.call_nora_test([File.read!("test/Nora/invalid/missing_retval.c")]) == :ok
    IO.puts("missing_retval.c OK!!!!\n")
  end

  test "Nora_no_brace" do
    assert Compilers.call_nora_test([File.read!("test/Nora/invalid/no_brace.c")]) == :ok
    IO.puts("no_brace.c OK!!!!\n")
  end

  test "Nora_no_semicolon" do
    assert Compilers.call_nora_test([File.read!("test/Nora/invalid/no_semicolon.c")]) == :ok
    IO.puts("no_semicolon.c OK!!!!\n")
  end

  test "Nora_no_space" do
    assert Compilers.call_nora_test([File.read!("test/Nora/invalid/no_space.c")]) == :ok
    IO.puts("no_space.c OK!!!!\n")
  end

  test "Nora_wrong_case" do
    assert Compilers.call_nora_test([File.read!("test/Nora/invalid/wrong_case.c")]) == :ok
    IO.puts("wrong_case.c OK!!!!\n")
  end


end
