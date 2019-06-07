defmodule GeneratorTest do
  use ExUnit.Case
  doctest CodeGenerator

  setup_all do
    {:ok,
    codigo:      "    .globl\tmain\nmain:\n    movl\t$2, %eax\n    ret\n",
    codigo0:  "\n    .globl  main         ## -- Begin function main\nmain:                    ## @main\n    movl    $2, %eax\n    ret\n",
    codigo_unitary: "    .globl\tmain\nmain:\n    movl\t$4, %eax\ncmpl     $0, %eax\nmovl     $0, %eax\nsete     %al\n    not\t%eax\n    ret\n",
    codigo_unitary1: "    .globl\tmain\nmain:\n    movl\t$2, %eax\ncmpl     $0, %eax\nmovl     $0, %eax\nsete     %al\n    ret\n",
    codigo_unitary2: "    .globl\tmain\nmain:\n    movl\t$2, %eax\n    neg\t%eax\ncmpl     $0, %eax\nmovl     $0, %eax\nsete     %al\n    not\t%eax\n    neg\t%eax\n    ret\n",
    cod_binario1: "int  main(){return (5-4-7-7)-10;}"|> Sanitizer.sanitize_source()|> Lexer.scan_words()|> Parser.parse_program(),
    cod_binario2: "int  main(){return !-~(5-4-7-7);}"|> Sanitizer.sanitize_source()|> Lexer.scan_words()|> Parser.parse_program(),
    cod_binario3: "int  main(){return 5-4-7-7;}"|> Sanitizer.sanitize_source()|> Lexer.scan_words()|> Parser.parse_program(),
    cod_binario4: "int  main(){return (5-4)-(7-7);}"|> Sanitizer.sanitize_source()|> Lexer.scan_words()|> Parser.parse_program(),
    cod_binario5: "int  main(){return (5-4-(7-7));}"|> Sanitizer.sanitize_source()|> Lexer.scan_words()|> Parser.parse_program(),
    cod_binario11: "",
    cod_binario21: "",
    cod_binario31: "",
    cod_binario41: "",
    cod_binario51: ""
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

    test " con operaciones unitarias ", state do
       assert "int  main (){return ~!4;}"
              |> Sanitizer.sanitize_source()
              |> Lexer.scan_words()
              |> Parser.parse_program()
              |> CodeGenerator.generate_code() ==
              state[:codigo_unitary]
    end
    test "con negacion logica", state do
       assert "int  main (){return !2;}"
              |> Sanitizer.sanitize_source()
              |> Lexer.scan_words()
              |> Parser.parse_program()
              |> CodeGenerator.generate_code() ==
                state[:codigo_unitary1]
    end
    test "con varios operadores unitarios", state do
       assert "int  main (){return -~!-2;}"
       |> Sanitizer.sanitize_source()
       |> Lexer.scan_words()
       |> Parser.parse_program()
       |> CodeGenerator.generate_code() ==
       state[:codigo_unitary2]
     end
     #operadores binarios-------------------------------------------------------
     test "con varios operadores binarios", state do
        assert "int  main(){return (5-4-7-7)-10;}"
        |> Sanitizer.sanitize_source()
        |> Lexer.scan_words()
        |> Parser.parse_program() ==
        state[:cod_binario1]
      end
      test "con varios operadores binarios y varios unitarios", state do
         assert "int  main(){return !-~(5-4-7-7);}"
         |> Sanitizer.sanitize_source()
         |> Lexer.scan_words()
         |> Parser.parse_program() ==
         state[:cod_binario2]
       end
       test "con varios operadores binarios sin parentesis", state do
          assert "int  main(){return 5-4-7-7;}"
          |> Sanitizer.sanitize_source()
          |> Lexer.scan_words()
          |> Parser.parse_program() ==
          state[:cod_binario3]
        end
        test "con varios operadores binarios con mas de 1 parentesis", state do
           assert "int  main(){return (5-4)-(7-7);}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words()
           |> Parser.parse_program() ==
           state[:cod_binario4]
         end
         test "con varios operadores binarios con parentesis anidados", state do
            assert "int  main(){return (5-4-(7-7));}"
            |> Sanitizer.sanitize_source()
            |> Lexer.scan_words()
            |> Parser.parse_program() ==
            state[:cod_binario5]
          end
          #operadores binarios MAL-------------------------------------------------------
          test "con varios operadores binarios MAL", state do
             assert "int  main(){return (5-4-7-7)-10;}"
             |> Sanitizer.sanitize_source()
             |> Lexer.scan_words()
             |> Parser.parse_program() ==
             state[:cod_binario11]
           end
           test "con varios operadores binarios y varios unitarios MAL", state do
              assert "int  main(){return !-~(5-4-7-7);}"
              |> Sanitizer.sanitize_source()
              |> Lexer.scan_words()
              |> Parser.parse_program() ==
              state[:cod_binario21]
            end
            test "con varios operadores binarios sin parentesis MAL", state do
               assert "int  main(){return 5-4-7-7;}"
               |> Sanitizer.sanitize_source()
               |> Lexer.scan_words()
               |> Parser.parse_program() ==
               state[:cod_binario31]
             end
             test "con varios operadores binarios con mas de 1 parentesis MAL", state do
                assert "int  main(){return (5-4)-(7-7);}"
                |> Sanitizer.sanitize_source()
                |> Lexer.scan_words()
                |> Parser.parse_program() ==
                state[:cod_binario41]
              end
              test "con varios operadores binarios con parentesis anidados MAL", state do
                 assert "int  main(){return (5-4-(7-7));}"
                 |> Sanitizer.sanitize_source()
                 |> Lexer.scan_words()
                 |> Parser.parse_program() ==
                 state[:cod_binario51]
               end
end
