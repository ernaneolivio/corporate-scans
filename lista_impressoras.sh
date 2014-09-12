#!/bin/bash
#
#
# Descrição     :Script para identificar todas as impressoras de rede
#
# Autor 	: Ernane Olivio <ernane.olivio@gmail.com>
# Nome  	: printer.sh
# Data 		: 2014/09
# Versão	: 1.0
# Licença	: BSD
# Sobre		: Identifica todas as impressoras de rede utilzando as portas 9100 (JetDirect)
#		: e 631 (ipp). Será usado o método mais rápido
#
#
###


for arq in `ls tmp/2014-09-12`
do
	grep open  tmp/2014-09-12/$arq | awk '{print $2}' >> lista_impressoras.txt
done
