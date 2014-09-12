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
GREP=$(which grep)
WC=$(which wc)
TMPDIR=tmp
LISTAREDES=lista_redes_sesa.txt
DATE=$(date +%F)i
RM=$(which rm)

# Limpa última consulta
$RM -rf $TMPDIR/$DATE/
# Verifica se o usuário é root
#
if [ $EUID -ne 0 ]; then
    echo "Erro: Você deve ser root para poder executar este script, por favor utilize o usuário root ou sudo."
    exit 1
fi

if [ -d $TMPDIR ] && [ -e $TMPDIR ]
then
	echo " [1] Salvando o scan"
	mkdir -p $TMPDIR/$DATE

	
	echo " [2] Executando Nmap na porta 9100"
	for REDE in $(cat $LISTAREDES)
	do
		FILE=$(echo $REDE | sed 's/...$//g')
#		echo $FILE
		nmap -sT -T5 -p 9100 $REDE -oG $TMPDIR/$DATE/$FILE-out.raw
	done

	# Contando impressoras
	PRINTERS=$($GREP open $TMPDIR/printer-out.raw | $WC -l)
	echo " [3] Foram encontradas $PRINTERS impressoras."
else
	echo "Criando diretório $TMPDIR"
	mkdir -p $TMPDIR
fi
./printer-show.sh
