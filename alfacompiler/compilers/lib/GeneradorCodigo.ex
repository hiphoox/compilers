defmodule CodeGenerator do
  def generate_code(ast) do
<<<<<<< HEAD
    code = post_order(ast)
    code
=======
   post_order(ast)

>>>>>>> bd67264b7d0db0346ce3f2a8e5d9ba9cb2d459d1
  end

  def post_order(node) do
    case node do
<<<<<<< HEAD


=======
>>>>>>> bd67264b7d0db0346ce3f2a8e5d9ba9cb2d459d1
      nil ->
        nil

      ast_node ->
        code_snippet = post_order(ast_node.left_node)
        post_order(ast_node.right_node)
        emit_code(ast_node.node_name, code_snippet, ast_node.value)
    end
  end

  def emit_code(:program, code_snippet, _) do
    """
<<<<<<< HEAD
        .section
        .p2align        4, 0x90
=======
>>>>>>> bd67264b7d0db0346ce3f2a8e5d9ba9cb2d459d1
    """ <>
      code_snippet
  end

  def emit_code(:function, code_snippet, :main) do
    """
	       .globl	main
    main:
    """ <>
      code_snippet
  end

  def emit_code(:return, code_snippet, _) do
    code_snippet<>
    """
        ret
    """
  end
  def emit_code(:negation, code_snippet, _) do
    code_snippet<>
    """
        neg	%eax
    """
  end
  def emit_code(:complement, code_snippet, _) do
    code_snippet<>
    """
        not	%eax
    """
  end
  def emit_code(:logical, code_snippet, _) do
    code_snippet<>
    """
    cmpl     $0, %eax
    movl     $0, %eax
    sete     %al
    """
  end

  def emit_code(:unary_negative, code_snippet, _) do
    code_snippet<>
    """
        neg	%eax
    """
  end

  def emit_code(:unary_complement, code_snippet, _) do
    code_snippet<>
    """
        not	%eax
    """
  end

  def emit_code(:negative_logical, code_snippet, _) do
    code_snippet<>
    """
    cmpl     $0, %eax
    movl     $0, %eax
    sete     %al
    """
  end

  def emit_code(:constant, _code_snippet, value) do
    """
        movl	$#{value}, %eax
    """
  end
end