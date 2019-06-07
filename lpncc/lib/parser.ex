defmodule Parser do
  @moduledoc """
    <program> ::= <function>
    <function> ::= "int" <id> "(" ")" "{" <statement> "}"
    <statement> ::= "return" <exp> ";"
    <exp> ::= <term> { ("+" | "-") <term> }
    <term> ::= <factor> { ("*" | "/") <factor> }
    <factor> ::= "(" <exp> ")" | <unary_op> <factor> | <int>
    """
  def parse_program(token_list) do
    function = parse_function(token_list,0)
    case function do
      {{:error,error_message,linea,problema}, _rest} ->
        {:error, error_message, linea,problema}

      {function_node, rest} ->
        if rest == [] do
          %AST{node_name: :program, left_node: function_node}
        else
          {:error, "Error: hay mas elementos al final de la funcion",0,"mas elementos"}
        end
    end
  end

  def parse_function([{next_token,numline} | rest],contador) do
    if rest != [] do
      case contador do
        0->
          if next_token == :int_keyword do
            contador=contador+1
            parse_function(rest,contador)
          else
            {{:error, "Error #1",numline,next_token},rest}
          end
        1->
          if next_token == :main_keyword do
            contador=contador+1
            parse_function(rest,contador)
          else
            {{:error, "Error, #2",numline,next_token},rest}
          end
        2->
          if next_token == :open_paren do
            contador=contador+1
            parse_function(rest,contador)
          else
            {{:error, "Error, #3",numline,next_token},rest}
          end
        3->
          if next_token == :close_paren do
            contador=contador+1
            parse_function(rest,contador)
          else
            {{:error, "Error, #4",numline,next_token},rest}
          end
        4->
          if next_token == :open_brace do
            statement = parse_statement(rest)
            case statement do
              {{:error, error_message,numline,next_token}, rest} ->
                {{:error, error_message,numline,next_token}, rest}

              {statement_node,lista_rest} ->
                [{next_token,numline}|rest]=lista_rest
                if next_token == :close_brace do
                  {%AST{node_name: :function, value: :main, left_node: statement_node}, rest}
                else
                  {{:error, "Error #5",numline,next_token}, rest}
                end
            end
          end
        end
      else
        {{:error, "Error #6",numline,next_token}, []}
      end
  end

  def parse_statement([{next_token,numline} | rest]) do
      if next_token == :return_keyword do
        expression = parse_expression(rest)
        case expression do
          {{:error, error_message,numline,next_token}, rest} ->
            {{:error, error_message,numline,next_token}, rest}

          {exp_node,lista_rest} ->
            [{next_token,numline}|rest]=lista_rest
            if next_token == :semicolon do
              {%AST{node_name: :return, left_node: exp_node}, rest}
            else
              {{:error, "Error #7",numline,next_token}, rest}
            end
        end
      else
        {{:error, "Error #8",numline,next_token}, rest}
      end
    end

  def parse_expression([{next_token,numline} | rest]) do
    case next_token do
      {:constant, value} ->
        {%AST{node_name: :constant, value: value}, rest}
    :complement_keyword->
      unary_op([{next_token,numline} | rest])
    :negative_keyword->
      unary_op([{next_token,numline} | rest])
    :negative_logical ->
      unary_op([{next_token,numline} | rest])
    _->
    {{:error, "Error en arbol 2",numline,:constant}, rest}
    end
  end

def next_term ([{next_token,numline}] | rest) do
    case next_token do
      
    end
end
def parse_term ([{next_token,numline}]| rest)

end

def parse_factor ([{next_token,numline}]| rest)

do

  def unary_op([{next_token,numline} | rest]) do
    case next_token do
      :negative_keyword ->
        parexpres=parse_expression(rest)
        {nodo,rest_necesario}=parexpres
        {%AST{node_name: :unary_negative, left_node: nodo}, rest_necesario}
      :complement_keyword ->
        parexpres=parse_expression(rest)
        {nodo,rest_necesario}=parexpres
        {%AST{node_name: :unary_complement, left_node: nodo}, rest_necesario}
      :negative_logical ->
        parexpres=parse_expression(rest)
        {nodo,rest_necesario}=parexpres
        {%AST{node_name: :negative_logical, left_node: nodo}, rest_necesario}
      _ -> {{:error, "Error en arbol 1",numline,next_token}, rest}
    end
  end
end
