#!/bin/bash
#24/03/2021
declare -A cor=( [0]="\033[1;37m" [1]="\033[1;34m" [2]="\033[1;31m" [3]="\033[1;33m" [4]="\033[1;32m" )
SCPfrm="/etc/ger-frm" && [[ ! -d ${SCPfrm} ]] && exit
SCPinst="/etc/ger-inst" && [[ ! -d ${SCPinst} ]] && exit
err_fun () {
     case $1 in
     1)msg -verm "$(fun_trans "Usuario Nulo")"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     2)msg -verm "$(fun_trans "Nombre muy corto (MIN: 2 CARACTERES)")"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     3)msg -verm "$(fun_trans "Nombre muy grande (MAX: 5 CARACTERES)")"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     4)msg -verm "$(fun_trans "Contraseña Nula")"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     5)msg -verm "$(fun_trans "Contraseña muy corta")"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     6)msg -verm "$(fun_trans "Contraseña muy grande")"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     7)msg -verm "$(fun_trans "Duracion Nula")"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     8)msg -verm "$(fun_trans "Duracion invalida utilize numeros")"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     9)msg -verm "$(fun_trans "Duracion maxima y de un año")"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     11)msg -verm "$(fun_trans "Limite Nulo")"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     12)msg -verm "$(fun_trans "Limite invalido utilize numeros")"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     13)msg -verm "$(fun_trans "Limite maximo de 999")"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     14)msg -verm "$(fun_trans "Usuario Ya Existe")"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
	 15)msg -verm "$(fun_trans "(Solo numeros) GB = Min: 1gb Max: 1000gb")"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
	 16)msg -verm "$(fun_trans "(Solo numeros)")"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
	 17)msg -verm "$(fun_trans "(Sin Informacion - Para Cancelar Digite CRTL + C)")"; sleep 4s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     esac
}
intallv2ray () {
apt install python3-pip -y 
source <(curl -sL https://multi.netlify.app/v2ray.sh)
msg -ama "$(fun_trans "Intalado con Exito")!"
}
protocolv2ray () {
msg -ama "$(fun_trans "Escojer opcion 3 y poner el dominio de nuestra IP")!"
msg -bar
v2ray stream
}
tls () {
msg -ama "$(fun_trans "Activar o Desactivar TLS")!"
msg -bar
echo -ne "\033[1;97mTip elige opcion -1.open TLS- y eliges la opcion 1 para\ngenerar los certificados automaticamente y seguir los pasos\nsi te marca algun error esocjer la opcion 1 de nuevo pero\nahora elegir opcion 2 para gregar las rutas del certificado\nmanualmente.\n\033[1;93m
certificado = /root/cer.crt\nkey= /root/key.key\n\033[1;97m"
openssl genrsa -out key.key 2048 > /dev/null 2>&1
(echo ; echo ; echo ; echo ; echo ; echo ; echo ) | openssl req -new -key key.key -x509 -days 1000 -out cer.crt > /dev/null 2>&1
echo ""
v2ray tls
}
unistallv2 () {
source <(curl -sL https://multi.netlify.app/v2ray.sh) --remove
}
infocuenta () {
v2ray info
}
port () {
v2ray port
}
addusr () {
clear 
clear
msg -bar
msg -tit
msg -ama "             AGREGAR USUARIO | UUID V2RAY"
msg -bar
##DAIS
valid=$(date '+%C%y-%m-%d' -d " +31 days")		  
##CORREO		  
MAILITO=$(cat /dev/urandom | tr -dc '[:alnum:]' | head -c 10)
##ADDUSERV2RAY		  
UUID=`uuidgen`	  
sed -i '13i\           \{' /etc/v2ray/config.json
sed -i '14i\           \"alterId": 0,' /etc/v2ray/config.json
sed -i '15i\           \"id": "'$UUID'",' /etc/v2ray/config.json
sed -i '16i\           \"email": "'$MAILITO'@gmail.com"' /etc/v2ray/config.json
sed -i '17i\           \},' /etc/v2ray/config.json
echo ""
while true; do
echo -ne "\e[91m >> Digita un Nombre: \033[1;92m"
     read -p ": " nick
     nick="$(echo $nick|sed -e 's/[^a-z0-9 -]//ig')"
     if [[ -z $nick ]]; then
     err_fun 17 && continue
     elif [[ "${#nick}" -lt "2" ]]; then
     err_fun 2 && continue
     elif [[ "${#nick}" -gt "5" ]]; then
     err_fun 3 && continue
     fi
     break
done
echo -e "\e[91m >> Agregado UUID: \e[92m$UUID "
while true; do
     echo -ne "\e[91m >> Duracion de UUID (Dias):\033[1;92m " && read diasuser
     if [[ -z "$diasuser" ]]; then
     err_fun 17 && continue
     elif [[ "$diasuser" != +([0-9]) ]]; then
     err_fun 8 && continue
     elif [[ "$diasuser" -gt "360" ]]; then
     err_fun 9 && continue
     fi 
     break
done
#Lim
[[ $(cat /etc/passwd |grep $1: |grep -vi [a-z]$1 |grep -v [0-9]$1 > /dev/null) ]] && return 1
valid=$(date '+%C%y-%m-%d' -d " +$diasuser days") && datexp=$(date "+%F" -d " + $diasuser days")
echo -e "\e[91m >> Expira el : \e[92m$datexp "
##Registro
echo "  $UUID | $nick | $valid " >> /etc/RegV2ray
v2ray restart > /dev/null 2>&1
echo ""
v2ray info > /var/log/v2ray/access.log
lineP=$(sed -n '/'${UUID}'/=' /var/log/v2ray/access.log)
numl1=4
let suma=$lineP+$numl1
sed -n ${suma}p /var/log/v2ray/access.log 
echo ""
msg -bar
echo -e "\e[92m           UUID AGREGEGADO CON EXITO "
msg -bar
}
delusr () {
clear 
clear
invaliduuid () {
msg -bar
echo -e "\e[91m                    UUID INVALIDO \n$(msg -bar)"
msg -ne "Enter Para Continuar" && read enter
${SCPinst}/v2ray.sh
}
msg -bar
msg -tit
msg -ama "             ELIMINAR USUARIO | UUID V2RAY"
msg -bar
echo -e "\e[97m               USUARIOS REGISTRADOS"
echo -e "\e[33m$(cat /etc/RegV2ray|cut -d '|' -f2,1)" 
msg -bar
echo -ne "\e[91m >> Digita el UUID a elininar:\n \033[1;92m " && read uuidel
[[ $(sed -n '/'${uuidel}'/=' /etc/v2ray/config.json|head -1) ]] || invaliduuid
lineP=$(sed -n '/'${uuidel}'/=' /etc/v2ray/config.json)
linePre=$(sed -n '/'${uuidel}'/=' /etc/RegV2ray)
sed -i "${linePre}d" /etc/RegV2ray
numl1=2
let resta=$lineP-$numl1
sed -i "${resta}d" /etc/v2ray/config.json
sed -i "${resta}d" /etc/v2ray/config.json
sed -i "${resta}d" /etc/v2ray/config.json
sed -i "${resta}d" /etc/v2ray/config.json
sed -i "${resta}d" /etc/v2ray/config.json
v2ray restart > /dev/null 2>&1
msg -bar
}
mosusr_kk() {
clear 
clear
msg -bar
msg -tit
msg -ama "         USUARIOS REGISTRADOS | UUID V2RAY"
msg -bar
# usersss=$(cat /etc/VPS-MX/RegV2ray|cut -d '|' -f1)
# cat /etc/VPS-MX/RegV2ray|cut -d'|' -f3
VPSsec=$(date +%s)
local HOST="/etc/RegV2ray"
local HOST2="/etc/RegV2ray"
local RETURN="$(cat $HOST|cut -d'|' -f2)"
local IDEUUID="$(cat $HOST|cut -d'|' -f1)"
if [[ -z $RETURN ]]; then
echo -e "----- NINGUN USER REGISTRADO -----"
msg -ne "Enter Para Continuar" && read enter
${SCPinst}/v2ray.sh

else
i=1
echo -e "\e[97m                 UUID                | USER | EXPIRACION \e[93m"
msg -bar
while read hostreturn ; do
DateExp="$(cat /etc/RegV2ray|grep -w "$hostreturn"|cut -d'|' -f3)"
if [[ ! -z $DateExp ]]; then             
DataSec=$(date +%s --date="$DateExp")
[[ "$VPSsec" -gt "$DataSec" ]] && EXPTIME="\e[91m[EXPIRADO]\e[97m" || EXPTIME="\e[92m[$(($(($DataSec - $VPSsec)) / 86400))]\e[97m Dias"
else
EXPTIME="\e[91m[ S/R ]"
fi 
usris="$(cat /etc/RegV2ray|grep -w "$hostreturn"|cut -d'|' -f2)"
local contador_secuencial+="\e[93m$hostreturn \e[97m|\e[93m$usris\e[97m|\e[93m $EXPTIME \n"           
      if [[ $i -gt 30 ]]; then
	      echo -e "$contador_secuencial"
	  unset contador_secuencial
	  unset i
	  fi
let i++
done <<< "$IDEUUID"

[[ ! -z $contador_secuencial ]] && {
linesss=$(cat /etc/RegV2ray | wc -l)
	      echo -e "$contador_secuencial \n Numero de Registrados: $linesss"
	}
fi
msg -bar
}
msg -ama "$(fun_trans "MENU V2RAY")"
msg -bar
echo -ne "\033[1;32m [1] > " && msg -azu "$(fun_trans "INSTALAR V2RAY") "
echo -ne "\033[1;32m [2] > " && msg -azu "$(fun_trans "CAMBIAR PROTOCOLO") "
echo -ne "\033[1;32m [3] > " && msg -azu "$(fun_trans "ACTIVAR TLS") "
echo -ne "\033[1;32m [4] > " && msg -azu "$(fun_trans "CAMBIAR PUERTO") "
echo -ne "\033[1;32m [5] > " && msg -azu "$(fun_trans "INFORMACION DE CUENTA")"
echo -ne "\033[1;32m [6] > " && msg -azu "$(fun_trans "DESINTALAR V2RAY")"
echo -ne "\033[1;32m [7] > " && msg -azu "$(fun_trans "AGREGAR USUARIO UUID")"
echo -ne "\033[1;32m [8] > " && msg -azu "$(fun_trans "ELIMINAR USUARIO UUID")"
echo -ne "\033[1;32m [9] > " && msg -azu "$(fun_trans "MOSTAR USUARIOS REGISTRADOS")"
msg -bar && echo -ne "$(msg -verd "[0]") $(msg -verm2 ">") "&& msg -bra "\033[1;41mREGRESAR AL MENU"
msg -bar
while [[ ${arquivoonlineadm} != @(0|[1-9]) ]]; do
read -p "[0-9]: " arquivoonlineadm
tput cuu1 && tput dl1
done
case $arquivoonlineadm in
1)intallv2ray;;
2)protocolv2ray;;
3)tls;;
4)port;;
5)infocuenta;;
6)unistallv2;;
7)addusr;;
8)delusr;;
9)mosusr_kk;;
0)exit;;
esac
msg -bar
