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
##antes de construir el nodo de la funcion main, parse las declaraciones a continuacion
{nil, token_list} = parse_statement(token_list);
#si el parseo anterior fue correcto, finaliza el nodo funcion y créalo hacia arriba
{g, token_list} = parsear(token_list, :close_brace);
IO.inspect(g, label: "T");
IO.puts("*NODO FUNCION FINALIZADO")
{nil, token_list};  ##se vuelve a poner, es lo que devolverá esta funcion
   end

   def parse_statement(token_list) do
     IO.puts("*NODO STATEMENTS, GENERANDO RAMAS:")
     ##parsear {return 2;...
     {h, token_list} = parsear(token_list, :return_Keyword);
     #deriva una expresión
     {nil, token_list,exp} = parse_exp(token_list);
     {j, token_list} = parsear(token_list, :semicolon);

     IO.inspect(h, label: "T");
     IO.inspect(j, label: "T");
     ##parseo correcto, vuelvee a terminar de ejecutar el parse_function devolviendo la lista restante
     IO.puts("*NODO STATEMENT FINALIZADO")
     #devuelve nil, token para que function continue utilizando la lista

     state={:statement,[h,exp,j]}#definicion de la expresion statement

     {nil, token_list,state};
   end

   def parse_exp(token_list) do
      IO.puts("NODO EXPRESIÓN, GENERANDO RAMAS")

      {i, token_list} =
      case List.first(token_list) do
        #aquí puede haber dos derivaciones de la constante, 2 o 4. Util para cuando tengamos que ampliar la gramática
        {:constant, 2} -> parsear(token_list, {:constant, 2});
        {:constant, 4} -> parsear(token_list, {:constant, 4});
      end
      IO.inspect(i, label: "T")
      IO.puts("NODO EXPRESIÓN FINALIZADO")
      exp={:exp,[elem(i,1)]}
      {nil, token_list,exp}
    end
end
