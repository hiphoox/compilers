defmodule Generador_codigo do

  def assembly(ast, flag, path) do
    asm_string = postorden(ast, "")
    if flag == :gen_asm, do: genera_archivo(asm_string, path), else: {:ok, asm_string}
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
        .globl  main         ## -- Begin function main
    main:                    ## @main
    """  <> codigo #concatena esto antes del codigo
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
  def genera_archivo(code,path) do
    File.write!(String.replace_trailing(path, ".c", ".s"), code)
    {:only_asm,"Archivo ensamblador generado correctamente"}
  end

end
