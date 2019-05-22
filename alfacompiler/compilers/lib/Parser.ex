defmodule Parser do

  @moduledoc """
  <program> ::= <function>
  <function> ::= "int" <id> "(" ")" "{" <statement> "}"
  <parse_statement> ::= "return" <exp> ";"
  <exp> ::= <int>
  """


  def parsing(token_list) do
    if token_list != [] do
      parse_program(token_list)
    else
      IO.puts("Error : Falta de Tokens")
    end
  end

  def parse_program(token_list) do
  function = parse_function(token_list)

  case function do
    {{:error, error_message}, _rest} ->
      {:error, error_message}


      {function_node, rest} ->
        if rest == [] do
          %AST{node_name: :program, left_node: function_node}
        else
          {:error, "Error: Hay más elementos de los permitidos 'end'",0}
        end
    end
  end

  def parse_function([next_token | rest]) do

    if next_token == :int_keyword do
      [next_token | rest] = rest

      if next_token == :main_keyword do
        [next_token | rest] = rest

        if next_token == :a_parentesis do
          [next_token | rest] = rest

          if next_token == :c_parentesis do
            [next_token | rest] = rest

            if next_token == :a_llave do
              statements = parse_statement(rest)

              case statements do
                {{:error, error_message}, rest} ->
                  {{:error, error_message}, rest}

                  {statement_node, [next_token | rest]} ->

                    if next_token == :c_llave do
                      {%AST{node_name: :function, value: :main, left_node: statement_node}, rest}
                    else
                      IO.puts("Falta llave de cierre")
                      {{:error, "Error: llave de apertura no encontrada"}, rest}
                    end
                end
            else
              IO.puts("Falta llave de apertura")
              {:error, "Error: llave de apertura no encontrada", rest}
            end
          else
            {:error, "Error: parentesis de cierre no encontrado"}
          end
        else
          {:error, "Error: parentesis de apertura no encontrado"}
        end
      else
        {:error, "Error: funcion main no encontrada"}
      end
    else
      {:error, "Error, tipo de retorno no definido"}
    end
  end


  def parse_statement([next_token | rest]) do
    if next_token == :return_keyword do
      expression = parse_expression(rest)

      case expression do
        {{:error, error_message}, rest} ->
          {{:error, error_message}, rest} ## manejo de errores


        {exp_node, [next_token | rest]} ->
          if next_token == :semicolon do
            {%AST{node_name: :return, left_node: exp_node}, rest} ##Estruc  AST del prof
          else #error
            {{:error, "Error:   ; no encontrado"}, rest}
          end
      end
    else
      {{:error, "Error: return no encontrado"}, rest}
    end
  end

  def parse_expression([next_token | rest]) do
    case next_token do

      {:constant, value} -> {%AST{node_name: :constant, value: value}, rest}

      :negacion ->
        parse_unarios([{next_token} | rest])

      :complemento ->
        parse_unarios([{next_token} | rest])

      :logical_negation ->
        parse_unarios([{next_token} | rest])

      _ -> {{:error, "Error: it was found ->#{next_token}<- when expecting  ->constant<- "}, rest}
    end
  end

  def parse_unarios([next_token | rest]) do
    case next_token do
      :negacion ->
      new_expresion = parse_expression (rest)
      {node, rest_complement } = new_expresion
      {%AST{node_name: :negation, left_node: node}, rest_complement}

      :complemento ->
        new_expresion=parse_expression(rest)
        {_,rest_complement}=new_expresion
        {%AST{node_name: :unary, left_node: new_expresion}, rest_complement}

        :logical_negation ->
          new_expresion=parse_expression(rest)
          {_,rest_complement}=new_expresion
          {%AST{node_name: :logic_n, left_node: new_expresion}, rest_complement}
      _ -> {{:error, "Error, arbol",next_token}, rest}
      end


end

end


