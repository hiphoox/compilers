##Aquí va el test del parser
##:error, cadena 
#setup_all do
#    {:error, "error clsoe brasse missed"}
#end

###Prototipo de pruebas para parserS
#test "pribando " state do
#    assert "int main(){return 0;"
#    |> Sanitizer
#    |> Lexer.scan_words
#    |> Parser.parse_program
#    {:error, "Error, close falta llave"}
#end