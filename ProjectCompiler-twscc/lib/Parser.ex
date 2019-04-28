defmodule Parser do
  def parse_tokens(token_list, flag) do
    output = parse_program(token_list)

    #si output fue una tupla error, regrésala. Sino parsea bandera y devuelve arbol
    if elem(output, 0) == :error , do: output, else: parsing_flag(output, flag)
  end

  def parsing_flag(ast, :show_ast) do
     IO.inspect(ast)
     {:only_ast, ast}
  end

  def parsing_flag(ast, _) do
     {:ok, ast}
  end


  def parse_program(tokens) do
    [tokens, func_node] = parse_function(tokens)
    #IO.inspect(tokens)
    case tokens do
      {:error, _} -> tokens
      _-> {:program, "program", func_node, {}}
    end
  end

  def parse_function(tokens) do
    #si en algun momento del parseo, tokens = {:error, ...} propagalo

    {_atom, _value, tokens} = parse(tokens, :int_Keyword)
    {_atom, _value, tokens} = parse(tokens, :main_Keyword)
    {_atom, _value, tokens} = parse(tokens, :open_paren)
    {_atom, _value, tokens} = parse(tokens, :close_paren)
    {_atom, _value, tokens} = parse(tokens, :open_brace)
    #si tokens = {:error,..} sigue propagandolo
    [tokens, state_node] = parse_statement(tokens)
    #aquí sigue llegando la tupla de error en tokens, sigue pasandola...
    {_atom, _value, tokens} = parse(tokens, :close_brace)

    #Si tokens trae error, devuelve ese mismo error sin crear un nodo de árbol
    case tokens do
      {:error, _} -> [tokens, ""]
      #de lo contrario, devuelve lista de tokens y el nodo a construir
      _ -> [tokens, {:function, "main", state_node, {}}]
    end
  end

  def parse_statement(tokens) do
    {atom, _value, tokens} = parse(tokens, :return_Keyword)

    [tokens, exp_node] = parse_expression(tokens)

    {_atom, _value, tokens} = parse(tokens, :semicolon)
    case tokens do
      {:error, _} -> [tokens, ""]
      _ -> [tokens, {atom, "return", exp_node, {}}]
    end
  end

  def parse_expression(tokens) do
    case tokens do
      {:error, _} -> [tokens, nil]
      _-> {atom, value, tokens} =
          case List.first(tokens) do
            {:constant, _} -> parse_constant(tokens, :constant)
            ########################expandir operadores para la entrega dos aquí
                          _-> {"", "", {:error, "Error al parsear algun elemento de la expresion"}}
          end
          case tokens do
            {:error, _} -> [tokens, ""]
            _ -> [tokens, {atom, value, {}, {}}]
          end
    end

  end

  def parse_constant(token, atom) do
        #¿token trae tupla error en vez de la lista? devuelvela tal como está
    case token do
      {:error, _} -> {"", "", token}; #envia null porque solo te interesa propagar tokens
                  _ -> if elem(List.first(token), 0) == atom do
                          {atom, elem(List.first(token), 1), Enum.drop(token, 1)}
                       else
                          #IO.inspect(atom, label: "Error al parsear el ")
                          {"", "", {:error, "Error de sintáxis. " <> Atom.to_string(atom)}}
                       end
    end
  end

  def parse(token, atom) do
    #Si el token entrante es un error, devuelvelo tal como está
    case token do
      {:error, _} -> {"", "", token};
                _ -> if List.first(token) == atom do
                           #IO.inspect(token);

                          #var = List.first(token)
                          #IO.inspect(var)
                           #last_parse(List.first(token));
                        #  IO.inspect(lista_extraidos, label: "RXTRAJE PARSEROO")
                     {atom, "", Enum.drop(token, 1)}
                     else
                       #lista_extraidos = [List.first(token)]
                       #IO.inspect(List.first(token));
                       #IO.inspect(last_parse);
                      # IO.inspect(List.first(lista_extraidos), label: "RXTRAJE PARSEROO");
                        #devuelve errores, únicamente la tupla de error.
                        {"", "", {:error, "Error de sintáxis. Se esperaba "<> diccionario(atom)<>" y se encontró: " <> diccionario(List.first(token))}}
                     end
    end
  end

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
          #breñññ revisa plos
          _ -> "Vacío"
      end


  end
end
