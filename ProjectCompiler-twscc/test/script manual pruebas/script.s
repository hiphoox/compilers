Suite manual de pruebas, semana 2

#VÁLIDAS

clear && cat test/bitewise_zero.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -a test/bitewise_zero.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -s test/bitewise_zero.c && printf "\n*********************************************\n" &&
cat test/bitewise_zero.s

clear && cat test/neg.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -a test/neg.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -s test/neg.c && printf "\n*********************************************\n" &&
cat test/neg.s

clear && cat test/nested_ops.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -a test/nested_ops.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -s test/nested_ops.c && printf "\n*********************************************\n" &&
cat test/nested_ops.s

clear && cat test/nested_ops_2.c  && printf "\n*********************************************\n" &&
./twscc_compilador_c -a test/nested_ops_2.c  && printf "\n*********************************************\n" &&
./twscc_compilador_c -s test/nested_ops_2.c  && printf "\n*********************************************\n" &&
cat test/nested_ops_2.s

clear && cat test/not_twelve.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -a test/not_twelve.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -s test/not_twelve.c && printf "\n*********************************************\n" &&
cat test/not_twelve.s

clear && cat test/not_zero.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -a test/not_zero.c  && printf "\n*********************************************\n" &&
./twscc_compilador_c -s test/not_zero.c && printf "\n*********************************************\n" &&
cat test/not_zero.s

#INVÁLIDAS
clear && cat test/missing_const.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -a test/missing_const.c

clear && cat test/missing_semicolon.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -a test/missing_semicolon.c

clear && cat test/nested_missing_const.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -a test/nested_missing_const.c

clear && cat test/wrong_order.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -a test/wrong_order.c




