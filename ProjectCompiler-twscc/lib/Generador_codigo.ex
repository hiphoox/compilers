defmodule Generador_codigo do

  def assembly(ast) do

        #f = fn x -> IO.write "#{x} " end
        IO.write "\npostorder:  "

        code = postorder(ast, "")
        IO.puts("\n")
        IO.puts(code)

  end ##termina funcion post_order_arbol
  #sin hijos el nodo
  defp postorder({}, code), do: code;
  #nodo con hijos
end
