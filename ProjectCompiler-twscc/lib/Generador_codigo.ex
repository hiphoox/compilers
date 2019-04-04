defmodule Generador_codigo do

  def assembly(ast) do
        IO.puts(postorden(ast, ""))
        :ok
  end

  def assembly(ast, file_address) do

    #llama a la funcion que recorre en post orden y devuelve el código
    code = postorden(ast, "")
    #IO.inspect(code)
    IO.puts("\n")
    #IO.inspect(code)
    ruta_ensamblador=genera_ruta_ensamblador(file_address);
    IO.inspect(ruta_ensamblador, label: "Ensamblador generado");
    genera_archivo_ensamblador(code, ruta_ensamblador);
    ruta_ensamblador
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
    .p2align        4, 0x90
    """ <> codigo #concatena esto antes del codigo
  end

  def codigo_gen(:function, _, codigo) do
    """
      .globl  main         ## -- Begin function main
  main:                    ## @main
  """ <> codigo #concatena esto antes del codigo
  end

  def codigo_gen(:constant, value, _) do
    "$#{value}" #guarda el valor de la constate
  end
  ##pega el valor de la constante y añade una instruccion return
  def codigo_gen(:return_Keyword, _, codigo) do
    """
        movl    #{codigo}, %eax
        ret
    """
  end

  def genera_ruta_ensamblador (file_adress) do
    if file_adress =~ ".c" do
    String.replace_trailing(file_adress, ".c", ".s");#se cambiará la extención del archivo en la ruta especificada
    else
      numero=String.length(file_adress);
     String.pad_trailing(file_adress, numero+2 ,".s");
    end
    #  String.replace_trailing(file_adress, ".c", ".s");#se cambiará la extención del archivo en la ruta especificada
  end

  def genera_archivo_ensamblador(code,ruta_ensamblador) do
    #  ensamblador_archivo = Path.basename(ruta_ensamblador)##Returns the last component of the path or the path itself if it does not contain any directory separators
      File.write!(ruta_ensamblador, code)
  end
end
