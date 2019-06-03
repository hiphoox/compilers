Suite manual de pruebas, semana 2

#VÁLIDAS

clear && cat test/bitewise_zero.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -a test/bitewise_zero.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -s test/bitewise_zero.c && printf "\n*********************************************\n" &&
cat test/bitewise_zero.s && printf "\n*********************************************\n" &&
./twscc_compilador_c test/bitewise_zero.c &&
./test/bitewise_zero; echo $?

clear && cat test/neg.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -a test/neg.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -s test/neg.c && printf "\n*********************************************\n" &&
cat test/neg.s && printf "\n*********************************************\n" &&
./twscc_compilador_c test/neg.c &&
./test/neg; echo $?

clear && cat test/nested_ops.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -a test/nested_ops.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -s test/nested_ops.c && printf "\n*********************************************\n" &&
cat test/nested_ops.s && printf "\n*********************************************\n" &&
./twscc_compilador_c test/nested_ops.c &&
./test/nested_ops; echo $?

clear && cat test/nested_ops_2.c  && printf "\n*********************************************\n" &&
./twscc_compilador_c -a test/nested_ops_2.c  && printf "\n*********************************************\n" &&
./twscc_compilador_c -s test/nested_ops_2.c  && printf "\n*********************************************\n" &&
cat test/nested_ops_2.s && printf "\n*********************************************\n" &&
./twscc_compilador_c test/nested_ops_2.c &&
./test/nested_ops_2; echo $?

clear && cat test/not_twelve.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -a test/not_twelve.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -s test/not_twelve.c && printf "\n*********************************************\n" &&
cat test/not_twelve.s && printf "\n*********************************************\n" &&
./twscc_compilador_c test/not_twelve.c &&
./test/not_twelve; echo $?

clear && cat test/not_zero.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -a test/not_zero.c  && printf "\n*********************************************\n" &&
./twscc_compilador_c -s test/not_zero.c && printf "\n*********************************************\n" &&
cat test/not_zero.s && printf "\n*********************************************\n" &&
./twscc_compilador_c test/not_zero.c &&
./test/not_zero; echo $?

#INVÁLIDAS
clear && cat test/missing_const.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -a test/missing_const.c

clear && cat test/missing_semicolon.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -a test/missing_semicolon.c

clear && cat test/nested_missing_const.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -a test/nested_missing_const.c

clear && cat test/wrong_order.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -a test/wrong_order.c




