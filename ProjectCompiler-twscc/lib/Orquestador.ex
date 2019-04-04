defmodule Orquestador do

  def manager(arg, file_adress) do

    file_content=  File.read!(file_adress); ##lectura del archivo

    tokens_separados =  Lexer.scan_word(file_content);
    if arg == "--tokens" or "-t" do
          IO.inspect(tokens_separados);
    else
    end

    ast = Parser.parsero(tokens_separados);
    if arg == "--ast" or "-a" do
          IO.inspect(ast);
          IO.puts(ast);
        else
        end
    ensamblador=Generador_codigo.assembly(ast);
    if arg == "--S" do

    else end

  end

end
