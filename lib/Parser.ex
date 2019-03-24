defmodule Parser do

  def parsero(token_list)do
    parse_program(token_list);
    def parse_program(token_list) do
      parse_function(token_list);
      def parse_function(token_list) do
        ##parsear int main(){...
        #{lista tokens, elemento extraido a almacenar en la variable. Util para el AST}
        {token_list, a} = parse_and_remove(token_list, :int_Keyword);
        {token_list, b}  = parse_and_remove(token_list, :main_Keyword);
        {token_list, c} = parse_and_remove(token_list, :open_paren);
        {token_list, d} = parse_and_remove(token_list, :close_paren);
        {tokens, e} = parse_and_remove(tokens, :open_brace);
        ##antes de construir el nodo de la funcion main, parse las declaraciones a continuacion
        parse_statement(token_list);
        def parse_statement(token_list) do
          ##parsear {return 2;...
          {tokens, f} = parse_and_remove(tokens, :return_Keyword);
          {tokens, g} = parse_and_remove(tokens, {:constant, 2});
          {tokens, h} = parse_and_remove(tokens, :semicolon);
        end
        #si el parseo anterior fue correcto, finaliza el nodo funcion y créalo hacia arriba
        {tokens, i} = parse_and_remove(tokens, :semicolon);
      end
    end

    IO.puts("<Aquí debería ir el árbol>");
    IO.inspect(tokens);
    IO.puts("\nElementos extraidos individualmente para construir el árbol:")
    IO.inspect(a, label: "NT")
    IO.inspect(b, label: "NT")
    IO.inspect(c, label: "NT")
    IO.inspect(d, label: "NT")
    IO.inspect(e, label: "NT")
    IO.inspect(f, label: "T")
    IO.inspect(g, label: "T")

  end

  def parse_and_remove(token_list, atom) do
      #mostrar lista antes de remover elemento
      IO.inspect(token_list);
      ##si él atomo o tupla de constante coincide con el primer elemento de la lista...
      if_found = List.first(token_list) == atom;
      if if_found do #true si lo encontró, entonces lo elimina de la lista
        IO.inspect(List.first(token_list), label: "Se encontró token, extraer a una variable para el AST: ")
        #Devolver la lista actualizada y el elemento del AST en una tupla
        {list, ast_elem} = {List.delete(token_list, atom), List.first(token_list)} ##último valor regresado por la función
      else
        IO.puts("Cadena inválida, finaliza el parseo");
      end
  end

end
