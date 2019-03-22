defmodule Saneador do
  ##dar por hecho que el codigo viene mal
  ##hacer un modulo de saneamiento de los datos
  ##validar ciertas cosas(si es un codigo fuente c, si no está corrupto, etc)
  ##reportar que algo está mal antes de procesarlo

  def fix_code_format(file_content) do
    ##COMENTARIO BUENO: Sirve para limpiar la cadena de entrada y remover saltos de línea.
    IO.puts("\nSaltos de línea (antes y despues del codigo) removidos (SANEADOR):");
    trimmed_content =  String.trim(file_content) ##borrara los saltos de linea antes y despues
    IO.inspect(trimmed_content);
    ##leer los tokens. Los numeros hacerles cast de String "2" a int 2
    ##Keyword, INT, simbolo_Especial, etc... (etiquetas)
    ##Implementar un autómata finito (AFD) usando expresiones regulares. Elixir ya tiene expresiones regulares
    ##\s+ --> haz match con un espacio y saltos de linea desde 1 hasta los que encuentre
    ##definicion de una expresion regular ~r/"expresion regular"/

    IO.puts("\nSaltos de línea dentro del ćodigo removidos:");
    words = Regex.split(~r/\s+/, trimmed_content);
    IO.inspect(words);

  end



end
