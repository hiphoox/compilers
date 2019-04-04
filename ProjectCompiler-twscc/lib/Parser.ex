defmodule Parser do

  def main(tl) do
      parse_program(tl);
  end

  def parse_program(tl) do
    {:program, "program", parse_function(tl), {}} #raiz, finaliza árbol y lo devuelve a main
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
    {h, tl} = parsear(tl, :return_Keyword);
    #deriva una expresión a partir desde aquí
    {tl, exp_node} = parse_exp(tl);
    #si el parseo fue correcto, finaliza el parse del nodo Statement y llámalo "Return"
    {_J, tl} = parsear(tl, :semicolon);
    state_node={h, "return" , exp_node, {}}
    {tl, state_node};
  end

  def parse_exp(tl) do
    {tl, node_exp} =
    case List.first(tl) do
      {:constant,_} -> parse_constant(tl);
      #Aquí se ampliará la gramática conforme las entregas
      ############################
      ############################
      ############################
      _ -> IO.puts("Error: falta una expresión después de return");
    end
    {tl, node_exp}
  end

  def parse_constant(tl) do
    {a, tl} = parsear_entero(tl)
    {tl, {elem(a, 0), elem(a, 1), {}, {}}}
  end

  def parse(lista, atom) do
      #extrae primer elemento de la lista y lo compara con átomo o si es tupla {constante, 4}
      if (List.first(lista) == atom) do
        #devuelve el primer elemento de la lista y bórralo
        {List.first(lista), List.delete(lista, atom)};
      else
        IO.inspect(atom, label: "Error: falta un ");
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
