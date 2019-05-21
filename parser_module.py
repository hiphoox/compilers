# encoding: utf-8
from treelib import Node, Tree
import random

def parser_f(token_list):
    ast_list = []
    function_parser(token_list, ast_list)
    ast = Tree()
    ast.create_node('Program', 'prog')  # to create the first node of the AST
    # añadir a AST (program  hijo -> function)
    if token_list:
        raise SystemExit("Syntax error: There are more elements after the function end.")

    #print(ast_list) #debug purposes
    # # to create the rest of the nodes of the tree from the list
    for index, leaf in enumerate(ast_list):
        if 'negation' in leaf[0] or "bitwise_complement" in leaf[0] or "logical_negation" in leaf[0]:
            ast.create_node(leaf[0], leaf[1], parent = ast_list[index-1][1], data = leaf[2])
        if 'Constant' in leaf[0]:
            ast.create_node(leaf[0], leaf[1], parent = ast_list[index-1][1], data=leaf[2][1])
        if 'Expression' in leaf[0]:
            ast.create_node(leaf[0], leaf[1], parent='func', data=leaf[2])
        if 'Function' in leaf[0]:
            ast.create_node(leaf[0], 'func', parent='prog', data=leaf[2])
    return ast


def function_parser(token_list, ast_list):
    i = token_list.pop(0)
    if i != 'keyword_int':
        raise SystemExit("Syntax error, return type value missing. " +i+ " found instead of int")
    temporal_token = token_list.pop(0)
    ast_list.append(['Function:main', str(random.randint(1,10000)), temporal_token]) if temporal_token == 'keyword_main' else raiser( SystemExit("Syntax error, main function missing. "+ temporal_token+" found instead of 'main'"))
    i = token_list.pop(0)
    if i != 'parentheses_open':
        raise SystemExit("Syntax error, open parentheses missing. "+i+" found instead of '(' ")
    i = token_list.pop(0)
    if i != 'parentheses_close':
        raise SystemExit("Syntax error, close parentheses missing. "+i+ " found instead of ')' ")
    i = token_list.pop(0)
    if i != 'bracket_open':
        raiser(SystemExit("Syntax error, open bracket missing. "+i+ " found instead of '{'"))
    statement_parser(token_list, ast_list)
    i = token_list.pop(0)
    if i != 'bracket_close':
        raiser(SystemExit("Syntax error, close bracket missing. " + i + " found instead of '}'"))
    # añadir a AST (nombre -> function ; value -> main ; hijo-> statement), por el momento print será un placeholder


def statement_parser(token_list, ast_list):
    temporal_token = token_list.pop(0)
    if temporal_token == 'keyword_return':
        ast_list.append(['Expression:return', str(random.randint(1,10000)), temporal_token])
        expression_parser(token_list, ast_list) 
    else:
        raiser(SystemExit("Syntax error, return keyword missing. "+i+ " found instead of 'return'"))
    i = token_list.pop(0)
    if i != 'semicolon':
        raiser(SystemExit("Syntax error, semicolon missing after constant to finish return statment. " +i+ " found instead of ';'"))
    # añadir a AST (nombre -> return, hijo -> expresion), por el momento print será un placeholder


def expression_parser(token_list, ast_list):
    #temporal_token = token_list.pop(0)
    #if tuple == type(temporal_token):
    #    ast_list.append(['Constant:'+str(temporal_token[1]), 'const', temporal_token]) 
    #else:
    #    raiser(SystemExit("Syntax error, constant value missing."))
    term_parser(token_list, ast_list)
    t = token_list[0] if token_list else SystemExit("Parser ran out of tokens")
    while (t == "addition" or t == "negation"):
        ast_list.append([t, str(random.randint(1,10000)), t])
        token_list.pop(0)
        term_parser(token_list, ast_list)
        t = token_list[0] if token_list else SystemExit("Parser ran out of tokens")
    else:
        return


def term_parser(token_list, ast_list):
    factor_parser(token_list, ast_list)
    t = token_list[0] if token_list else SystemExit("Parser ran out of tokens")
    while (t == "multiplication" or t == "division"):
        ast_list.append([t, str(random.randint(1,10000)), t])
        token_list.pop(0)
        factor_parser(token_list, ast_list)
        t = token_list[0] if token_list else SystemExit("Parser ran out of tokens")
    else:
        return


def factor_parser(token_list, ast_list):
    t = token_list[0] if token_list else SystemExit("Parser ran out of tokens")
    if t == "parentheses_open":
        token_list.pop(0)
        expression_parser(token_list, ast_list)
        t = token_list[0] if token_list else SystemExit("Parser ran out of tokens")
        if t == "parentheses_close":
            token_list.pop(0)
            return
    if (t == "negation" or t == 'bitwise_complement' or t == 'logical_negation'):
        token_list.pop(0)
        ast_list.append([t, str(random.randint(1,10000)), t])
        factor_parser(token_list, ast_list)
        return

    if tuple == type(t):
        ast_list.append(['Constant:'+str(t[1]), str(random.randint(1,10000)), t])
        token_list.pop(0)
        return


# to raise exceptions as a single expression
def raiser(exception): raise exception
