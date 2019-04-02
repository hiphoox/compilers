defmodule Generador_codigo do

  def assembly(ast) do

    #f = fn x -> IO.write "#{x} " end
    IO.write "\npostorder:  "

    code = postorder(ast, "")
    IO.puts("\n")
    IO.puts(code)


  end
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

  def codigo_gen("program", codigo) do
    """
    .section        __TEXT,__text,regular,pure_instructions
    .p2align        4, 0x90
    """ <> codigo
  end

  def codigo_gen("main_Keyword", codigo) do
    """
      .globl  _main         ## -- Begin function main
  _main:                    ## @main
  """ <> codigo
  end

  def codigo_gen(8709, codigo) do
    "$#{8709}"
  end

  def codigo_gen("return", codigo) do
    """
        movl    #{codigo}, %eax
        ret
    """
  end



end
