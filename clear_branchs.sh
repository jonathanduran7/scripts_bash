#!/bin/bash

# Obtener la lista de todas las ramas
branches=$(git branch --list)

# Imprimir la lista de ramas y solicitar la entrada del usuario
echo "Lista de ramas:"
echo "$branches"

read -p "Ingrese las ramas que no desea eliminar (separadas por espacio): " branches_to_keep

# Verificar si se ingresaron ramas para mantener
if [ -z "$branches_to_keep" ]; then
  echo "No se ingresaron ramas para mantener. Saliendo."
  exit 1
fi

# Convertir la entrada del usuario en un array
IFS=' ' read -ra branches_to_keep_array <<< "$branches_to_keep"

# Eliminar las ramas locales que no se seleccionaron para mantener
for branch in $branches; do
  echo "branch $branch"
  echo "Indice ${branches_to_keep_array[@]}"
  # Verificar si la rama no está en la lista de ramas a mantener
  #if [[ ! " ${branches_to_keep_array[@]} " =~ " $branch " ]]; then
    # Eliminar la rama local
    # git branch -d $branch
    #echo "Rama local eliminada: $branch"
  #else
    #echo "Rama local conservada: $branch"
  #fi
done

echo "Proceso completado. Las ramas remotas no han sido eliminadas."
