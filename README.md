![elixir](tecnologia-elixir.jpg)



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


  - Las instrucciones de instalación para cada sistema operativo pueden ser encontradas en [Elixir-lang.org](http://elixir-lang.org/) en la guía [Installing Elixir](http://elixir-lang.org/install.html)(en inglés).
  
  - La version actual del lpncc se encuentra diseñada para el funcionar en sistemas UNIX.

    La version con la que se trabajo es la 1.8 para verificar su version teclee en una terminal.

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

3. Cambiarse a la carpeta del repositorio. 

   ```bash
   $ cd lpncc 
   
   ```

4. Ejecución

   ```bash
   $ mix escript.build 
   ```
   

   ## USO 
   
   El software soporta la modalidad de uso de banderas. Dentro del comando help explca el uso de cada una de ellas.
   
   ```bash
   $ ./lpncc  [--help | --o | --s | --a | --t ]  "/rutaDeArchivo/archivo.c"
   
   ```

   ## Ejemplo

   ```bash
   $ ./lpncc ./Pruebas/return_2.c 
   ```

   ```bash
   $ ./lpncc --a ./Pruebas/return_2.c 
   ```

   ```bash
   $  ./lpncc --t ./Pruebas/return_2.c 
   ```

   

