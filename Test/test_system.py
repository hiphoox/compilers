
import unittest
from file_clean import *
from lexer_module import * 


class test_system(unittest.TestCase):

    def test_lexer(self):
        i=0
        test_list = ['test.c','newlines.c','spaces.c'] # Agregar todos los archivos donde el lexer sea validos
        print('\n\t\t********** LEXER TESTS')
        while i < len(test_list):
            raw_text = read_file(test_list[i])
            print('\tFILE: '+test_list[i])
            self.assertTrue(bool(lexer(raw_text)))
            i=i+1
        print('\t\t\t\t\t\t'+str(len(test_list))+' Tests Were Successful\n')
    
    def test_lexer_invalid(self):
        i=0
        test_list = ['wrong_case.c'] # Agregar todos los archivos donde el lexer NO sea validos
        print('\n\t\t********** LEXER INVALID TESTS')
        while i < len(test_list):
            raw_text = read_file(test_list[i])
            print('\tFILE: '+test_list[i])
            self.assertEqual(lexer(raw_text), 'failed')
            i=i+1
        print('\n\t\t\t\t\t\t'+str(len(test_list))+' Tests Were Successful\n')



if __name__ == '__main__':
    unittest.main()
