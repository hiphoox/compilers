  defmodule Lexer do

  def scan_word(string, flag) do
    #Realiza limpieza del código
    words = Saneador.fix_format(string)
    case words do
      [""] -> {:error, "Código fuente vacío, nada por procesar"}
        _ ->  start_lexing(words, flag) #sino, comienza a generar tokens
        #IO.inspect(a)
    end
    #deberá devolver la lista de tokens
  end


  def start_lexing(words, flag) do
    #IO.inspect(words)
    #token_list = lex_raw_tokens(List.first(words))
    token_list = Enum.flat_map(words, &lex_raw_tokens/1)
    #IO.inspect(token_list)
    #s hubo error en la sintaxis, debe de haber un token llamado ":error".
    if Enum.member?(token_list, :error) do
      #Si dicho token no existe, entonces devuelve tupla de error
      {:error, "LEXER ERROR"}
    else
      #revisa la bandera para mostrar o no en pantalla la lista de tokens
       if flag == :show_token do
        IO.inspect(token_list)
         {:only_tokens, token_list}
       else
         {:ok, token_list}
       end
     end
  end


  def lex_raw_tokens(program) when program != "" do #Búsqueda de patrones en la cadena de código
    {token, cadena_restante} =
    case program do
        "{" <> cadena_restante -> {:open_brace, cadena_restante}
        "}" <> cadena_restante -> {:close_brace, cadena_restante}
        "(" <> cadena_restante -> {:open_paren, cadena_restante}
        ")" <> cadena_restante -> {:close_paren, cadena_restante}
        ";" <> cadena_restante -> {:semicolon, cadena_restante}
        "return" <> cadena_restante -> {:return_Keyword, cadena_restante}
        "int" <> cadena_restante -> {:int_Keyword, cadena_restante}
        "main" <> cadena_restante -> {:main_Keyword, cadena_restante}


        #Si no hubo ninguna coincidencia, inserta la cadena error
        #si se encontró un error, guarda en cadena restante {:error, motivo}
        cadena_restante -> get_constant_chk_error(cadena_restante)
        end

        #var es {tokens, cadena_restante}
        tokens_restantes = lex_raw_tokens(cadena_restante)
        [token | tokens_restantes]

        #tokens_restantes = lex_raw_tokens(cadena_restante)
        #[token | tokens_restantes]
  end

    def lex_raw_tokens(_program) do
      []
    end

  def get_constant_chk_error(remain_string) do
    #Constante o cadena inválida, procesar
    if Regex.run(~r/-?\d+/, remain_string) != nil do
        case Regex.run(~r/\d+/, remain_string) do
           [valor] -> a = {{:constant, String.to_integer(valor)}, String.trim_leading(remain_string, valor)}
        end
      else #Si no fue una constante, fue un error en el código. guardalo
          IO.inspect(remain_string, label: "Error léxico en" )
          {:error, ""}
      end
    end
end
