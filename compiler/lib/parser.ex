defmodule Parser do
  def parse_program(token_list) do
    function = parse_function(token_list)

    case function do
      {{:error, error_message, linea}, _rest} ->
        {:error, error_message, linea}

      {function_node, rest} ->
        if rest == [] do
          %AST{node_name: :program, left_node: function_node}
        else
          {:error, "Error: there are more elements after function end",0}
        end
    end
  end

  def parse_function([{next_token,numline} | rest]) do
    if next_token == :int_keyword do
      [{next_token,numline} | rest] = rest
      if next_token == :main_keyword do
        [{next_token,numline} | rest] = rest

        if next_token == :open_paren do
          [{next_token,numline} | rest] = rest

          if next_token == :close_paren do
            [{next_token,numline} | rest] = rest

            if next_token == :open_brace do
              statement = parse_statement(rest)

              case statement do
                {{:error, error_message,numline}, rest} ->
                  {{:error, error_message,numline}, rest}

                {statement_node, [{next_token,numline} | rest]} ->
                  if next_token == :close_brace do
                    {%AST{node_name: :function, value: :main, left_node: statement_node}, rest}
                  else
                    {{:error, "Error, close brace missed in line",numline}, rest}
                  end
              end
            else
              {:error, "Error: open brace missed in line",numline}
            end
          else
            {:error, "Error: close parentesis missed in line",numline}
          end
        else
          {:error, "Error: open parentesis missed  in line",numline}
        end
      else
        {:error, "Error: main functionb missed in line",numline}
      end
    else
      {:error, "Error, return type value missed in line",numline}
    end
  end

  def parse_statement([{next_token,numline} | rest]) do
    if next_token == :return_keyword do
      expression = parse_expression(rest)

      case expression do
        {{:error, error_message}, rest} ->
          {{:error, error_message}, rest}

        {exp_node, [{next_token,numline} | rest]} ->
          if next_token == :semicolon do
            {%AST{node_name: :return, left_node: exp_node}, rest}
          else
            {{:error, "Error: semicolon missed after constant to finish return statement in line",numline}, rest}
          end
      end
    else
      {{:error, "Error: return keyword missed in line",numline}, rest}
    end
  end

  def parse_expression([{next_token,numline} | rest]) do
    case next_token do
      {:constant, value} -> {%AST{node_name: :constant, value: value}, rest}
      _ -> {{:error, "Error: constant value missed in line",numline}, rest}
    end
  end
end
