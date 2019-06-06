# nqcc: Compis

nqcc is a compiler for the following subset of C language:

```c
int main()
{
	return 2;
}
```

## Getting Started

To clone the repository:

```
$ git clone --single-branch --branch compis https://github.com/hiphoox/compilers2019_2.git
```

### Prerequisites

The compiler is designed to run in Unix operating systems (tested with OSX 10.11.4) using Python 3.6.5

Install treelib

```
pip3 install treelib
```

### Usage

```
python3 compiler.py c_file_name [-h] [-o output_name] [-s | -t | -a] 
```

### Example

```
python3 compiler.py test.c -o example.o 
```

## Running the tests

```
You must enter to the folder "Test" then:

python3 test_compiler.py
```

## Built With

* [Python3](https://www.python.org/download/releases/3.0/) 
* [Treelib](https://github.com/caesar0301/treelib) - Tree module

## Authors

* **Luis Miramontes** - *System architect* - [Tenkoni](https://github.com/Tenkoni)
* **Fernando Bustamante** - *System integrator* - [Farlan11](https://github.com/Farlan11)
* **Antonio Molina** - *Project Manager* - [marmolinaa](https://github.com/marmolinaa)
* **Sergio López** - *System tester* - [sergioulises](https://github.com/sergioulises)



## Acknowledgments

* [Norberto Ortigoza](https://github.com/hiphoox) for the high quality course and theorical concepts.

