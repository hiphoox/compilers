defmodule Parser do
  def parse_program(token_list) do
    function = parse_function(token_list)

    case function do
      {{:error, error_message}, _rest} ->
        {:error, error_message}

      {function_node, rest} ->
        if rest == [] do
          %AST{node_name: :program, left_node: function_node}
        else
          {:error, "Error: thera are more elements after Keyword 'end' ", 0}
        end
    end
  end

  def parse_function([next_token | rest]) do
    if next_token == :intkeyword do
      [next_token | rest] = rest

      if next_token == :mainkeyword do
        [next_token | rest] = rest

        if next_token == :open_parenthesis do
          [next_token | rest] = rest

          if next_token == :close_parenthesis do
            [next_token | rest] = rest

            if next_token == :open_brace do
              statement = parse_statement(rest)

              case statement do
                {{:error, error_message}, rest} ->
                  {{:error, error_message}, rest}

                {statement_node, [next_token | rest]} ->
                  if next_token == :close_brace do
                    {%AST{node_name: :function, value: :main, left_node: statement_node}, rest}
                  else
                    {{:error, "Error: it was found -> <- when expecting  ->close brace<- "}, rest}
                  end
              end
            else
              {{:error, "Error: it was found ->#{next_token}<- when expecting  ->open brace<- "},rest}
            end
          else
            {{:error, "Error: it was found ->#{next_token}<- when expecting  ->close parenthesis<- "},rest}
          end
        else
          {{:error, "Error: it was found ->#{next_token}<- when expecting  ->open parenthesis<-"},rest}
        end
      else
        {{:error, "Error: it was found ->#{next_token}<- when expecting  ->main<-"},rest}
      end
    else
      {{:error, "Error: it was found ->#{next_token}<- when expecting  ->return type<-"},rest}
    end
  end

  def parse_statement([next_token | rest]) do
    if next_token == :returnkeyword do
      expression = parse_expression(rest)

      case expression do
        {{:error, error_message}, rest} ->
          {{:error, error_message}, rest}

        {exp_node, [next_token | rest]} ->
          if next_token == :semicolon do
            {%AST{node_name: :return, left_node: exp_node}, rest}
          else
            {{:error, "Error: it was found ->#{next_token}<- when expecting  ->semicolon<- "},
             rest}
          end
      end
    else
      {{:error, "Error: it was found ->#{next_token}<- when expecting  ->return keyword<- "}, rest}
    end
  end

  def parse_expression([next_token | rest]) do
    case next_token do
      {:constant, value} -> {%AST{node_name: :constant, value: value}, rest}

      :operator_negation ->
        parse_unary_op([next_token | rest])

      :operator_bitwise_complement ->
        parse_unary_op([next_token | rest])

      :operator_logical_negation ->
        parse_unary_op([next_token | rest])

      _-> {{:error, "Error: it was found ->#{next_token}<- when expecting  ->constant<-"},rest}
    end
  end

  def parse_unary_op ([next_token | rest]) do
    case next_token do

      :operator_negation ->
        parse_unary=parse_expression(rest)
        {nodo,rest2}=parse_unary
        case parse_unary do
        {{:error, error_message}, rest} -> {{:error, error_message}, rest}
        _-> {%AST{node_name: :negation, left_node: nodo}, rest2}
        end

      :operator_bitwise_complement ->
        parse_unary=parse_expression(rest)
        {nodo,rest2}=parse_unary
        case parse_unary do
        {{:error, error_message}, rest} -> {{:error, error_message}, rest}
        _-> {%AST{node_name: :complement, left_node: nodo}, rest2}
        end

      :operator_logical_negation ->
        parse_unary=parse_expression(rest)
        {nodo,rest2}=parse_unary
        case parse_unary do
        {{:error, error_message}, rest} -> {{:error, error_message}, rest}
        _-> {%AST{node_name: :logical, left_node: nodo}, rest2}
        end

      _ -> {:error, "Error: not found unary op",next_token, rest}

    end
  end

end
