defmodule Lexer do
  def scan_word(file_content) do
  ##llamar al saneador, si no hay error devolverá las palabras sin saltos de linea en su totalidad
  words = Saneador.fix_code_format(file_content);

  #IO.puts("\nGenerando lista de tokens (LEXER)")
  Enum.flat_map(words, &lex_raw_tokens/1); ##(coleccion [lista], funcion) #va a iterar contra los elementos de la lista. por cada elemento iterado se lo pasa a la funcion

  #el /1 indica la cantidad de parámetros que recibe la funcion
  end

  #identificar que es un numero (uno o varios)
def get_constant(program) do
  case Regex.run(~r/\d+/, program) do #recibe expresion regular con digito: Regex.run(~r/\d+/, "123213jjasdasdasd")["123213"]
    #pattern matching para extraer el valor de la lista que devuelve run
    #devuelve tupla con etiqueta {:constante, 1234}                       ##quita el valor numerico de cadena y devuelve el remanente
    [valor] -> {{:constant, String.to_integer(valor)}, String.trim_leading(program, valor)}
    end
end

end
