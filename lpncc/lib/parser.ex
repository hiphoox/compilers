defmodule Parser do
  @moduledoc """
  <program> ::= <function>
  <function> ::= "int" <id> "(" ")" "{" <statement> "}"
  <statement> ::= "return" <parsea_expresion> ";"
  <parsea_expresion> ::= <int>
  """

  def program(token_list) do
    function = funcion(token_list,0)
    case function do
      {{:error,error_message,linea,problema}, _rest} ->
        {:error, error_message, linea,problema}

      {function_node, rest} ->
        if rest == [] do
          %AST{node_name: :program, left_node: function_node}
        else
          {:error, "Error: Hay mas elementos después de finalizar la función",0,"más elementos"}
        end
    end
  end

  def funcion([{token_sig,numline} | rest],counter) do
    if rest != [] do
      case counter do
        0->
          if token_sig == :int_keyword do
            counter=counter+1
            funcion(rest,counter)
          else
            {{:error, "Error 1",numline,token_sig},rest}
          end
        1->
          if token_sig == :main_keyword do
            counter=counter+1
            funcion(rest,counter)
          else
            {{:error, "Error, 2",numline,token_sig},rest}
          end
        2->
          if token_sig == :open_paren do
            counter=counter+1
            funcion(rest,counter)
          else
            {{:error, "Error, 3 ",numline,token_sig},rest}
          end
        3->
          if token_sig == :close_paren do
            counter=counter+1
            funcion(rest,counter)
          else
            {{:error, "Error, 4 ",numline,token_sig},rest}
          end
        4->
          if token_sig == :open_brace do
            statement = statement_func(rest)
            case statement do
              {{:error, error_message,numline,token_sig}, rest} ->
                {{:error, error_message,numline,token_sig}, rest}

              {statement_node,lista_rest} ->
                [{token_sig,numline}|rest]=lista_rest
                if token_sig == :close_brace do
                  {%AST{node_name: :function, value: :main, left_node: statement_node}, rest}
                else
                  {{:error, "Error 5",numline,token_sig}, rest}
                end
            end
          end
        end
      else
        {{:error, "Error, 6",numline,token_sig}, []}
      end
  end

  def statement_func([{token_sig,numline} | rest]) do
      if token_sig == :return_keyword do
        expression = parsea_expresion(rest)
        case expression do
          {{:error, error_message,numline,token_sig}, rest} ->
            {{:error, error_message,numline,token_sig}, rest}

          {exp_node,lista_rest} ->
            [{token_sig,numline}|rest]=lista_rest
            if token_sig == :semicolon do
              {%AST{node_name: :return, left_node: exp_node}, rest}
            else
              {{:error, "Error: 7",numline,token_sig}, rest}
            end
        end
      else
        {{:error, "Error: 8",numline,token_sig}, rest}
      end
    end

  def parsea_expresion([{token_sig,numline} | rest]) do
    case token_sig do
      {:constant, value} ->
        {%AST{node_name: :constant, value: value}, rest}
    :complemento->
      operador_unario([{token_sig,numline} | rest])
    :substractor->
      operador_unario([{token_sig,numline} | rest])
    :negacion_logica ->
      operador_unario([{token_sig,numline} | rest])
    _->
    {{:error, "Error, arbol 2",numline,:constant}, rest}
    end
  end

  def operador_unario([{token_sig,numline} | rest]) do
    case token_sig do
      :substractor ->
        expression = parsea_expresion(rest)
        {nodo,rest_necesario} = expression
        {%AST{node_name: :negacion_logica, left_node: nodo}, rest_necesario}
      :complemento ->
        expression = parsea_expresion(rest)
        {nodo,rest_necesario} = expression
        {%AST{node_name: :complemento, left_node: nodo}, rest_necesario}
      :negacion_logica ->
        expression=parsea_expresion(rest)
        {nodo,rest_necesario}=expression
        {%AST{node_name: :negacion_logica, left_node: nodo}, rest_necesario}
      _ -> {{:error, "Error, arbol 1",numline,token_sig}, rest}
    end
  end
end