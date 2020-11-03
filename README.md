# grpc-example
Conjunto de ejemplos de [gRPC](https://grpc.io/) containerizados para que los alumnos de la materia puedan fácilmente utilizar este framework. Todos los ejemplos se encuentran aislados en carpetas separadas y cada uno de ellos cuenta con los siguientes scripts para poder ejecutar los mismos:
* **run.sh:** Arranca el docker-compose con los servicios que componente el ejemplo
* **stop.sh:** Detiene el docker-compose liberando los servicios y recursos creados al ejecutar **run.sh**

Antes de ejecutar cualquier ejemplo, el alumno deberá dirigirse a la carpeta **base-images** y ejecutar el comando **build.sh** que crea imágenes base que luego serán utilizados en los ejemplos de gRPC. 

## simple-rpc
El presente ejemplo es un cliente-servidor estandar el cual implementa una calculadora que soporta las 4 operaciones básicas (suma, resta, multiplicación, división)
