defmodule Linker do
  def generate_binary(assembler, assembly_path) do
    IO.puts("primero")
    IO.inspect(assembly_path)
    assembly_file_name = Path.basename(assembly_path)
    binary_file_name = Path.basename(assembly_path, ".s")
    output_dir_name = Path.dirname(assembly_path)
    assembly_path = output_dir_name <> "/" <> assembly_file_name
    IO.puts("segundo")
    IO.inspect(assembly_file_name)
    IO.puts("tercero")
    IO.inspect(binary_file_name)
    IO.puts("cuarta")
    IO.inspect(output_dir_name)
    IO.puts("quinta")
    IO.inspect(assembly_path)

    File.write!(assembly_path, assembler)
    System.cmd("gcc", [assembly_file_name, "-o#{binary_file_name}"], cd: output_dir_name)
    IO.puts("sexta")
    IO.inspect(assembly_file_name)
    IO.puts("sep")
    IO.inspect(binary_file_name)
    IO.puts("oct")
    IO.inspect(output_dir_name)
    File.rm!(assembly_path)
  end

end
