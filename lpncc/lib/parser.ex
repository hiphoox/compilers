defmodule Parser do
  @moduledoc """
  <program> ::= <function>
  <function> ::= "int" <id> "(" ")" "{" <statement> "}"
  <statement> ::= "return" <exp> ";"
  <exp> ::= <int>
  """

  def parseo(tokens) do
    if tokens != [] do
      program(tokens)
    else
      IO.puts("Error : Falta de Tokens")
    end
  end

  def program(tokens) do
    function = funcion(tokens)

    case function do
      {function_node, tokens} ->
        if tokens == [] do
          %AST{node_name: :program, left_node: function_node}
        else
          IO.puts("Error: Hay mas elementos al finalizar la funcion.")
        end
    end
  end

  def funcion([elemento | tokens]) do
    if elemento == :int_keyword do
      [elemento | tokens] = tokens

      if elemento == :main_keyword do
        [elemento | tokens] = tokens

        if elemento == :open_paren do
          [elemento | tokens] = tokens

          if elemento == :close_paren do
            [elemento | tokens] = tokens

            if elemento == :open_brace do
              statements = statement(tokens)

              case statements do
                {{:error, error_message}, tokens} ->
                  {{:error, error_message}, tokens}

                {statement_node, [elemento | tokens]} ->
                  if elemento == :close_brace do
                    {%AST{node_name: :function, value: :main, left_node: statement_node}, tokens}
                  else
                    IO.puts("Error, falta '{'")
                  end
              end
            else
              IO.puts("Error, falta '}'")
            end
          else
            IO.puts("Error, falta ')'")
          end
        else
          IO.puts("Error, falta '('")
        end
      else
        IO.puts("Error, no hay main.")
      end
    else
      IO.puts("Error, error de sintaxis 'return not found'")
    end
end

  def statement([elemento | tokens]) do
    if elemento == :return_keyword do
      exp = expresion(tokens)
      case exp do
        {exp_node, [elemento | tokens]} ->
          if elemento == :puntoycoma do
            {%AST{node_name: :return, left_node: exp_node}, tokens}
          end
      end
    end
  end

  def parse_expression([{elemento, line} | rest]) do
    case elemento do
      {:constant, value} -> {%AST{node_name: :constant, value: value}, rest}

      :operator_negation -> 
        parse_unary_op([{elemento, line} | rest])

      :operator_bitwise_complement ->
        parse_unary_op([{elemento, line} | rest])

      :operator_logical_negation ->  
        parse_unary_op([{elemento, line} | rest])

      _ -> {{:error, "Error: it was found ->#{elemento}<- when expecting  ->constant<- ",line}, rest}
    end
  end
  
  def parse_unary_op ([{elemento, line} | rest]) do
    case elemento do 

      :operator_negation -> 
        parse_unary=parse_expression(rest)
        {nodo,rest2}=parse_unary
        {%AST{node_name: :negation, left_node: nodo}, rest2}

      :operator_bitwise_complement ->
        parse_unary=parse_expression(rest)
        {nodo,rest2}=parse_unary
        {%AST{node_name: :complement, left_node: nodo}, rest2}

      :operator_logical_negation ->
        parse_unary=parse_expression(rest)
        {nodo,rest2}=parse_unary
        {%AST{node_name: :logical, left_node: nodo}, rest2}

      _ -> {{:error, "Error: not found unary op",line,elemento}, rest}
    end
  end