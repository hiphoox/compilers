defmodule Lexer do
  def scan_word(file_content) do
  ##llamar al saneador, si no hay error devolverá las palabras sin saltos de linea en su totalidad
  words = Saneador.fix_code_format(file_content);

  #IO.puts("\nGenerando lista de tokens (LEXER)")
  Enum.flat_map(words, &lex_raw_tokens/1); ##(coleccion [lista], funcion) #va a iterar contra los elementos de la lista. por cada elemento iterado se lo pasa a la funcion

  #el /1 indica la cantidad de parámetros que recibe la funcion
  end

end
