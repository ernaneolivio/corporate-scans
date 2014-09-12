#!/bin/bash
#
#
# Descrição     :Script para consolidar as informações do printer.sh
#
# Autor         : Ernane Olivio <ernane.olivio@gmail.com>
# Nome          : printer-show.sh
# Data          : 2014/09
# Versão        : 1.0
# Licença       : BSD
# Sobre         : Consolida todas as informações das impressoras de rede que utilzam as portas 9100 (JetDirect)
#               : e 631 (ipp). Será usado o método mais rápido
#
#
###
GREP=$(which grep)
WC=$(which wc)
CAT=$(which cat)
LS=$(which ls)
RM=$(which rm)
MKDIR=$(which mkdir)

TMPDIR=tmp
LOG=log
LOGSHOW=printer-show-log

# Limpa relatorio anterior
$RM -rf $TMPDIR/$LOG
$RM -rf $TMPDIR/$LOGSHOW

if [ -e $TMPDIR/$LOG ]
then
	echo "Pasta log já existe"
else
	$MKDIR -p $TMPDIR/$LOG
	 echo "Criando pasta log"
fi

if [ -e  $TMPDIR/$LOGSHOW ]
then
	echo "Pasta printer-log-show já existe"
else
	$MKDIR -p $TMPDIR/$LOGSHOW
	 echo "Criando pasta printer-log-show"
fi

# Tabela
echo -e "===========\t============="
echo -e "Rede \t        Qtde Impressora\n"


for FILE in $($LS $TMPDIR/2014-09-12)
do
	echo $FILE | sed 's/........$//g' >> $TMPDIR/$LOGSHOW/network-show.out
	if [ ! -e "$FILE" ]
	then
		$GREP open $TMPDIR/2014-09-12/$FILE | $WC -l >> $TMPDIR/$LOGSHOW/printer-show.out
	else
		break;
	fi
done

paste $TMPDIR/$LOGSHOW/network-show.out $TMPDIR/$LOGSHOW/printer-show.out > $TMPDIR/$LOGSHOW/final.txt
cat $TMPDIR/$LOGSHOW/final.txt

	
