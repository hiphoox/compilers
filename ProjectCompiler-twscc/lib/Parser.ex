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
    #ir revisando si existe el elemento en la lista de tokens
    remain_tl = tl
       |> parse(:int_Keyword)
       |> parse(:main_Keyword)
       |> parse(:open_paren)
       |> parse(:close_paren)
       |> parse(:open_brace)
    #ahora revisa las declaraciones, si todo es correcto devuelve un nodo y continua el parseo
    [tl, state_node] = parse_statement(remain_tl);
    tl |> parse(:close_brace)
    {:function, "main", state_node, {}};  ##se vuelve a poner, es lo que devolverá esta funcion
  end

  def parse_statement(tl) do
    #devuelve los tokens restantes y el atomo extraido para el nombre del nodo
    [remain_tl, elem] = tl |> parse_ret_value(:return_Keyword)
    [tl, exp_node] = parse_exp(remain_tl);
    remain_tl = tl |> parse(:semicolon)
    [remain_tl, {elem, "return" , exp_node, {}}];
  end

  def parse_exp(tl) do
    #tokens restantes, atomo extraido y su dato para el nodo
    [remain_tl, elem_atom, value] =
    case List.first(tl) do
      {:constant, _} ->  tl |> parse_atom_value(:constant)
      _ -> IO.puts("Error: falta una expresión después de return");
           spawn_link fn -> exit(1) end
    end
    [remain_tl, {elem_atom, value, {}, {}}]
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
