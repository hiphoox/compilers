  defmodule Lexer do #separando el lexer del modulo principal, mueve funcion (refactoring)

  def scan_word(string, flag) do
    #Realiza limpieza del código
    words = Saneador.fix_format(string)
    case words do
      [""] -> {:error, "Código fuente vacío, nada por procesar"}
        _ ->  start_lexing(words, flag) #sino, comienza a generar tokens
    end
    #deberá devolver la lista de tokens
  end

  def start_lexing(words, flag) do
    token_list = Enum.flat_map(words, &lex_raw_tokens/1)
    #si hubo error en la sintaxis, debe de haber un token llamado ":error".
    if Enum.member?(token_list, :error) do
      #Si dicho token existe, entonces devuelve tupla de error
      {:error, "La sintaxis es inválida."}
    else
      #revisa la bandera para mostrar o no en pantalla la lista de tokens
       if flag == :show_token do
         IO.inspect(token_list)
         token_list;
       else
         token_list
       end
     end
  end

  #identificar que es un numero (uno o varios)
  def get_constant(program) do
      #puede leer enteros negativos, sin embargo el parser no los dejará pasar
        try do
        case Regex.run(~r/-?\d+/, program) do
          #verificar que no esté pegado el return con la constante
          [valor] -> if Regex.match?( ~r/(\s|^)-?\d+(?=\s|)/, program) do
                     {{:constant, String.to_integer(valor)}, String.trim_leading(program, valor)}
                    end
        end
      rescue
        CaseClauseError -> nil
      end
  end

  def lex_raw_tokens(program) when program != "" do #compara la cadena para ver que caso cumple
    try do
      {token, cadena_restante} =
      case program do #case de la cadena
          "{" <> cadena_restante -> {:open_brace, cadena_restante} #hará pattern maching contra "{" revisando que la cadena empiece con llave y todo lo demás lo guarda en "rest". Esto ya genera el tokens (devuelve la tupla de dos elementos)
          "}" <> cadena_restante -> {:close_brace, cadena_restante}
          "(" <> cadena_restante -> {:open_paren, cadena_restante}
          ")" <> cadena_restante -> {:close_paren, cadena_restante}
          ";" <> cadena_restante -> {:semicolon, cadena_restante}
          "return" <> cadena_restante -> {:return_Keyword, cadena_restante}
          "int" <> cadena_restante -> {:int_Keyword, cadena_restante}
          "main" <> cadena_restante -> {:main_Keyword, cadena_restante}

          cadena_restante -> get_constant(cadena_restante) #crea funcion y pasale la cadena que no cumplió con los casos anteriores
          end
    tokens_restantes = lex_raw_tokens(cadena_restante) #añadir este token al final de la lista
    [token | tokens_restantes] ##agrega los tokens restantes AL FINAL DE la lista de token
    rescue
      MatchError -> IO.inspect(program, label: "Error de sintaxis")
      spawn_link fn -> exit(1) end
    end
  end

  def lex_raw_tokens(_program) do
    [] ##para devolver una lista vacía
  end

end
