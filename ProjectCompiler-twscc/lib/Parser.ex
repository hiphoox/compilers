defmodule Parser do
  def parsero(token_list) do
   #llamada a creación de la gramática para el AST, debería devolver un árbol. Actualmente regresa "nil"
   ast_tree = parse_program(token_list);
 end
end
