# Nqcc

**This is a nice small C subset compiler implemented in Elixir.**

## Installation

1. git clone https://github.com/hiphoox/qncc.git
2. cd qncc
3. mix escript.build

## Using

- ./nqcc file_name.c
- ./nqcc --help
- ./nqcc --t file_name.c
- ./nqcc --a file_name.c
- ./nqcc --o name_new file_name.c
- ./nqcc --s file_name.c

## Examples
- $ ./nqcc  examples/return_2.c
- $ ./nqcc --t examples/return_2.c
- $ ./nqcc --a examples/return_2.c
- $ ./nqcc --o new examples/return_2.c
- $ ./nqcc --s examples/return_2.c
