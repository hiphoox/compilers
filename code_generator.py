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
    #print (ast) #for debug purposes
    gen = ast.expand_tree(nid = 'func', mode = 1, filter = None, key = None, reverse = False, sorting = False)
    tree_traversed = (list(gen))
    tree_traversed.reverse()
    #print(tree_traversed) #for debug purposes
    for index, node in enumerate(tree_traversed):
        if 'logical_negation' == ast.get_node(node).tag:
            assembler += logic_neg()
        elif 'bitwise_complement' in ast.get_node(node).tag:
            assembler += bitewise_code()
        elif 'negation' == ast.get_node(node).tag:
            assembler += negation_code()
        elif 'Constant' in ast.get_node(node).tag:
            #if('Constant' in ast.get_node(tree_traversed[index-1]).tag):
            #    assembler += push_code()
            assembler += expression_code(constant_code(ast.get_node(node).tag.split(":")[1])) + push_code()
        elif 'addition_bin' == ast.get_node(node).tag:
            assembler += addi_code()
        elif 'negation_bin' == ast.get_node(node).tag:
            assembler += subs_code()
        elif 'multiplication' == ast.get_node(node).tag:
            assembler += multi_code()
        elif 'division' == ast.get_node(node).tag:
            assembler += divi_code()


    # nodeid = 'func'
    # while(ast.is_branch(nodeid)):
    #     nodeid = ast.is_branch(nodeid)[0]
    #     assembler_list.append(ast.get_node(nodeid).tag)
    # assembler_list.pop(0)
    # print(assembler_list)
    # for node in reversed(assembler_list):
    #     if 'logical_negation' == node:
    #         assembler += logic_neg()
    #     if 'bitwise_complement' in node:
    #         assembler += bitewise_code()
    #     if 'negation' == node:
    #         assembler += negation_code()
    #     if 'Constant' in node:
    #         assembler += expression_code(constant_code(node.split(":")[1]))
    #print(assembler_list) #for debug purposes
    assembler = program_code() + function_code() + assembler + return_code()
    assembler = rreplace(assembler, 'push   %rax', ' ', 1)
    #print(assembler) #for debug purposes

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

def push_code():
    code_snip = """
    push   %rax
    """
    return code_snip

def addi_code():
    code_snip = """
    pop    %rcx
    pop    %rcx
    addl   %ecx, %eax
    push   %rax
    """
    return code_snip

def multi_code():
    code_snip = """
    pop    %rcx
    pop    %rcx
    imul   %ecx, %eax
    push   %rax
    """
    return code_snip

def subs_code():
    code_snip = """
    pop    %rcx
    pop    %rcx
    subl   %ecx, %eax
    push   %rax
    """
    return code_snip

def divi_code():
    code_snip = """
    pop    %rax
    pop    %rcx
    xor    %edx, %edx
    idivl  %ecx
    push   %rax
    """
    return code_snip


def logic_neg():
    code_snip ="""
        cmpl    $0, %eax
        movl    $0, %eax
        sete    %al
    """
    return code_snip

def rreplace(s, old, new, occurrence):
    li = s.rsplit(old, occurrence)
    return new.join(li)
