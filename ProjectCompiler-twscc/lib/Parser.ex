defmodule Parser do

  def parse_tokens(token_list, flag) do
    output =
    case token_list do
      #si llegó tupla de error desde el Lexer, mándasela ahora al Generador de Código
      {:end, _} -> token_list #si llegó tupla de error desde el Lexer, mándasela ahora al G
      _ -> parse_program(token_list)
    end
    if flag == :show_ast do
      IO.inspect(output)
      output
    else
      output
  end
  end

  def main(tl) do
      parse_program(tl);
  end

  def parse_program(tl) do
    [tokens, func_node] = parse_function(tokens)
    case tokens do
      {:error, _} -> tokens
      _-> {:program, "program", func_node, {}}
    end
  end

  def parse_function(tl) do
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

  def parse_statement(tl) do
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
                          _-> {"", "", {:error, "Error al parsear algun elemento de la expresion"}}
          end
          case tokens do
            {:error, _} -> [tokens, ""]
            _ -> [tokens, {atom, value, {}, {}}]
          end
    end

  end

    def parse(tl, atom) do
      if List.first(tl) == atom do  #si hace match con el token
         Enum.drop(tl, 1); #elimina de la lista el token
       else
         IO.inspect(atom, label: "Error al parsear: Falta el elemento")
         spawn_link fn -> exit(1) end #lanzar un error matando al proceso en sí para interrumpir la ejecucion
       end
    end

    def parse_ret_value(tl, atom) do
      if List.first(tl) == atom do #si hace match con el token
          [Enum.drop(tl, 1), List.first(tl)] #elimina de la lista el token
          #regresa tokens restante y el valor del átomo
       else
         IO.inspect(atom, label: "Error al parsear: Falta el elemento")
         spawn_link fn -> exit(1) end
       end
    end

    def parse_atom_value(tl, atom) do
      if elem(List.first(tl), 0) == atom do #si hace match con el token
          [Enum.drop(tl, 1), elem(List.first(tl), 0), elem(List.first(tl), 1)] #elimina de la lista el token
          #regresa tokens restantes, valor del atomo y dato que tendrá el nodo
       else
         IO.inspect(atom, label: "Error al parsear: Falta el elemento")
         spawn_link fn -> exit(1) end
       end
    end
end
