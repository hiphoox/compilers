defmodule ParserTest do
  use ExUnit.Case
  doctest Parser

  setup_all do
    {:ok,
    arbol: %AST{
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



}
  end
  test "token justos", state do
    assert Parser.parse_program([
  {:int_keyword, 0},
  {:main_keyword, 0},
  {:open_paren, 0},
  {:close_paren, 0},
  {:open_brace, 0},
  {:return_keyword, 0},
  {{:constant, 2}, 0},
  {:semicolon, 0},
  {:close_brace, 0}
]) == state[:arbol]
  end

  test "mas de un main token", state do
    assert Parser.parse_program([
      {:int_keyword, 0},
      {:main_keyword, 0},
      {:open_paren, 0},
      {:close_paren, 0},
      {:open_brace, 0},
      {:main_keyword, 0},
      {:return_keyword, 0},
      {{:constant, 2}, 0},
      {:semicolon, 0},
      {:close_brace, 0}
    ]) == state[:arbol]
  end
  test "menos tokens", state do
    assert Parser.parse_program([
      {:int_keyword, 0},
      {:main_keyword, 0},
      {:open_paren, 0},
      {:close_paren, 0}
    ]) == state[:arbol] 
  end



end
