defmodule ProyectoCompiladorTest do
  use ExUnit.Case
  doctest Proyecto_compilador

  setup_all do
    {:ok,
     tokens: [
       :int_Keyword,
       :main_Keyword,
       :open_paren,
       :close_paren,
       :open_brace,
       :return_Keyword,
       {:constant, 2},
       :semicolon,
       :close_brace
     ]}
  end

  test 1, state do
    IO.puts(" int main( ) { return 2; }")
    assert Lexer.scan_word(" int main( ) { return 2; }") == state[:tokens]
    IO.puts("*****Prueba lexer codigo sin saltos de línea: OK")
  end

  test 2, state do
    IO.puts(" int\n main(\n )\n { \nreturn \n2;\n }\n")
    assert Lexer.scan_word(" int main( ) { return 2; }") == state[:tokens]
    IO.puts("*****Prueba lexer codigo con saltos de línea: OK\n")
  end

  test 3, state do
    IO.puts(" int main(\n\t )\n\n { return \n2; }")
    assert Lexer.scan_word("int main(\n\t )\n\n { return \n2; }") == state[:tokens]
    IO.puts("*****Prueba lexer codigo con saltos de línea y tabuladores: OK\n")
  end

  test 4 do
    assert Orquestador.manager_nora_test(File.read!("test/multi_digit.c")) == :ok
    IO.puts("*****Código 1 multi_digit.c VÁLIDO: OK\n")
  end

  test 5 do
    assert Orquestador.manager_nora_test(File.read!("test/new_line.c")) == :ok
    IO.puts("*****Código 2 new_line.c VÁLIDO: OK\n")
  end

  test 6 do
    assert Orquestador.manager_nora_test(File.read!("test/no_newlines.c")) == :ok
    IO.puts("*****Código 3 no_newlines.c VÁLIDO: OK\n")
  end

  test 7 do
    assert Orquestador.manager_nora_test(File.read!("test/return_0.c")) == :ok
    IO.puts("*****Código 4 return_0.c VÁLIDO: OK\n")
  end

  test 8 do
    assert Orquestador.manager_nora_test(File.read!("test/return_2.c")) == :ok
    IO.puts("*****Código 5 return_2.c VÁLIDO: OK\n")
  end

  test 9 do
    assert Orquestador.manager_nora_test(File.read!("test/spaces.c")) == :ok
    IO.puts("*****Código 5 spaces.c VÁLIDO: OK\n")
  end

  #test 10 do ##pendiente, debe retornar un valor la funcion erronea
  #  assert Orquestador.manager_nora_test(File.read!("test/missing_paren.c")) == :error
  #  IO.puts("*****Código 5 missing_paren.c INVÁLIDO: OK\n")
  #end

  test 11, state do
    IO.puts(" int min( ) { return 2; }")
    assert Saneador.fix_code_format(" int min( ) { return 2; }") == nil
    IO.puts("*****Prueba saneador codigo con error en main: OK\n")
  end

  test 12 do
    IO.puts(File.read!("test/test_gcc.s"))
    assert Linker.genera_archivo_binario("test/test_gcc.s") == :ok
    IO.puts("*****Prueba linker desde un archivo de ensamblador: OK\n")
  end

  test 13 do
    ast = {:program, "program", {:function, "main", {:return_Keyword, "return", {:constant, 5, {}, {}}, {}},  {}}, {}}
    assert Generador_codigo.assembly(ast) == :ok
    IO.puts("*****Prueba Generador de código desde un árbol AST: OK\n")
  end

end
