defmodule Parser do
  def parse_program(token_list) do
  function = parse_function(token_list)

  case function do
    #Para manejar los errores (tuplas)
    {{:error, error_message}, _rest} ->
      {:error, error_message}

      # Se especifica el error que lanzara la tupla
      {function_node, rest} ->
        if rest == [] do
          %AST{node_name: :program, left_node: function_node}
        else
          {:error, "Error: Hay más elementos de los permitidos"}
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
                    {%AST{node_name: :function, value: :main, left_node: statement_node}, rest} ##Estruc  AST del prof
                  else
                    {{:error, "Error, llave de cierre no encontrada"}, rest}
                  end
              end
            else
              {:error, "Error: llave de apertura no encontrada"}
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
      {:error, "Error, tipo de retorno no definiso"}
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
            {{:error, "Error: ; no encontrado"}, rest}
          end
      end
    else
      {{:error, "Error: return no encontrado"}, rest}
    end
  end

  def parse_expression([next_token | rest]) do
    case next_token do
      {:constant, value} -> {%AST{node_name: :constant, value: value}, rest}
      _ -> {{:error, "Error: constant value missed"}, rest} ##Estruc  AST del prof
     end
  end

end