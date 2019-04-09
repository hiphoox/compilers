defmodule GeneratorTest do
  use ExUnit.Case
  doctest CodeGenerator

  setup_all do
    {:ok,
    codigo:  "\n    .globl  main         ## -- Begin function main\nmain:                    ## @main\n    movl    $2, %eax\n    ret\n"

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

  test "ERROR de arbol1", state do
      assert CodeGenerator.generate_code({:error, "Error: return keyword missed in line", 2}) == state[:codigo]
    end
    test "ERROR de arbol2", state do
      assert CodeGenerator.generate_code({:error, "Error: there are more elements after function end", 2}) == state[:codigo]
    end
    test "ERROR de arbol3", state do
      assert CodeGenerator.generate_code({:error, "Error: open brace missed in line", 2}) == state[:codigo]
    end
    test "ERROR de arbol4", state do
      assert CodeGenerator.generate_code({:error, "EError: close parentesis missed in line", 2}) == state[:codigo]
    end



end
