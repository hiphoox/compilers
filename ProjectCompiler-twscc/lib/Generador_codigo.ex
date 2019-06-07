defmodule Generador_codigo do

  def assembly(ast, flag, path) do
    #obtener stack con el recorido en post-orden primero
    post_stack = postorden_recorrido(ast, [])
    IO.inspect(post_stack)
    #vuelve a recorrer pero con la lista del recorrido para revisar si sigue operacion binaria
    asm_string = postorden(ast, "", post_stack)
    #IO.puts(asm_string)
    #Según la bandera, escribe ensamblador en disco o continua hacia el linker para generar ejecutable
    if flag == :gen_asm, do: genera_archivo(asm_string, path), else: {:ok, asm_string}
  end
  #sin hijos el nodo

  defp postorden_recorrido({_, value, izquierda ,derecha }, l_rec) do
    l_rec = postorden_recorrido(izquierda, l_rec)
    l_rec = postorden_recorrido(derecha, l_rec)
    l_rec ++ [value]
  end

  defp postorden_recorrido({}, l_rec), do: l_rec;

  #Búsqueda en postorden (izquierda, derecha y arriba)
  defp postorden({atomo, value, izquierda ,derecha }, code, post_stack) do
    [code, post_stack] = postorden(izquierda, code, post_stack)
    [code, post_stack] = postorden(derecha, code, post_stack)
    #si ya no encuentra más hijos, extrae el valor, genera el código y concatenalo con "code"
    IO.puts(code)
    post_stack = Enum.drop(post_stack, 1)
    [codigo_gen(atomo, value, code, post_stack ), post_stack];
  end

  defp postorden({}, code, post_stack), do: [code, post_stack];

#funciones "sobreescritas"
  def codigo_gen(:program, _, codigo, _) do
    """
    .p2align        4, 0x90
    """ <> codigo #concatena esto antes del codigo
  end

  def codigo_gen(:function, _, codigo, _) do
    """
        .globl  main         ## -- Begin function main
    main:                    ## @main
    """  <> codigo #concatena esto antes del codigo
  end

  def codigo_gen(:constant, value, codigo, post_stack) do
      #IO.puts("OP bin detected")
    if List.first(post_stack) == "+" or List.first(post_stack) == "*" do
      IO.puts("OP bin detected")
      codigo <> """
          mov     $#{value}, %rax
      """
    else
      IO.inspect(value)
      codigo <> """
          mov     $#{value}, %rax
      """
    end

  end

  ##pega el valor de la constante y añade una instruccion return
  def codigo_gen(:return_Keyword, _, codigo, _) do
    codigo <> """
        ret
    """
  end

  def codigo_gen(:negation_Keyword, _, codigo, _) do
    codigo <> """
        neg     %rax
    """
  end

  def codigo_gen(:bitewise_Keyword, _, codigo, _) do
    codigo <> """
        not     %rax
    """
  end

  def codigo_gen(:logicalNeg_Keyword, _, codigo, _) do
    codigo <> """
        cmp     $0, %rax
        mov     $0, %rax
        sete     %al
    """
  end

  def codigo_gen(:addition_Keyword, _, codigo, _) do
    #IO.puts(codigo)
    #almacenar el primer operando usando un push a %eax
    codigo <> """
        pop      %rcx
        add      %rcx, %rax
    """
 end

 def codigo_gen(:multiplication_Keyword, _, codigo, _) do
   #IO.puts(codigo)
   #almacenar el primer operando usando un push a %eax
   codigo <> """
       pop       %rcx
       imul      %rcx, %rax
       push      %rax
   """
end

def codigo_gen(:division_Keyword, _, codigo, _) do
  #IO.puts(codigo)
  #almacenar el primer operando usando un push a %eax
  codigo <> """
     pop         %ecx
     div         %ecx
  """
end


  def genera_archivo(code,path) do
    asm_path = String.replace_trailing(path, ".c", ".s")
    File.write!((asm_path), code)
    {:only_asm, "Archivo ensamblador generado correctamente en la ruta: " <> asm_path}
  end

end
