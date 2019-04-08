defmodule Sanitizer do
  def sanitize_source(file_content) do
    trimmed_content = String.trim(file_content)
     words =Regex.split(~r/\r\n/,trimmed_content)
     contador=0
   	hacer_lista(words,contador)
   	end
     def hacer_lista(program,linea) when program != []  do
   		    codigo_linea=hd program
   		    otras_lineas=tl program
   				lista_token_sin_num = Regex.split(~r/\s+/,codigo_linea, trim: true)
   				lista_token_con_num=Enum.flat_map(lista_token_sin_num, fn x -> [{x,linea}] end)
   		    linea=linea+1
   		    otrostokens=hacer_lista(otras_lineas,linea)
   		    lista_token_con_num ++ otrostokens
     end
     def hacer_lista(program,linea)  do
          []
     end

end
