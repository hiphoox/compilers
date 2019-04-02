![elixir](tecnologia-elixir.png)



# Compiler Lpncc

##### En este repositorio se creara un compilador de sublenguaje para C implementado en Elixir   para la clase de Compiladores. 

##### Integrantes del Equipo:  

Omar Orlando Ortega 
*Óscar Gutiérrez Castillo*
*Galileo Cabrera  Garibaldi*
*J.Alejandro Montecillo Sandoval*
*Francisco Javier Espinoza Jimez*

## Requerimientos 

- [ ] - Installar  elixir  

    ```
    dnf install elixir      [Fedora 22 (and newer)]
    
    ```

  - Las instrucciones de instalación para cada sistema operativo pueden ser encontradas en [Elixir-lang.org](http://elixir-lang.org/) en la guía [Installing Elixir](http://elixir-lang.org/install.html)(en inglés).

    La version con la que se trabajo es la 1.8 para verificar su version teclee en una terminal 

    ```
    $ elixir -v 
    Erlang/OTP 21.1 [erts-10.1] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]
    
    Elixir 1.8
    ```

    

## Instalación 

1. Copiar el repositorio : 

   ```bash
   $ git clone  https://github.com/hiphoox/compilers2019_2.git 
   $ cd compilers2019_2 
   ```

2. Para trabajar con la rama del proyecto  : 

   ```bash
   $ git checkout -b lpn 
   ```

3. Ejecución.

   ```bash
   $ mix escript.build 
   ```

   