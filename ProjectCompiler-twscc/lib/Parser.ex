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
    #Si tokens trae error, devuelve ese mismo error sin crear un nodo de árbol
    case tokens do
      {:error, _} -> [tokens, nil]
      _-> {atom, value, tokens} =

          case List.first(tokens) do
            #Parsea una constante.
            {:constant, _} -> parse_constant(tokens, :constant)
            #Expresión futura
            #Expresión futura
            #Expresión futura
            _-> {"", "", {:error, "Error de sintaxis. Falta un valor en la expresión."}}
          end

          case tokens do
            {:error, _} -> [tokens, ""]
            #Si no hubo error al parsear la expresión, crea nodo de la expresión y devuélvelo.
            _ -> [tokens, {atom, value, {}, {}}]
          end
    end

  end

  def parse_constant(token, atom) do
    #¿Token trae tupla error en vez de la lista? devuelvela tal como está.
    case token do
      {:error, _} -> {"", "", token}; #envia null porque solo te interesa propagar tokens
      _ -> if elem(List.first(token), 0) == atom do
              {atom, elem(List.first(token), 1), Enum.drop(token, 1)}
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
          _ -> "(vacío)"
      end
  end

end
