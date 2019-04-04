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
                    {{:error, "Error, falta '{'"}, tokens}
                  end
              end
            else
              {:error, "Error, falta '}'"}
            end
          else
            {:error, "Error, falta ')'"}
          end
        else
          {:error, "Error, falta '('"}
        end
      else
        {:error, "Error, no hay main."}
      end
    else
      {:error, "Error, error de sintaxis (return 404)"}
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

  def expresion([elemento | tokens]) do
    case elemento do
      {:constant, valor} -> {%AST{node_name: :constant, value: valor}, tokens}
      _ -> IO.puts("Error: Constante no encontrada")
    end
  end
end
