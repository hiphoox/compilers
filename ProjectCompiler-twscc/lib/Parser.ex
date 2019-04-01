defmodule Parser do
  def parsero(token_list) do
   #llamada a creación de la gramática para el AST, debería devolver un árbol. Actualmente regresa "nil"
   ast_tree = parse_program(token_list);
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
end
