defmodule Parser do

  def parsero(t1) do
    try do
      parse_program(tl);
    rescue
      #no hacer nada, dejar que el orquestador indique que hubo un error de parseo y no podrá generar el árbol
      MatchError -> nil;
    end
  end

  def parsear(lista, atom) do
    #extrae primer elemento de la lista y lo compara con átomo o si es tupla {constante, 4}
    if (List.first(lista) == atom) do
      #devuelve el primer elemento de la lista y bórralo
      {List.first(lista), List.delete(lista, atom)};
    else
      IO.puts("Error en el parseo");
      #devuelve la misma lista sin alterar.
      {nil, lista}
    end
  end

  def parse_program(t1) do
    {_, func_node}= parse_function(tl);
    {:program, "program", func_node, {}} #raiz, finaliza árbol
  end

  def parse_function(t1) do
    #IO.puts("*NODO FUNCION, GENERANDO RAMAS:")
    #parsear int main(){...
    #{elemento extraido, lista tokens} a almacenar en la variable. Util para el AST}
    {a, token_list} = parsear(token_list, :int_Keyword);
    {b, token_list} = parsear(token_list, :main_Keyword);
    {c, token_list} = parsear(token_list, :open_paren);
    {d, token_list} = parsear(token_list, :close_paren);
    {e, token_list} = parsear(token_list, :open_brace);
        #IO.inspect(token_list, label: "Lista de tokens");
    ##mostrando elementos extraidos
    #IO.inspect(a, label: "T");
    #IO.inspect(b, label: "NT");
    #IO.inspect(c, label: "T");
    #IO.inspect(d, label: "T");
    #IO.inspect(e, label: "T");
    ##antes de construir el nodo de la funcion main, parse las declaraciones a continuacion
    {nil, token_list, state} = parse_statement(token_list);
    #si el parseo anterior fue correcto, finaliza el nodo funcion y créalo hacia arriba
    {g, token_list} = parsear(token_list, :close_brace);
    #IO.inspect(g, label: "T");
    #IO.puts("*NODO FUNCION FINALIZADO")
    func={:function, Atom.to_string(b), state, {}}##aqui se agregan los nodos
    {nil, token_list, func};  ##se vuelve a poner, es lo que devolverá esta funcion
  end

  def parse_statement(t1) do
    #IO.puts("*NODO STATEMENTS, GENERANDO RAMAS:")
    ##parsear {return 2;...
    {h, token_list} = parsear(token_list, :return_Keyword);
    #deriva una expresión
    {nil, token_list, exp} = parse_exp(token_list);
    {j, token_list} = parsear(token_list, :semicolon);

    #IO.inspect(h, label: "T");
    #IO.inspect(j, label: "T");
    ##parseo correcto, vuelvee a terminar de ejecutar el parse_function devolviendo la lista restante
    #IO.puts("*NODO STATEMENT FINALIZADO")
    #devuelve nil, token para que function continue utilizando la lista

    state={h, "return" , exp, {} }#definicion de la expresion statement

    {nil, token_list,state};

  end

  def parse_exp(t1) do
    #IO.puts("NODO EXPRESIÓN, GENERANDO RAMAS")
    #IO.inspect(token_list);
    {nil, token_list, node} =
    case List.first(token_list) do
      #aquí puede haber dos derivaciones de la constante, 2 o 4. Util para cuando tengamos que ampliar la gramática
      {:constant, _} -> parse_constant(token_list);

    end

    #IO.puts("NODO EXPRESIÓN FINALIZADO")
    exp={elem(node, 0), elem(node, 1), node, {}}
    {nil, token_list, node}
  end

  def parse_constant(t1) do
    {a, token_list} = parsear_entero(token_list)
    const = {elem(a, 0), elem(a, 1), {}, {}} #T
    {nil, token_list, const}
  end
end
