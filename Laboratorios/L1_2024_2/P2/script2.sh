#!/bin/bash


while read linea; do
	#Separamos el codigo primero (Quitamos todo hasta el ultimo espcacio empezando de la derecha )
	codigo="${linea%%[[:space:]]*}" #[[:space:]] es necesario ya que hay tabulacion sirve de forma mas general para los espacios

	#Ahora quedaria el resto (apellidos y nombres)
	resto="${linea#*[[:space:]]}"
	

	#Separacion de los apellidos y nombres 
	apellidos="${resto%%,*}"
	#Separacion de nombres
	nombres="${resto#*,}"

	#Formato del nombre MAX -> Max
	nombre_formato=""
	for palabra in $nombres; do
		#Primera Letra
		inicial=${palabra:0:1}
		resto=${palabra:1}
		nombre_formato+="${inicial^}${resto,,} " #hayun espacio al final
	done
	nombre_formato="${apellidos},${nombre_formato%" "}"
	

	nombre_correo=""
	apellido_correo=""
	#Ahora para el correo (primerapellidoMINUS + primerNombreMINUS)
	for palabra in $nombres; do
		nombre_correo=$palabra
		break
	done
	for palabra in $apellidos; do
		apellido_correo=$palabra
		break
	done

	correo="${nombre_correo,,}.${apellido_correo,,}@pucp.edu.pe"
	 formato_linea="${codigo}:${nombre_formato}:${correo}"
	 echo "$formato_linea" >> Lista2.txt

	 #El codigo se puede mejorar mas pero se hizo asi para mostrar las funcionalidades de las herramientas de la teoria 

done < Lista1.txt