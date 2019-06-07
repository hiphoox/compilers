defmodule Parser do

  @moduledoc """
  <program> ::= <function>
  <function> ::= "int" <id> "(" ")" "{" <statement> "}"
  <parse_statement> ::= "return" <exp> ";"
  <exp> ::= <int>
  """

  def parse_program(token_list) do
    function = parse_function(token_list)

    case function do
      {{:error, error_message}, _rest} ->
        {:error, error_message}


      {function_node, rest} ->
        if rest == [] do
          %AST{node_name: :program, left_node: function_node}
        else
          {:error, "Error: Hay más elementos de los permitidos 'end' ", 0}
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
              statement = parse_statement(rest)

              case statement do
                {{:error, error_message}, rest} ->
                  {{:error, error_message}, rest}

                {statement_node, [next_token | rest]} ->
                  if next_token == :c_llave do
                    {%AST{node_name: :function, value: :main, left_node: statement_node}, rest}
                  else
                    {{:error, "Error: se encontró '  ' y se esperaba  '}' "}, rest}
                  end
              end
            else
              {{:error, "Error: se encontró '#{next_token}' y se esperaba  '{' "},rest}
            end
          else
            {{:error, "Error: se encontró '#{next_token}' y se esperaba  ')' "},rest}
          end
        else
          {{:error, "Error: se encontró '#{next_token}' y se esperaba  '(' "},rest}
        end
      else
        {{:error, "Error: se encontró '#{next_token}' y se esperaba  'main' "},rest}
      end
    else
      {{:error, "Error: se encontró '#{next_token}' y se esperaba  'int' "},rest}
    end
  end

  def parse_statement([next_token | rest]) do
    if next_token == :return_keyword do
      expression = parse_expression(rest)

      case expression do
        {{:error, error_message}, rest} ->
          {{:error, error_message}, rest}

        {exp_node, [next_token | rest]} ->
          if next_token == :semicolon do
            {%AST{node_name: :return, left_node: exp_node}, rest}
          else
            {{:error, "Error: se encontró '#{next_token}' y se esperaba 'semicolon' "},
             rest}
          end
      end
    else
      {{:error, "Error: se encontró '#{next_token}' y se esperaba  'return' "}, rest}
    end
  end

  def parse_expression([next_token | rest]) do
    case next_token do
      {:constant, value} -> {%AST{node_name: :constant, value: value}, rest}

      :negacion -> 
        parse_unarios([next_token | rest])

      :complemento ->
        parse_unarios([next_token | rest])

      :logical_negation ->  
        parse_unarios([next_token | rest])

      _-> {{:error, "Error: se encontró '#{next_token}' y se esperaba una constante"},rest}
    end
  end
  
  def parse_unarios ([next_token | rest]) do
    case next_token do 

      :negacion -> 
        new_expression=parse_expression(rest)
        {node,rest2}=new_expression
        case new_expression do 
        {{:error, error_message}, rest} -> {{:error, error_message}, rest}
        _-> {%AST{node_name: :negation, left_node: node}, rest2}
        end   

      :complemento ->
        new_expression=parse_expression(rest)
        {node,rest2}=new_expression
        case new_expression do 
        {{:error, error_message}, rest} -> {{:error, error_message}, rest}
        _-> {%AST{node_name: :complement, left_node: node}, rest2}
        end

      :logical_negation ->
        new_expression=parse_expression(rest)
        {node,rest2}=new_expression
        case new_expression do 
        {{:error, error_message}, rest} -> {{:error, error_message}, rest}
        _-> {%AST{node_name: :logical, left_node: node}, rest2}
        end

      _ -> {{:error, "Error: operador unario no encontrado", next_token}, rest}

    end
  end

end
