defmodule ParserTest do
  use ExUnit.Case
  doctest Parser
  ### Documentacion}
  setup_all do
    {:ok,
     tokens: [
       :int_keyword,
       :main_keyword,
       :open_paren,
       :close_paren,
       :open_brace,
       :return_keyword,
       {:constant, 2},
       :semicolon,
       :close_brace
     ]}
  end

  ### Lista de Tokens con constante 0
  setup_all do
    {:ok,
     tokens_0: [
       :int_keyword,
       :main_keyword,
       :open_paren,
       :close_paren,
       :open_brace,
       :return_keyword,
       {:constant, 0},
       :semicolon,
       :close_brace
     ]}
  end

  ### Tokens sin parentesis
  setup_all do
    {:ok,
     tokens_SP: [
       :int_keyword,
       :main_keyword,
       :open_brace,
       :return_keyword,
       {:constant, 0},
       :semicolon,
       :close_brace
     ]}
  end

  ## Tokens sin argumentos
  setup_all do
    {:ok,
     tokens4: [
       :int_keyword,
       :int_keyword,
       :main_keyword,
       :open_paren,
       :open_brace,
       :return_keyword,
       :semicolon,
       :close_brace
     ]}
  end

  ## Tokens sin Llaves
  setup_all do
    {:ok,
     tokens_SL: [
       :int_keyword,
       :main_keyword,
       :open_paren,
       :close_paren,
       :return_keyword,
       {:constant, 2},
       :semicolon
     ]}
  end

  ## Tokens con doble int
  setup_all do
    {:ok,
     tokens_int: [
       :int_keyword,
       :int_keyword,
       :main_keyword,
       :open_paren,
       :close_paren,
       :open_brace,
       :return_keyword,
       {:constant, 2},
       :semicolon,
       :close_brace
     ]}
  end

  ## Tokens con doble main
  setup_all do
    {:ok,
     tokens_int: [
       :int_keyword,
       :main_keyword,
       :main_keyword,
       :open_paren,
       :close_paren,
       :open_brace,
       :return_keyword,
       {:constant, 2},
       :semicolon,
       :close_brace
     ]}
  end

  IO.puts("Pruebas para el parser (Pruebas invalidas)")
  IO.puts("7 Pruebas invalidas ")

  test "1.- Prueba", state do
    assert "int main() return 2;"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words()
           |> Parser.parseo() ==
             %AST{
               left_node: %AST{
                 left_node: %AST{
                   left_node: %AST{
                     left_node: nil,
                     node_name: :constant,
                     right_node: nil,
                     value: 2
                   },
                   node_name: :return,
                   right_node: nil,
                   value: nil
                 },
                 node_name: :function,
                 right_node: nil,
                 value: :main
               },
               node_name: :program,
               right_node: nil,
               value: nil
             }
  end

  test "2.- Prueba", state do
    assert "main() return 2;}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words()
           |> Parser.parseo() ==
             %AST{
               left_node: %AST{
                 left_node: %AST{
                   left_node: %AST{
                     left_node: nil,
                     node_name: :constant,
                     right_node: nil,
                     value: 2
                   },
                   node_name: :return,
                   right_node: nil,
                   value: nil
                 },
                 node_name: :function,
                 right_node: nil,
                 value: :main
               },
               node_name: :program,
               right_node: nil,
               value: nil
             }
  end

  test "3.- Prueba", state do
    assert "int () return 2;}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words()
           |> Parser.parseo() ==
             {:error, "Falta la palabra main"}
  end

  test "4.- Prueba", state do
    assert "int return 2;}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words()
           |> Parser.parseo() ==
             {:error, "Falta un parentesis"}
  end

  test "5.- Prueba", state do
    assert "int main return ;}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words()
           |> Parser.parseo() ==
             {:error, "Falta argumento en el return"}
  end

  test "6.- Prueba", state do
    assert "int main {return0;}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words()
           |> Parser.parseo() ==
             %AST{
               left_node: %AST{
                 left_node: %AST{
                   left_node: %AST{
                     left_node: nil,
                     node_name: :constant,
                     right_node: nil,
                     value: 2
                   },
                   node_name: :return,
                   right_node: nil,
                   value: nil
                 },
                 node_name: :function,
                 right_node: nil,
                 value: :main
               },
               node_name: :program,
               right_node: nil,
               value: nil
             }
  end

  test "7.- Prueba", state do
    assert "int main() {RETURN 0;}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words()
           |> Parser.parseo() ==
             %AST{
               left_node: %AST{
                 left_node: %AST{
                   left_node: %AST{
                     left_node: nil,
                     node_name: :constant,
                     right_node: nil,
                     value: 2
                   },
                   node_name: :return,
                   right_node: nil,
                   value: nil
                 },
                 node_name: :function,
                 right_node: nil,
                 value: :main
               },
               node_name: :program,
               right_node: nil,
               value: nil
             }
  end

  ######################################################################################
  IO.puts("Pruebas para el Parser (pruebas validas)")
  IO.puts("Pruebas Validas")

  test "8.- Prueba" do
    assert "int main(){return 2;}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words()
           |> Parser.parseo() ==
             %AST{
               left_node: %AST{
                 left_node: %AST{
                   left_node: %AST{
                     left_node: nil,
                     node_name: :constant,
                     right_node: nil,
                     value: 2
                   },
                   node_name: :return,
                   right_node: nil,
                   value: nil
                 },
                 node_name: :function,
                 right_node: nil,
                 value: :main
               },
               node_name: :program,
               right_node: nil,
               value: nil
             }
  end

  test "9.- Prueba Saltos de linea" do
    assert "int\nmain()\n{ return 2; }"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words()
           |> Parser.parseo() ==
             %AST{
               left_node: %AST{
                 left_node: %AST{
                   left_node: %AST{
                     left_node: nil,
                     node_name: :constant,
                     right_node: nil,
                     value: 2
                   },
                   node_name: :return,
                   right_node: nil,
                   value: nil
                 },
                 node_name: :function,
                 right_node: nil,
                 value: :main
               },
               node_name: :program,
               right_node: nil,
               value: nil
             }
  end

  test "10.- Prueba Saltos de linea en toda la funcion" do
    assert "int\nmain\n(\n)\n{\nreturn\n2\n;\n}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words()
           |> Parser.parseo() ==
             %AST{
               left_node: %AST{
                 left_node: %AST{
                   left_node: %AST{
                     left_node: nil,
                     node_name: :constant,
                     right_node: nil,
                     value: 2
                   },
                   node_name: :return,
                   right_node: nil,
                   value: nil
                 },
                 node_name: :function,
                 right_node: nil,
                 value: :main
               },
               node_name: :program,
               right_node: nil,
               value: nil
             }
  end

  test "11.- Prueba Todo separado" do
    assert "int main( ) { return 2; }"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words()
           |> Parser.parseo() ==
             %AST{
               left_node: %AST{
                 left_node: %AST{
                   left_node: %AST{
                     left_node: nil,
                     node_name: :constant,
                     right_node: nil,
                     value: 2
                   },
                   node_name: :return,
                   right_node: nil,
                   value: nil
                 },
                 node_name: :function,
                 right_node: nil,
                 value: :main
               },
               node_name: :program,
               right_node: nil,
               value: nil
             }
  end

  test "12.- Prueba" do
    assert "int\n main( )\n { return 2; }"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words()
           |> Parser.parseo() ==
             %AST{
               left_node: %AST{
                 left_node: %AST{
                   left_node: %AST{
                     left_node: nil,
                     node_name: :constant,
                     right_node: nil,
                     value: 2
                   },
                   node_name: :return,
                   right_node: nil,
                   value: nil
                 },
                 node_name: :function,
                 right_node: nil,
                 value: :main
               },
               node_name: :program,
               right_node: nil,
               value: nil
             }
  end

  test "13.- Prueba" do
    assert "int\n main( )\n {\n return 2;}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words()
           |> Parser.parseo() ==
             %AST{
               left_node: %AST{
                 left_node: %AST{
                   left_node: %AST{
                     left_node: nil,
                     node_name: :constant,
                     right_node: nil,
                     value: 2
                   },
                   node_name: :return,
                   right_node: nil,
                   value: nil
                 },
                 node_name: :function,
                 right_node: nil,
                 value: :main
               },
               node_name: :program,
               right_node: nil,
               value: nil
             }
  end
  test "14.- Prueba" do
    assert "int\n main( )\n {\n return\n 2;}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words()
           |> Parser.parseo() ==
             %AST{
               left_node: %AST{
                 left_node: %AST{
                   left_node: %AST{
                     left_node: nil,
                     node_name: :constant,
                     right_node: nil,
                     value: 2
                   },
                   node_name: :return,
                   right_node: nil,
                   value: nil
                 },
                 node_name: :function,
                 right_node: nil,
                 value: :main
               },
               node_name: :program,
               right_node: nil,
               value: nil
             }
  end
  test "15.- Prueba" do
    assert "int\n main( )\n {\n return\n 2;\n}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words()
           |> Parser.parseo() ==
             %AST{
               left_node: %AST{
                 left_node: %AST{
                   left_node: %AST{
                     left_node: nil,
                     node_name: :constant,
                     right_node: nil,
                     value: 2
                   },
                   node_name: :return,
                   right_node: nil,
                   value: nil
                 },
                 node_name: :function,
                 right_node: nil,
                 value: :main
               },
               node_name: :program,
               right_node: nil,
               value: nil
             }
  end
end
