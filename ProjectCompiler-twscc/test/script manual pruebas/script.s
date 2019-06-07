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


Suite manual de pruebas, semana 2

clear && cat test/add.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -a test/add.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -s test/add.c && printf "\n*********************************************\n" &&
cat test/add.s && printf "\n*********************************************\n" &&
./twscc_compilador_c test/add.c &&
./test/add; echo $?

clear && cat test/associativity.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -a test/associativity.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -s test/associativity.c && printf "\n*********************************************\n" &&
cat test/associativity.s && printf "\n*********************************************\n" &&
./twscc_compilador_c test/associativity.c &&
./test/associativity; echo $?


clear && cat test/associativity_2.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -a test/associativity_2.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -s test/associativity_2.c && printf "\n*********************************************\n" &&
cat test/associativity_2.s && printf "\n*********************************************\n" &&
./twscc_compilador_c test/associativity_2.c &&
./test/associativity_2; echo $?


clear && cat test/div.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -a test/div.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -s test/div.c && printf "\n*********************************************\n" &&
cat test/div.s && printf "\n*********************************************\n" &&
./twscc_compilador_c test/div.c &&
./test/div; echo $?

clear && cat test/mult.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -a test/mult.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -s test/mult.c && printf "\n*********************************************\n" &&
cat test/mult.s && printf "\n*********************************************\n" &&
./twscc_compilador_c test/mult.c &&
./test/mult; echo $?

clear && cat test/parens.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -a test/parens.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -s test/parens.c && printf "\n*********************************************\n" &&
cat test/parens.s && printf "\n*********************************************\n" &&
./twscc_compilador_c test/parens.c &&
./test/parens; echo $?

clear && cat test/precedence.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -a test/precedence.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -s test/precedence.c && printf "\n*********************************************\n" &&
cat test/precedence.s && printf "\n*********************************************\n" &&
./twscc_compilador_c test/precedence.c &&
./test/precedence; echo $?

clear && cat test/sub.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -a test/sub.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -s test/sub.c && printf "\n*********************************************\n" &&
cat test/sub.s && printf "\n*********************************************\n" &&
./twscc_compilador_c test/sub.c &&
./test/sub; echo $?

clear && cat test/sub_neg.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -a test/sub_neg.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -s test/sub_neg.c && printf "\n*********************************************\n" &&
cat test/sub_neg.s && printf "\n*********************************************\n" &&
./twscc_compilador_c test/sub_neg.c &&
./test/sub_neg; echo $?

clear && cat test/unop_add.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -a test/unop_add.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -s test/unop_add.c && printf "\n*********************************************\n" &&
cat test/unop_add.s && printf "\n*********************************************\n" &&
./twscc_compilador_c test/unop_add.c &&
./test/unop_add; echo $?

clear && cat test/unop_parens.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -a test/unop_parens.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -s test/unop_parens.c && printf "\n*********************************************\n" &&
cat test/unop_parens.s && printf "\n*********************************************\n" &&
./twscc_compilador_c test/unop_parens.c &&
./test/unop_parens; echo $?

#INVÁLIDAS

clear && cat test/malformed_paren.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -a test/malformed_paren.c


clear && cat test/missing_first_op.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -a test/missing_first_op.c

clear && cat test/missing_second_op.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -a test/missing_second_op.c

clear && cat test/no_semicolon.c && printf "\n*********************************************\n" &&
./twscc_compilador_c -a test/no_semicolon.c
