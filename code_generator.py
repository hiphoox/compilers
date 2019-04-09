from treelib import Node, Tree


def generator(ast):
    return assembler_generator(ast)


def assembler_generator(ast):
    assembler = ""
    constant_leaves = ast.is_branch('expr')
    for leaf in constant_leaves:  # this for is going to be useful when we get more than one constant in the next part of the project
        if not ast.is_branch(leaf):
            assembler = expression_code(constant_code(ast.get_node(leaf).data))
    assembler = program_code() + function_code() + assembler
    return assembler


def program_code():
    code_snip = """    .section        __TEXT,__text,regular,pure_instructions
    .p2align        4, 0x90"""
    return code_snip


def function_code():
    code_snip = """
    .globl  _main         ## -- Begin function main
_main:                    ## @main
    """
    return code_snip


def expression_code(cte_snip):
    code_snip = "movl    " + cte_snip + ", %eax" + "\n" + "    ret"
    return code_snip


def constant_code(constant_value):
    code_snip = "$"+str(constant_value)
    return code_snip
