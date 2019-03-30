defmodule Lexer do #separando el lexer del modulo principal, mueve funcion (refactoring)


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

        "main" <> cadena_restante -> {:main_Keyword, cadena_restante}

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
