defmodule GeneratorTest do
  use ExUnit.Case
  doctest CodeGenerator

  setup_all do
    {:ok,
    codigo:  "\n    .globl  main         ## -- Begin function main\nmain:                    ## @main\n    movl    $2, %eax\n    ret\n",
    codigo0:  "\n    .globl  main         ## -- Begin function main\nmain:                    ## @main\n    movl    $2, %eax\n    ret\n"

}
  end
  test "arbol correcto", state do
    assert CodeGenerator.generate_code(%AST{
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
}) == state[:codigo]
  end

    #---------------------------------------------------------------------------------
    test " Separdos", state do
        assert Lexer.scan_words([{"int",0}, {"main(){return",0}, {"2;}",0}])
        |> Parser.parse_program()
        |> CodeGenerator.generate_code() ==
        state[:codigo] or state[:codigo0]
    end

    test " función  separada ", state do
        assert Lexer.scan_words([{"int",0}, {"main()",0}, {"{return",0}, {"2;}",0}])
        |> Parser.parse_program()
        |> CodeGenerator.generate_code() ==
        state[:codigo] or state[:codigo0]
    end

    test " Todo separado", state do
        assert Lexer.scan_words([{"int",0}, {"main",0}, {"(",0}, {")",0}, {"{",0}, {"return",0}, {"2",0}, {";",0}, {"}",0}])
        |> Parser.parse_program()
        |> CodeGenerator.generate_code() ==
        state[:codigo] or state[:codigo0]
    end

    test " Return 0", state do
      assert Lexer.scan_words([{"int",0}, {"main",0}, {"(",0}, {")",0}, {"{",0}, {"return",0}, {"0",0}, {";",0}, {"}",0}])
      |> Parser.parse_program()
      |> CodeGenerator.generate_code() ==
      state[:codigo] or state[:codigo0]
    end

    test " Saltos de linea en int y main", state do
       assert "int\nmain\n()\n{return 0;}" |> Sanitizer.sanitize_source() |> Lexer.scan_words()
       |> Parser.parse_program()|> CodeGenerator.generate_code() ==
       state[:codigo] or state[:codigo0]
    end

    test " Saltos de linea en todo", state do
       assert "int\nmain\n(\n)\n{\nreturn\n0\n;\n}\n"
              |> Sanitizer.sanitize_source()
              |> Lexer.scan_words()
              |> Parser.parse_program()
              |> CodeGenerator.generate_code() ==
              state[:codigo] or state[:codigo0]
    end

    test " Espacios entre caracteres", state do
       assert "int    main    (   )   {   return    0   ;   }   "
              |> Sanitizer.sanitize_source()
              |> Lexer.scan_words()
              |> Parser.parse_program()
              |> CodeGenerator.generate_code() ==
              state[:codigo] or state[:codigo0]
    end




end
