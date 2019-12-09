#!/bin/bash
function backup() {
	usuario=$(users)	
	item=$(whiptail --title "BACKUP" --menu "escolha o destino:" --fb 15 50 4 \
	"1" "servidor" \
	"2" "Documentos" \
	"3" "Pendrive"  3>&1 1>&2 2>&3) 
	status=$?
	case $item in 
	1) servidor ;;
	2) desktop  ;;
	3) pendrive ;;
	*)echo "Opcao desconhecida." ; echo ; backup ;;
	esac

	sudo apt-get install rsync
	rsync -ua ~/ $destino
}

function pendrive () {
	if (whiptail --title "seu backup será salvo em seu pendrive" --yesno "deseja continuar?" 10 60) then
	    cd /media/$usuario
	    lista=$(ls)
	    echo "$lista"	
	  ##  a=${sed -n "1p" $lista}
	  #  b=${sed -n "2p" $lista} 
	   # c= 
	   # d= 
	    #e= 
	   # echo "$a"
	  #  echo "$b"	
	  #  echo "$e"
	    read pendrives
	    destino="/media/$usuario/$pendrives"
	    return
	else
	   backup
	fi
}

function servidor () {
      if (whiptail --title "seu backup será salvo em seu servidor" --yesno "deseja continuar?" 10 60) then
	   ip=$(whiptail --title "Servidor" --inputbox "Insira seu IP." 10 60 3>&1 1>&2 2>&3)
	exitstatus=$?
	if [ $exitstatus != 0 ]; then
 	   echo "Você cancelou."
	fi
	usu=$(whiptail --title "Servidor" --inputbox "Insira o usuario do servidor." 10 60 3>&1 1>&2 2>&3) 
	exitstatus=$?
	if [ $exitstatus != 0 ]; then
  	  echo "Você cancelou."
	fi
	destino="$ip@$usu:/home/$usu/backup"
	
	if (whiptail --title "Servidor" --yesno "Seu backup será salvo em: $destino continuar?" 10 60) then
	    return
	else
	   servidor
	fi

       else
	   backup
       fi
	return
}

function desktop () {
	
	if (whiptail --title "seu backup será salvo em Documentos" --yesno "deseja continuar?" 10 60) then
	
	    cd /media/$usuario/Documentos
	    mkdir Backup
	    destino="/media/$usuario/Documentos/Backup";
	    return
	else
	   backup
	fi		
}
backup

