defmodule Proyecto_compilador do
  @moduledoc """
  Documentacion for proyecto_compilador.
  """
  
  ##para compilar mix escript.build
  #ejecuta ./proyecto_compilador

  def main(_args) do ##no te quejes compilador
  
    ##marzo 5, 2019
    
    IO.puts("Holi! a compilar!");
    file_content=  File.read!("/home/eriq/Documentos/Procesos_UNIX/ejercicio1.c"); ##lectura del archivo
    IO.inspect(file_content);
    ##dar por hecho que el codigo viene mal
    ##hacer un modulo de saneamiento de los datos
    ##validar ciertas cosas(si es un codigo fuente c, si no está corrupto, etc)
    ##reportar que algo está mal antes de procesarlo
    trimmed_content =  String.trim(file_content); ##borrara los saltos de linea antes y despues
    IO.inspect(trimmed_content);
    ##leer los tokens. Los numeros hacerles cast de String "2" a int 2
    ##Keyword, INT, simbolo_Especial, etc... (etiquetas)
    ##Implementar un autómata finito (AFD) usando expresiones regulares. Elixir ya tiene expresiones regulares
    ##\s+ --> haz match con un espacio y saltos de linea desde 1 hasta los que encuentre
    ##definicion de una expresion regular ~r/"expresion regular"/
    words = Regex.split(~r/\s+/, trimmed_content);
    IO.inspect(words);
    
    tokens_separados =  scan_word(words);
    IO.inspect(tokens_separados);
    
    #DICHA LISTA DE SALIDA YA SALDRÁ EN ORDEN PARA CONSTRUIR 
    
    ##ver todos los casos posibles para dividir, probando por ejemplo todo el codigo en el mismo renglon
    #"main(){return" buscar los tokens a identifiar (palabras reservadas: main, (, ), {, }, return, etc..)
    ##utilizar atomos para etiquetas (:main, :return) por ejemplo, la tupla del 2 {:integer, 2}
    ## para main: {:keyword o id, "main"} 
 
  end
  
  
  def scan_word(words) do
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
  
  
  ##7 marzo 19
    #Crear funcion que reciba la cadena y partirla reconociendo los tokens y devolverá una lista de tokens [{a, b}, {c, d}]
    
    ##implementar algoritmo, tomando en cuenta las tuplas simples o dobles, 
  ##crear funcion que recibe un "programa" (la cadena words)
  
  #ejecutar con "iex -S mix" para poder ejecutar la funcion
  
  #HACERLO RECURSIVO y romperlo mientras program no esté vacía
  def lex_raw_tokens(program) when program != "" do #compara la cadena para ver que caso cumple
  
     
    #lo que devuela el case, haz pattern matching contra esto para recuperarlo...
    {token, cadena_restante} =
    case program do #case de la cadena
    
                            ##-> si "program" hace match contra el caso, ejecuta... {} (devuelve la tupla)
        "{" <> cadena_restante -> {:open_brace, cadena_restante} #hará pattern maching contra "{" revisando que la cadena empiece con llave y todo lo demás lo guarda en "rest". Esto ya genera el tokens (devuelve la tupla de dos elementos)
        
        "}" <> cadena_restante -> {:close_brace, cadena_restante}
        
        "(" <> cadena_restante -> {:open_paren, cadena_restante}
        
        ")" <> cadena_restante -> {:close_paren, cadena_restante}
        
        ";" <> cadena_restante -> {:semicolon, cadena_restante}
        
        "return" <> cadena_restante -> {:return_Keyword, cadena_restante}
        
        "int" <> cadena_restante -> {:int_Keyword, cadena_restante}
        
        "main" <> cadena_restante -> {:main_keyword, cadena_restante}
        
        #el DEFAULT del case
        cadena_restante -> get_constant(cadena_restante) #crea funcion y pasale la cadena que no cumplió con los casos anteriores
        end
        
    #devuelve recursirvamente la cadena_restante para seguir revisando
    #tokens_restantes es la cadena restante con los caracteres sin separar hasta que se vacíe
    tokens_restantes = lex_raw_tokens(cadena_restante) #añadir este token al final de la lista
    [token | tokens_restantes] ##agrega los tokens restantes AL FINAL DE la lista de token
    
  end
  
  def lex_raw_tokens(_program) do #debe haber otra funcion llamada igual para recibir la cadena vacia (en realidad cualquiera)
    [] ##para devolver una lista vacía
  end
  
  #salida final del "exer" iex(3)> Proyecto_compilador.lex_raw_tokens("main(){}")
  #[:main_keyword, :open_paren, :close_paren, :open_brace, :close_brace]

end
