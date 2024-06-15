#!/bin/bash

while getopts ":n:l:" opt; do
  case ${opt} in
    n )
      PROJECT_TYPE="normal"
      MODULE_NAME=${OPTARG}
      ;;
    l )
      PROJECT_TYPE="library"
      MODULE_NAME=${OPTARG}
      ;;
    \? )
      echo "Uso: $0 [-n <nombre del modulo>] | [-l <nombre del modulo>]" 1>&2
      exit 1
      ;;
  esac
done

if [ -z "${PROJECT_TYPE}" ] || [ -z "${MODULE_NAME}" ]; then
  echo "Debe especificar el tipo de proyecto y el nombre del módulo."
  exit 1
fi

if [ "${PROJECT_TYPE}" = "normal" ]; then
  # Crear directorio del proyecto
  PROJECT_NAME=$(basename ${MODULE_NAME})
  mkdir "${PROJECT_NAME}"

  # Iniciar proyecto de Golang
  cd "${PROJECT_NAME}" || exit
  go mod init "${MODULE_NAME}"

  # Iniciar repositorio Git
  git init

  # Crear archivo .gitignore
  touch .gitignore
elif [ "${PROJECT_TYPE}" = "library" ]; then
  # Crear directorios para la librería y el proyecto de prueba
  LIB_DIR="lib"
  TEST_DIR="test"
  PROJECT_NAME=$(basename ${MODULE_NAME})

  mkdir "${PROJECT_NAME}"
  cd "${PROJECT_NAME}"
  mkdir "${TEST_DIR}"
  mkdir "${PROJECT_NAME}"

  # Iniciar proyecto de Golang en el directorio de la librería
  cd "${PROJECT_NAME}" || exit
  go mod init "${MODULE_NAME}"

  # Iniciar repositorio Git
  git init

  # Crear archivo .gitignore
  touch .gitignore

  # Regresar al directorio principal
  cd ..

  # Crear archivo main.go en el directorio de prueba
  cat <<EOF > "${TEST_DIR}/main.go"
package main

import (
	"fmt"
	"${MODULE_NAME}"
)

func main() {
	fmt.Println("hello world")
}
EOF

  # Iniciar proyecto de Golang en el directorio principal
  go mod init "${MODULE_NAME}"

  # Importar la librería en el proyecto de prueba
  go get -u "${MODULE_NAME}"

  # Configurar go work
  go work init
  go work use "${TEST_DIR}/"
  go work use "${PROJECT_NAME}"
else
  echo "Tipo de proyecto no válido: ${PROJECT_TYPE}"
  exit 1
fi

echo "Proyecto creado exitosamente."

