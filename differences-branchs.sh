#!/bin/bash

# Verifica si se proporcionó el nombre de la rama como argumento
if [ $# -eq 0 ]; then
  current_branch=$(git symbolic-ref --short HEAD 2>/dev/null)
else
  current_branch=$1
fi

if [ -z "$current_branch" ]; then
  echo "No estas en una rama. Proporciona el nombre de la branch."
  exit 1
fi

comparison_branch="develop"

echo -e "\n==== Informacion de ramas ===="
echo "Rama Actual: $current_branch"
echo "Rama de comparación: $comparison_branch"

echo -e "\n==== Lista de Commits ===="
git log --oneline $comparison_branch..$current_branch

echo -e "\n==== Archivos Modificados ===="
#git log --name-only --pretty=format:'' $comparison_branch..$current_branch | sort | uniq | awk -F'/' '{print $NF}' | sed -e 's/^/  \x1b[34m\x1b[1m/' -e 's/$/\x1b[0m/'

git --no-pager diff --stat $comparison_branch..$current_branch | awk -F'/' '/\//{print $NF}' | column -t

git --no-pager diff --shortstat $comparison_branch..$current_branch
