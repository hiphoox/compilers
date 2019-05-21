Suite manual de pruebas, semana 2

#VÁLIDAS
cat test/bitewise_zero.c
./twscc_compilador_c -a test/bitewise_zero.c
./twscc_compilador_c -s test/bitewise_zero.c
nano test/bitewise_zero.s

cat test/neg.c
./twscc_compilador_c -a test/neg.c
./twscc_compilador_c -s test/neg.c
nano test/neg.s

cat test/nested_ops.c
./twscc_compilador_c -a test/nested_ops.c
./twscc_compilador_c -s test/nested_ops.c
nano test/nested_ops.s

cat test/nested_ops_2.c
./twscc_compilador_c -a test/nested_ops_2.c
./twscc_compilador_c -s test/nested_ops_2.c
nano test/nested_ops_2.s

cat test/not_twelve.c
./twscc_compilador_c -a test/not_twelve.c
./twscc_compilador_c -s test/not_twelve.c
nano test/not_twelve.s

cat test/not_zero.c
./twscc_compilador_c -a test/not_zero.c
./twscc_compilador_c -s test/not_zero.c
nano test/not_zero.s

#INVÁLIDAS
./twscc_compilador_c -a test/missing_const.c
./twscc_compilador_c -a test/missing_semicolon.c
./twscc_compilador_c -a test/nested_missing_const.c
./twscc_compilador_c -a test/wrong_order.c




