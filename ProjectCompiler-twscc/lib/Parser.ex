defmodule Parser do
  def parse_tokens(token_list, flag) do
    output = parse_program(token_list)
    #si output fue una tupla error, regrésala. Sino parsea bandera y devuelve arbol
    if elem(output, 0) == :error , do: output, else: parsing_flag(output, flag)
  end

  def parse_program(tokens) do
    [tokens, func_node] = parse_function(tokens)
    case tokens do
      {:error, _} -> tokens
      _-> {:program, "program", func_node, {}}
    end
  end

  def parse_function(tokens) do
    #si en algun momento del parseo, tokens = {:error, ...} propagalo
    #Se ignoran algunos valores y átomos. No son de interés para construir el árbol, solo para verificar.
    {_atom, _value, tokens} = parse(tokens, :int_Keyword)
    {_atom, _value, tokens} = parse(tokens, :main_Keyword)
    {_atom, _value, tokens} = parse(tokens, :open_paren)
    {_atom, _value, tokens} = parse(tokens, :close_paren)
    {_atom, _value, tokens} = parse(tokens, :open_brace)
    #Si tokens = {:error,..} sigue propagandolo
    [tokens, state_node] = parse_statement(tokens)
    #Aquí sigue llegando la tupla de error en tokens, sigue pasandola...
    {_atom, _value, tokens} = parse(tokens, :close_brace)
    #Si tokens trae error, devuelve ese mismo error sin crear un nodo de árbol
    case tokens do
      {:error, _} -> [tokens, ""]
      #De lo contrario, devuelve lista de tokens y el nodo a construir.
      _ -> [tokens, {:function, "main", state_node, {}}]
    end
  end

  def parse_statement(tokens) do
    {atom, _value, tokens} = parse(tokens, :return_Keyword)
    #Parseando expresión. Constante únicamente.
    [tokens, exp_node] = parse_expression(tokens)
    {_atom, _value, tokens} = parse(tokens, :semicolon)

    case tokens do
    #Si tokens trae error, devuelve ese mismo error sin crear un nodo de árbol
      {:error, _} -> [tokens, ""]
    #De lo contrario, devuelve lista de tokens y el nodo a construir.
      _ -> [tokens, {atom, "return", exp_node, {}}]
    end
  end

  def parse_expression(tokens) do
    #IO.inspect(List.first(tokens), label: "K TRAE TOKENS")
    #Si tokens trae error, devuelve ese mismo error sin crear un nodo de árbol
    case tokens do
      {:error, _} -> [tokens, nil]
      _-> [tokens, node_exp_parsed]=

          case List.first(tokens) do
            #Parsea una constante.
            {:constant, _} -> parse_constant(tokens, :constant)
            :bitewise_Keyword -> parse_unary_ops(tokens, :bitewise_Keyword); #detecta operador unario
            :logicalNeg_Keyword -> parse_unary_ops(tokens,:logicalNeg_Keyword);
            :negation_Keyword -> parse_unary_ops(tokens,:negation_Keyword);
            #Expresión futura
            #Expresión futura
            #Expresión futura
            _-> [{:error, "Error de sintaxis. Falta algún valor en la expresión."}, ""]
          end


          case tokens do
            {:error, _} -> [tokens, ""]
            #Si no hubo error al parsear la expresión, crea nodo de la expresión y devuélvelo.
            _ -> [tokens, node_exp_parsed]
          end
    end

  end
#funcion que extrae y parsea el operador unario
  def parse_unary_ops(token, atom) do
    case token do
      {:error, _} -> {"", "", token}; #envia null porque solo te interesa propagar tokens
      _ -> if List.first(token) == atom do
              remain=Enum.drop(token, 1) #extraer el elemento de la lista de tokens y borrarlo
              [token, inner_exp] = parse_expression(remain)#RECURSIVIDAD, inner_exp contiene los elementos restantes de de la expresión, llama a parser_exp para volver a parsear hasta que terminemos de evaluar todos los elementos
              [token, {atom, diccionario(atom), inner_exp,{}}]
           else
              [{:error, ""}, ""]
          end
    end
  end


  def parse_constant(token, atom) do
    #¿Token trae tupla error en vez de la lista? devuelvela tal como está.
    case token do
      {:error, _} -> {"", "", token}; #envia null porque solo te interesa propagar tokens
      _ -> if elem(List.first(token), 0) == atom do
              [Enum.drop(token, 1), {elem(List.first(token),0), elem(List.first(token),1),{},{}}]
           else
              {"", "", {:error, "Error de sintáxis. Constante inválida."}}
          end
    end
  end

  def parse(token, atom) do
    #Si el token entrante es un error, devuelvelo tal como está
    case token do
      {:error, _} -> {"", "", token};
      _ -> if List.first(token) == atom do
              {atom, "", Enum.drop(token, 1)}
           else
              {"", "", {:error, "Error de sintáxis. Se esperaba "<> diccionario(atom) <>" y se encontró: " <> diccionario(List.first(token))}}
           end
    end
  end

  #Muestra en pantalla el árbol. Finaliza ejecución al devolver la tupla :only_ast
  def parsing_flag(ast, :show_ast) do
    IO.inspect(ast)
    {:only_ast, ast}
  end

  #Sólo devuelve el árbol al orquestador para continuar
  def parsing_flag(ast, _) do
    {:ok, ast}
  end

  #Diccionario utilizado para convertir los Keyword a caractéres.
  def diccionario(atom) do
      case atom do
          :int_Keyword->"int"
          :main_Keyword->"main"
          :open_paren->"("
          :close_paren->")"
          :open_brace->"{"
          :close_brace->"}"
          :return_Keyword->"return"
          :semicolon->";"
          :logicalNeg_Keyword->"!"
          :negation_Keyword->"-"
          :bitewise_Keyword -> "~"
          _ -> "(vacío)"
      end
  end

end
