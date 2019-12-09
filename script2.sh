#!/bin/bash

function menu() {
	if (whiptail --title "será realizado o backup de todos os arquivos" --yesno "deseja continuar? Sim ou Não." 10 60) then
	    cron
	else
	   exit
	fi

}

function cron () {	
	dire=$(pwd)	          #a variavel dire contera o diretorio do script
	a=$(pwd)"/backup.sh"	  #a variavel a contera o diretorio do script+ nome do script
	usuario=$(users)          #a variavel usuario contera o usuario	
	item=$(whiptail --title "BACKUP" --menu "escolha o tempo em que o backup será atualizado:" --fb 15 50 4 \
	"1" "A cada minuto" \
	"2" "A cada hora" \
	"3" "Semanal" \
	"4" "Mensal" \
	"5" "nunca"  3>&1 1>&2 2>&3)
	status=$?
	case $item in 
	1) data="00-59 * * * * $a"; teste2;;	
	2) data="00 * * * * $a"; teste2;; 
	3) data="* 00 * * * $a"; teste2;;
	4) data="00 00 01 * * $a"; teste2;;
	5) backup;; 
	*) echo "Opcao desconhecida." ; echo ; cron ;;
	esac
}

#a variavel data contem o tempo em que sera execultado o comando

function teste2() {
	teste=$(crontab -l)
	data="$teste $data"	
	sudo chmod 777 /var/spool/cron/crontabs	
	cd /var/spool/cron/crontabs
	sudo echo "$data" >> $usuario
	backup
}

function backup() {
 	cd $dire
	chmod +x backup.sh
	./backup.sh
	
}

menu();






