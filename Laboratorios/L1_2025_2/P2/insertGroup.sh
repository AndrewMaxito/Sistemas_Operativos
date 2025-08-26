#!/bin/bash

#Valida argunmentos entrantes 
if [[ $# -lt 2 ]]; then
	echo "Uso $0 <usuario> <grupo1> <grupo2> ..."
fi

#Shift desplaza todas las entradas una poscision 
usuario=$1


existe=0
#Validar que el usuario exista en el archivo
encontrado=0
while read linea; do
	nombre="${linea%%:*}"
	if [[ $nombre = $usuario ]]; then
		existe=1
		break
	fi
done < passwd


if ((existe = 0)); then
	echo "EL usuario $usuario no existe en el archivo passwd"
	exit 1
fi

# Procesar los grupos desde el segundo argumento en adelante
for grupo in "${@:2}"; do
    grupo_encontrado=0
    nueva_linea=""
    nuevo_contenido=""

    while read linea; do
        nombre_grupo="${linea%%:*}"  # Parte antes del primer ':'

        if [ "$nombre_grupo" = "$grupo" ]; then
            grupo_encontrado=1

            # Separar el resto de la línea sin usar comandos
            parte1="${linea%%:*}"            # nombre del grupo
            resto="${linea#*:}"              # quitar hasta el primer :
            parte2="${resto%%:*}"            # contraseña
            resto2="${resto#*:}"             # quitar hasta el segundo :
            parte3="${resto2%%:*}"           # GID
            miembros="${resto2#*:}"          # lo que queda: miembros

            # Verificar si el usuario ya está
            ya_esta=0
            IFS=','  # para separar por comas
            for m in $miembros; do
                if [ "$m" = "$usuario" ]; then
                    ya_esta=1
                    break
                fi
            done
            unset IFS

            if [ $ya_esta -eq 0 ]; then
                if [ -z "$miembros" ]; then
                    nuevos_miembros="$usuario"
                else
                    nuevos_miembros="$miembros,$usuario"
                fi
                nueva_linea="$grupo:x:$parte3:$nuevos_miembros"
                echo "✅ Se añadió '$usuario' al grupo '$grupo'"
            else
                nueva_linea="$linea"
                echo "ℹ️ El usuario '$usuario' ya estaba en el grupo '$grupo'"
            fi
        else
            nueva_linea="$linea"
        fi

        # Ir acumulando el nuevo contenido del archivo
        nuevo_contenido="${nuevo_contenido}${nueva_linea}"$'\n'
    done < group

    if [ $grupo_encontrado -eq 0 ]; then
        echo "⚠️ El grupo '$grupo' no existe en el archivo group"
    fi

    # Guardar los cambios en el archivo group
    echo -n "$nuevo_contenido" > group
done
