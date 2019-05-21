from treelib import Node, Tree


def generator(ast):
    return assembler_generator(ast)


def assembler_generator(ast):
    assembler_list = []
    assembler = ""
    #constant_leaves = ast.is_branch('expr')
    #for leaf in constant_leaves:  # this for is going to be useful when we get more than one constant in the next part of the project
    #    if not ast.is_branch(leaf):
    #        assembler = expression_code(constant_code(ast.get_node(leaf).data))
    #
    nodeid = 'func'
    while(ast.is_branch(nodeid)):
        nodeid = ast.is_branch(nodeid)[0]
        assembler_list.append(ast.get_node(nodeid).tag)
    assembler_list.pop(0)
    for node in reversed(assembler_list):
        if 'logical_negation' == node:
            assembler += logic_neg()
        if 'bitwise_complement' in node:
            assembler += bitewise_code()
        if 'negation' == node:
            assembler += negation_code()
        if 'Constant' in node:
            assembler += expression_code(constant_code(node.split(":")[1]))
    #print(assembler_list)
    assembler = program_code() + function_code() + assembler + return_code()
    #print(assembler)
    return assembler


def program_code():
    code_snip = """    .section        __TEXT,__text,regular,pure_instructions
    .p2align        4, 0x90"""
    return code_snip


def function_code():
    code_snip = """
    .globl  _main         ## -- Begin function main
_main:                    ## @main"""
    return code_snip


def expression_code(cte_snip):
    code_snip = "\n    movl    " + cte_snip + ", %eax"
    return code_snip

def return_code():
    code_snip = "\n" +"    ret"
    return code_snip

def constant_code(constant_value):
    code_snip = "$"+str(constant_value)
    return code_snip

def bitewise_code():
    code_snip = "\n"+"    not    %eax"
    return code_snip

def negation_code():
    code_snip = """
    neg    %eax
        """
    return code_snip

def logic_neg():
    code_snip ="""
        cmpl    $0, %eax
        movl    $0, %eax
        sete    %al
    """
    return code_snip

