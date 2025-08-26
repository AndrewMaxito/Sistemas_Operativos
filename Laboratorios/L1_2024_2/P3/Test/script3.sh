#!/bin/bash

patron=$1
for archivo in *"$patron"*; do
	cambiar="$patron.odt"
	
	nuevo_nombre=${archivo//$cambiar}
	nuevo_nombre+=".odt"
	mv -- $archivo $nuevo_nombre
done