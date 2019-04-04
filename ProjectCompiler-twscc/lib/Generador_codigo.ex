defmodule Generador_codigo do

  def assembly(ast) do

    #IO.write "\nPostorden del AST\n"
    #llama a la funcion que recorre en post orden y devuelve el código
    code = postorden(ast, "")

  end
  #sin hijos el nodo
  defp postorden({}, code), do: code;
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
#funciones "sobreescritas"
  def codigo_gen(:program, _, codigo) do
    """
    .section        __TEXT,__text,regular,pure_instructions
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
    "$#{value}" #guarda el valor de la constate
  end
  ##pega el valor de la constante y añade una instruccion return
  def codigo_gen(:return_Keyword, _, codigo) do
    """
        movl    #{codigo}, %ax
        ret
    """
  end

end
