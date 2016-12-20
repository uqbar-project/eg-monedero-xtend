
# Ejercicio Manejo de Errores - Monedero

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/8f58afbdb7c04e4f801bf29b39f08f03)](https://www.codacy.com/app/fernando-dodino/eg-monedero-xtend?utm_source=github.com&utm_medium=referral&utm_content=uqbar-project/eg-monedero-xtend&utm_campaign=badger)

![image](images/demo.gif) 

## Dominio y explicación
Ejercicio del [monedero](https://docs.google.com/document/d/1vVW91adl0p-NxGNpe8fqmC_5YmBkrxaLDFKyZ0xZb9Y/edit)

## Cómo correr el ejemplo

En el directorio raíz encontrarán el archivo [MonederoApplication.launch](MonederoApplication.launch) que levanta la aplicación en [Arena](arena.uqbar-project.org), un framework didáctico que nos sirve como excusa para mostrar cómo se capturan los errores que lanza el negocio, ya que como vemos cuando un objeto de dominio lanza un error lo suele atrapar

* la interfaz de usuario
* un test unitario
* o en muy excepcionales casos, otro objeto de dominio (porque hay una regla de negocio que contempla el manejo específico de errores) 

## Conceptos a ver

* Manejo de errores
* De yapa, se refactorizan algunas decisiones iniciales de diseño en el branch [refactoring](https://github.com/uqbar-project/eg-monedero-xtend/tree/refactoring)



