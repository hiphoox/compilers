defmodule Parser do
  def parse_program(token_list) do
    function = parse_function(token_list,0)
    case function do
      {{:error,error_message,linea,problema}, _rest} ->
        {:error, error_message, linea,problema}

      {function_node, rest} ->
        if rest == [] do
          %AST{node_name: :program, left_node: function_node}
        else
          {:error, "Error: there are more elements after function end",0,"more elements"}
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
            {{:error, "Error 1",numline,next_token},rest}
          end
        1->
          if next_token == :main_keyword do
            contador=contador+1
            parse_function(rest,contador)
          else
            {{:error, "Error, 2",numline,next_token},rest}
          end
        2->
          if next_token == :open_paren do
            contador=contador+1
            parse_function(rest,contador)
          else
            {{:error, "Error, 3 ",numline,next_token},rest}
          end
        3->
          if next_token == :close_paren do
            contador=contador+1
            parse_function(rest,contador)
          else
            {{:error, "Error, 4 ",numline,next_token},rest}
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
                  {{:error, "Error 5",numline,next_token}, rest}
                end
            end
          end
        end
      else
        {{:error, "Error, 6",numline,next_token}, []}
      end
  end

  def parse_statement([{next_token,numline} | rest]) do
      if next_token == :return_keyword do
        expression = parse_expression(rest,1)
        case expression do
          {{:error, error_message,numline,next_token}, rest} ->
            {{:error, error_message,numline,next_token}, rest}

          {exp_node,lista_rest} ->
            [{next_token,numline}|rest]=lista_rest
            if next_token == :semicolon do
              {%AST{node_name: :return, left_node: exp_node}, rest}
            else
              {{:error, "Error: 7",numline,next_token}, rest}
            end
        end
      else
        {{:error, "Error: 8",numline,next_token}, rest}
      end
    end

  def parse_expression(lista_tok,contador_exp) do
    [{next_token,numline} | rest]=lista_tok

        term = term(lista_tok,1)
        {expression_node,lista_rest}=term
        [{next_tok,numline}|rest]=lista_rest
        case next_tok do
        :sum ->
          subarbol=%AST{node_name: :sum}
          termop = parse_expression(rest,1)
          {node,lista_rest}=termop
          [{next_tok,numline}|restop]=lista_rest
          {%{subarbol | left_node: expression_node, right_node: node }, lista_rest}
        :negative_keyword->
          subarbol=%AST{node_name: :rest}
          termop = parse_expression(rest,1)
          {node,lista_rest}=termop
          [{next_tok,numline}|restop]=lista_rest
          {%{subarbol | left_node: expression_node, right_node: node }, lista_rest}
        _->
          term
        end
  end

  def term(arbol_AST,contador_term) do
    [{next_token,numline} | rest]=arbol_AST
         factor = factor(arbol_AST)
         {expression_node,lista_rest}=factor
         [{next_tok,numline}|rest]=lista_rest
         case next_tok do
         :multiplication ->
             subarbol=%AST{node_name: :multiplication}
             termop = parse_expression(rest,1)
             {node,lista_rest}=termop
             [{next_tok,numline}|restop]=lista_rest
             {%{subarbol | left_node: expression_node, right_node: node }, lista_rest}
          :division->
             subarbol=%AST{node_name: :division}
             termop = parse_expression(rest,1)
             {node,lista_rest}=termop
             [{next_tok,numline}|restop]=lista_rest
             {%{subarbol | left_node: expression_node, right_node: node }, lista_rest}
         _->
           factor
         end

  end

  def factor(arbol_AST) do
    [{next_token,numline} | rest]=arbol_AST
    case next_token do
      :open_paren->
        if next_token==:open_paren do
          expression=parse_expression(rest,1)
          case expression do
            {{:error, error_message}, rest} ->
                {{:error, error_message}, rest}

            {expression_node,lista_rest} ->
                  [{next_token,numline}|rest]=lista_rest
               if next_token == :close_paren do
                  {expression_node, rest}
                else
                  express=parse_expression(rest,1)
                  {node_expression,lista_rest_expression}=expression
                  {node,lista_rest_node}=express
                  [_|lista_sin_open_parent]=lista_rest_node
                  {%{node_expression | left_node: node}, lista_sin_open_parent}
                end
          end
        else
          {{:error, "Error: factor '(' ",numline,next_token}, rest}
        end
        :complement_keyword->
      unary_op([{next_token,numline} | rest])
        :negative_keyword->
      unary_op([{next_token,numline} | rest])
        :negative_logical ->
      unary_op([{next_token,numline} | rest])

      {:constant, value} ->

        {%AST{node_name: :constant, value: value}, rest}
      _->
      {{:error, "Error: factor (mas elementos)",numline,next_token}, rest}

    end
  end
  def unary_op([{next_token,numline} | rest]) do
    case next_token do
      :negative_keyword ->
        parexpres=factor(rest)
        {nodo,rest_necesario}=parexpres
        {%AST{node_name: :unary_negative, left_node: nodo}, rest_necesario}
      :complement_keyword ->
        parexpres=factor(rest)
        {nodo,rest_necesario}=parexpres
        {%AST{node_name: :unary_complement, left_node: nodo}, rest_necesario}
      :negative_logical ->
        parexpres=factor(rest)
        {nodo,rest_necesario}=parexpres
        {%AST{node_name: :negative_logical, left_node: nodo}, rest_necesario}
      _ -> {{:error, "Error, arbol 1",numline,next_token}, rest}
    end
  end
end
