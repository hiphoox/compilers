defmodule Generador_codigo do

  def assembly(ast, flag, path) do
    asm_string = postorden(ast, "")
    #Según la bandera, escribe ensamblador en disco o continua hacia el linker para generar ejecutable
    if flag == :gen_asm, do: genera_archivo(asm_string, path), else: {:ok, asm_string}
  end
  #sin hijos el nodo
  defp postorden({}, code), do: code;
  #nodo con hijos

  #Búsqueda en postorden (izquierda, derecha y arriba)
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
    """
        movl    $#{value}, %eax
    """
  end

  ##pega el valor de la constante y añade una instruccion return
  def codigo_gen(:return_Keyword, _, codigo) do
    codigo <> """
        ret
    """
  end

  def codigo_gen(:negation_Keyword, _, codigo) do
    codigo <> """
        neg     %eax
    """
  end

  def genera_archivo(code,path) do
    asm_path = String.replace_trailing(path, ".c", ".s")
    File.write!((asm_path), code)
    {:only_asm, "Archivo ensamblador generado correctamente en la ruta: " <> asm_path}
  end

end
