#!/bin/bash

# Validar número de argumentos
if [ $# -ne 3 ]; then
    echo "Uso correcto: $0 <inicio> <fin> <dígito>"
    exit 1
fi

# Asignar argumentos
inicio=$1
fin=$2
digito=$3

# Opcional: Si quieres ver los argumentos después de la validación
# echo "Iniciando búsqueda con: Inicio=$inicio, Fin=$fin, Dígito=$digito"

# Validar que inicio y fin sean enteros, y digito un solo dígito (0–9)
if ! [[ "$inicio" =~ ^[0-9]+$ ]]; then
    echo "Error: <inicio> debe ser un número entero positivo"
    exit 1
fi

if ! [[ "$fin" =~ ^[0-9]+$ ]]; then
    echo "Error: <fin> debe ser un número entero positivo"
    exit 1
fi

if ! [[ "$digito" =~ ^[0-9]$ ]]; then
    echo "Error: <dígito> debe ser un solo número entre 0 y 9"
    exit 1
fi

# Si el inicio es mayor que el fin, intercambiarlos
if [ "$inicio" -gt "$fin" ]; then
    temp=$inicio
    inicio=$fin
    fin=$temp
fi

# Función para verificar si un número es primo
es_primo() {
    local num=$1
    if [ "$num" -le 1 ]; then
        return 1
    fi
    for ((k = 2; k * k <= num; k++)); do
        if (( num % k == 0 )); then
            return 1
        fi
    done
    return 0
}

# Recorrer todos los números en el rango
for ((i = inicio; i <= fin; i++)); do
    # Verifica si el número contiene el dígito especificado
    if [[ "$i" == *"$digito"* ]]; then
        if es_primo "$i"; then
            echo "$i (Es primo)"
        else
            echo "$i"
        fi
    fi
done