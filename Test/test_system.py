import sys 
sys.path.append("..")

import unittest
from file_clean import *
from lexer_module import * 
from parser_module import *


class test_system(unittest.TestCase):

    def test_lexer(self):
        i=0
        test_list = get_files('lex_si/')
        print('\n\t\t********** LEXER TESTS')
        while i < len(test_list):
            raw_text = read_file('lex_si/'+test_list[i])
            print('\tFILE: '+test_list[i])
            if (lexer(raw_text)=='failed'):
                self.assertNotEqual(lexer(raw_text), 'failed')
                i=i+1
            else:
                self.assertTrue(bool(lexer(raw_text)))
                i=i+1
        print('\t\t\t\t\t\t'+str(len(test_list))+' Tests Were Successful\n')
    
    def test_lexer_invalid(self):
        i=0
        test_list = get_files('lex_no/')
        print('\n\t\t********** LEXER INVALID TESTS')
        while i < len(test_list):
            raw_text = read_file('lex_no/'+test_list[i])
            print('\tFILE: '+test_list[i])
            self.assertEqual(lexer(raw_text), 'failed')
            i=i+1
        print('\n\t\t\t\t\t\t'+str(len(test_list))+' Tests Were Successful\n')

    """def test_parser(self):
        i=0
        test_list = get_files('par_si/')
        print('\n\t\t********** PARSER TESTS')
        while i < len(test_list):
            raw_text = read_file('par_si/'+test_list[i])
            print('\tFILE: '+test_list[i])
            if (lexer(raw_text)=='failed'):
                self.assertNotEqual(lexer(raw_text), 'failed')
                i=i+1
            else:
                tokenList=lexer(raw_text)
                if (parser_f(tokenList)=='failed'):
                    self.assertNotEqual(parser_f(tokenList), 'failed')
                    i=i+1
                else:
                    self.assertNotEqual(parser_f(tokenList), 'failed')
                    i=i+1
        print('\t\t\t\t\t\t'+str(len(test_list))+' Tests Were Successful\n')

    def test_parser_invalid(self):
        i=0
        test_list = get_files('lex_si/')
        print('\n\t\t********** PARSER INVALID TESTS')
        while i < len(test_list):
            raw_text = read_file('lex_si/'+test_list[i])
            print('\tFILE: '+test_list[i])
            if (lexer(raw_text)=='failed'):
                self.assertNotEqual(lexer(raw_text), 'failed')
                i=i+1
            else:
                tokenList=lexer(raw_text)
                self.assertEqual(parser_f(tokenList), 'failed')
                i=i+1
        print('\t\t\t\t\t\t'+str(len(test_list))+' Tests Were Successful\n')"""



if __name__ == '__main__':
    unittest.main()
