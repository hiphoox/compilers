defmodule Generador_codigo do

  def assembly(ast) do

        #IO.write "\nPostorden del AST\n"
        #llama a la funcion que recorre en post orden y devuelve el código
        code = postorden(ast, "")

  end
  #sin hijos el nodo
  defp postorder({}, code), do: code;
  #nodo con hijos
  defp postorden({atomo, value, izquierda ,derecha }, code) do
    #recursividad, revisa {:node, data, {izquierda}, {}}
    code = postorden(izquierda, code)
    #recursividad, revisa {:node, data, {}, {derecha}}
    code = postorden(derecha, code)
    #si ya no encuentra más hijos, extrae el valor, genera el código y concatenalo con "code"
    #IO.inspect(value, label: "Dato obtenido")
    codigo_gen(atomo, value, code);
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
