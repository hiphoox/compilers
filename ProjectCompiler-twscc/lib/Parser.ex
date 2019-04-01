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

  def parse_program(token_list) do
    IO.puts("*NODO PROGRAMA, GENERANDO RAMAS:")
    #llamando a parse_function(list)
    {nil, token_list}= parse_function(token_list);
    IO.puts("*NODO PROGRAMA FINALIZADO")
    IO.inspect(token_list, label: "Lista de tokens restantes");
    nil; #en esta linea debería regresar un árbol
  end

   def parse_function(token_list) do
     IO.puts("*NODO FUNCION, GENERANDO RAMAS:")
#parsear int main(){...
#{elemento extraido, lista tokens} a almacenar en la variable. Util para el AST}
{a, token_list} = parsear(token_list, :int_Keyword);
{b, token_list} = parsear(token_list, :main_Keyword);
{c, token_list} = parsear(token_list, :open_paren);
{d, token_list} = parsear(token_list, :close_paren);
{e, token_list} = parsear(token_list, :open_brace);
    IO.inspect(token_list, label: "Lista de tokens");
    ##mostrando elementos extraidos
IO.inspect(a, label: "T");
IO.inspect(b, label: "NT");
IO.inspect(c, label: "T");
IO.inspect(d, label: "T");
IO.inspect(e, label: "T");

   end

   def parse_statement(token_list) do

   end
end
