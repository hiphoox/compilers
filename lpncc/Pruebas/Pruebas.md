# Pruebas

En el siguiente documento se hará una breve explicación acerca del funcionamiento de las pruebas, para ello previamente se tiene que tener instalado Elixir y haber configurado el proyecto para poder correrlo apropiadamente, de no ser así se sugiere leer el archivo ***"README.md"***  el cual se encuentra al principio de este repositorio.

### Archivos de Prueba

Al ser un compilador de C, se usarán archivos del lenguaje de programación C. Estos archivos son  de manera especifica para poder correr las pruebas, estos se dividen en:

- **<u>Archivos Válidos:</u>** Aquellos archivos que contienen la sintaxis correcta y especifica para esta parte del proyecto, siendo archivos simples y modificados. Los cuales se detallan a continuación:

  - **Elementos Separados por saltos de línea**: Todos los elementos del lenguaje están separados por un salto de línea, es decirt en otro parrafo

    - ```c
      int 
      main
      (   
      )
      {
      return
      2
      ;
      }
      ```

  - **Ningún elemento tiene saltos de línea**: Todos los elementos del lenguaje llevan su debido espacio correspondiente a la sintaxis del lenguaje, sin embargo no llevan ningún salto de línea

    - ```c
      int main(){return 2;}
      ```

  - **Todos los elementos están separados por espacios**: Todos los elementos del lenguaje llevan su debido espacio correspondiente a la sintaxis del lenguaje, sin embargo estos se separa un poco más de lo normal

    - ```c
       int main ( ) { return 2 ; }
       ```

- <u>**Archivos no Válidos:**</u> Aquellos archivos contienen una sintaxis incorrecta o no son válidos para esta parte del proyecto, para este apartado es importante recalcar que **nuestro compilador sólo recibira como retorno un número "2" y dará como error si se le pone un número "0"**

  <u>***Correcto***</u>

   `return 2; `

  <u>***Incorrecto***</u>

  `return 0;`

  - **Falta de un parentesis en la función *main***: Como indica su nombre, en este bloque de código hace falta un parentesis en la función *main* 

    - ```c
      int main( {
          return 0;
      }
      ```

    - ```c
      int main ) {
          return 0;
      }
      ```

  - **Falta el número que retorna**: Como indica su nombre en el argumento del *return* falta el entero que lo acompaña

    - ```c
      int main() {
          return;
      }
      ```

  - **Falta  una llave**: Como indica su nombre en este bloque de código falta una llave que abre o cierra el *main()*

    - ```c
      int main() {
      return 0;
      ```

    - ```c
      int main() 
      return 0;
      }
      ```

  - **Ningún parentesis en la función *main* **: Como su nombre lo indica, en el bloque de código no hay ninún parentesis que abra o cierre los argumentos que recibe.

    - ```c
      int main {
          return 0
      }
      ```

  - **Sin espacios entre las palabras reservadas de los elementos**:  El error mas común debido a la sintaxis, en este bloque de código no se tiene ningún espacio entre las palabras reservadas de los elementos.

    - ```c
      int main() {
          return2;
      }
      ```

    - ```c
      intmain() {
          return 2;
      }
      ```

    - ```c
      intmain() {
          return2;
      }
      ```

  - **Mayúsculas en las palabras reservadas**:  Como su nombre lo indica las palabras reservadas están en mayúscula

    - ```c
      int main() {
          RETURN 0;
      }
      ```

    - ```c
      INT main() {
          return 0;
      }
      ```

    - ```c
      int MAIN() {
          RETURN 0;
      }
      ```

- **<u>OBSERVACIONES</u>** : Cualquier error de sintaxis del lenguaje C, hará que nuestro compilador marque errores.

Se tomo como referencia los archivos de prueba del repositorio de Norasandler, como la étapa 1 del proyecto, *stage_1*

[https://github.com/nlsandler/write_a_c_compiler](Referencia Repositorio)

![](/home/galigaribaldi/Documentos/Carpeta Pruebas/1.png)

![2](/home/galigaribaldi/Documentos/Carpeta Pruebas/2.png)



### Pruebas Manuales

En este apartado se explicará como poder correr las pruebas manualmente.

**Esta configuración es previa y solo se anexa como recordatorio**

```elixir
mix escript.build
```

**Código de prueba *return_2.c***

```c
int main(){return 2;}
```

Para correr pruebas de manera manual se utiliza lo siguiente

```bash
lpncc Pruebas/return_2.c
```

Lo que nos daría como sálida lo siguiente:

![](/home/galigaribaldi/Documentos/Carpeta Pruebas/pruebas1.png)

**Código de prueba *newlines.c***

```c
int 
main
(   
)
{
return
0
;
}
```

Para correr pruebas de manera manual se utiliza lo siguiente

```bash
lpncc Pruebas/newlines.c
```

Lo que nos daría como sálida lo siguiente:

![](/home/galigaribaldi/Documentos/Carpeta Pruebas/Pruebas2.png)

### Pruebas automatizadas

Para poder automatizar todas las pruebas se usan los siguientes comandos

```elixir
mix test
```

