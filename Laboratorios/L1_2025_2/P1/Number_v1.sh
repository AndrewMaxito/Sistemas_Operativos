#!/bin/bash


#Número inicial
n1=$1
#Número final
n2=$2
#Patron
n3=$3


#Funcion que evalua si es primo o no 
es_primo(){
	local num=$1 
	#Fija: usar (( ... )) para evaluaciones aritmeticas es mas sencillo que los [] o los [[ ]]
	if (( num <= 1 )); then
		return 1 #No es primo
	fi

	for (( k = 2; k * k <= num; k++ )); do
        if (( num % k == 0 )); then
            return 1 # No es primo
        fi
    done
    return 0 #si es primo
}


# Validacion simple de valores de entrada
if [[ -z $n1 || -z $n2 || -z $n3 ]]; then
    echo "ERROR: Debes ingresar 3 argumentos: inicio fin digito"
    echo "Ejemplo: $0 10 50 3"
    exit 1
fi

# Recorrido desde n1 hasta n2
i=$n1
while (( i <=  n2 )); do
    contiene=0

    # Recorrer los dígitos del número actual
    for (( j=0; j<${#i}; j++ )); do
        digito="${i:$j:1}"
        if (( digito == n3 )); then
            contiene=1
            break
        fi
    done

    # Si contiene el dígito, verificar si es primo
    if (( contiene == 1 )); then
    	#Las funciones dentro de los if, while, etc... deben ir de la siguiente firma o si va fuera usar $?
        if es_primo "$i"; then
            echo "$i (Es primo)"
        else
            echo "$i "
        fi
    fi

    ((i++))
done











