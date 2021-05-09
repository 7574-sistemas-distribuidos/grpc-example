# grpc-example
Conjunto de ejemplos de [gRPC](https://grpc.io/) containerizados para que los alumnos de la materia puedan fácilmente utilizar este framework. Todos los ejemplos se encuentran aislados en carpetas separadas y se provee un Makefile para ejecutar cada ejemplo con los siguientes targets:
* **example-folder-docker-compose-up:** Arranca el docker-compose con los servicios que componen el ejemplo
* **example-folder-docker-compose-down:** Detiene el docker-compose liberando los servicios y recursos creados al ejecutar **run.sh**

Antes de ejecutar cualquier ejemplo, el alumno deberá ejecutar el Makefile target **build-base-images** que crea imágenes base que luego serán utilizados en los ejemplos de gRPC

## simple-rpc
El presente ejemplo es un cliente-servidor estandar el cual implementa una calculadora que soporta las 4 operaciones básicas (suma, resta, multiplicación, división)
