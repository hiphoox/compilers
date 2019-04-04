defmodule Parser do

  def parsero(tl) do
    try do
      parse_program(tl);
    rescue
      #no hacer nada, dejar que el orquestador indique que hubo un error de parseo y no podrá generar el árbol
      MatchError -> nil;
    end
  end

  def parse_program(tl) do
    {_, func_node}= parse_function(tl);
    {:program, "program", func_node, {}} #raiz, finaliza árbol
  end

  def parse_function(tl) do
    #{elemento extraido, lista tokens} a almacenar en la variable. Util para el AST}
    {_a, tl} = parsear(tl, :int_Keyword);
    {_b, tl} = parsear(tl, :main_Keyword);
    {_c, tl} = parsear(tl, :open_paren);
    {_d, tl} = parsear(tl, :close_paren);
    {_e, tl} = parsear(tl, :open_brace);
    ##antes de construir el nodo de la funcion main, parse las declaraciones a continuacion
    {tl, state_node} = parse_statement(tl);
    #si el parseo anterior fue correcto, finaliza el nodo funcion y créalo hacia arriba
    {_, tl} = parsear(tl, :close_brace)
    {tl, {:function, "main", state_node, {}}};  ##se vuelve a poner, es lo que devolverá esta funcion
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

  def parsear(lista, atom) do
      #extrae primer elemento de la lista y lo compara con átomo o si es tupla {constante, 4}
      if (List.first(lista) == atom) do
        #devuelve el primer elemento de la lista y bórralo
        {List.first(lista), List.delete(lista, atom)};
      else
        IO.inspect(atom, label: "Error: falta un ");
      end
  end

  def parsear_entero(lista) do
    #extrae primer elemento de la lista y lo compara con átomo o si es tupla {constante, 4}
    #entero de 16 bits sin signo
    if Enum.member?(0..4294967295, elem(List.first(lista), 1)) do
      #devuelve el primer elemento de la lista y bórralo
      {List.first(lista), List.delete(lista, List.first(lista))};
    else
      IO.puts("Error: número entero inválido");
    end
  end

end
