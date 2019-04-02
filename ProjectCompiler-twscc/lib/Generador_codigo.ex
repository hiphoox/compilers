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
  defp postorder({_atomo, value, izquierda ,derecha }, code) do
    code = postorder(izquierda, code)
    code = postorder(derecha, code) #devuelve un ok y continua
    #IO.puts(value)
    #IO.inspect(code)
    codigo_gen(value, code);
  end
end
