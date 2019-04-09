defmodule Generador_codigo do

  def assembly(ast, _flag) do
    case ast do
      {:error, _} -> ast #devuelve el error y sigue propagando en en Linker
                 _-> postorden(ast, "")
                 #devuelve una cadena con codigo en ensamblador x86
    end
  end
  #sin hijos el nodo
  defp postorden({}, code), do: code;
  #nodo con hijos
  defp postorden({atomo, value, izquierda ,derecha }, code) do
    code = postorden(izquierda, code)
    code = postorden(derecha, code)
    #si ya no encuentra más hijos, extrae el valor, genera el código y concatenalo con "code"

    codigo_gen(atomo, value, code);
  end

#funciones "sobreescritas"
  def codigo_gen(:program, _, codigo) do
    """
    .p2align        4, 0x90
    """ <> codigo #concatena esto antes del codigo
  end

  def codigo_gen(:function, _, codigo) do
    """
      .globl  _main         ## -- Begin function main
  _main:                    ## @main
  """ <> codigo #concatena esto antes del codigo
  end

  def codigo_gen(:constant, value, _) do
    "$#{value}"
  end

  ##pega el valor de la constante y añade una instruccion return
  def codigo_gen(:return_Keyword, _, codigo) do
    """
        movl    #{codigo}, %eax
        ret
    """
  end

end
