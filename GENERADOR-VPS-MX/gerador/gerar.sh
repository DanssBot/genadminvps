#!/bin/bash
# INSTALACAO BASICA
clear
#[[ -e /etc/newadm-instalacao ]] && BASICINST="$(cat /etc/newadm-instalacao)" || BASICINST="ADMbot.sh C-SSR.sh Crear-Demo.sh PDirect.py PGet.py POpen.py PPriv.py PPub.py Shadowsocks-R.sh Shadowsocks-libev.sh Unlock-Pass-VULTR.sh apacheon.sh blockBT.sh budp.sh dns-netflix.sh   dropbear.sh fai2ban.sh gestor.sh menu message.txt openvpn.sh  ports.sh shadowsocks.sh sockspy.sh speed.sh speedtest.py squid.sh squidpass.sh ssl.sh tcp.sh ultrahost usercodes utils.sh v2ray.sh Proxy.sh"
[[ -e /etc/newadm-instalacao ]] &&  BASICINST="$(cat /etc/newadm-instalacao)" || BASICINST="ferramentas limitera menu_inst PPub.py speedtest.py usercodes ferramentascodes limiterb  menu-txt payloads ssl user-txt cabecalho ferramentas-txt limiter.sh trans verifica confdropbear get PDirect.py v-local.log idioma_geral MasterBin.sh PGet.py pwd.pwd ultrahost idioma_menuinst menu optimizador POpen.py shadowsocks.sh fai2ban menu_credito PPriv.py user"
IVAR="/etc/http-instas"
BARRA="\033[1;36m-----------------------------------------------------\033[0m"
BARRA2="\033[1;31m=====================================================\033[0m"
_hora=$(printf '%(%H:%M:%S)T') 
_fecha=$(printf '%(%D)T') 

#PROCESSADOR
_core=$(printf '%-1s' "$(grep -c cpu[0-9] /proc/stat)")
_usop=$(printf '%-1s' "$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')")

#SISTEMA-USO DA CPU-MEMORIA RAM
ram1=$(free -h | grep -i mem | awk {'print $2'})
ram2=$(free -h | grep -i mem | awk {'print $4'})
ram3=$(free -h | grep -i mem | awk {'print $3'})

_ram=$(printf ' %-9s' "$(free -h | grep -i mem | awk {'print $2'})")
_usor=$(printf '%-8s' "$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')")

# Funcoes Globais
msg () {
local colors="/etc/new-adm-color"
if [[ ! -e $colors ]]; then
COLOR[0]='\033[1;37m' #BRAN='\033[1;37m'
COLOR[1]='\e[31m' #VERMELHO='\e[31m'
COLOR[2]='\e[32m' #VERDE='\e[32m'
COLOR[3]='\e[33m' #AMARELO='\e[33m'
COLOR[4]='\e[34m' #AZUL='\e[34m'
COLOR[5]='\e[91m' #MAGENTA='\e[35m'
COLOR[6]='\033[1;97m' #MAG='\033[1;36m'
COLOR[7]='\033[1;49;95m'
COLOR[8]='\033[1;49;96m'
else
local COL=0
for number in $(cat $colors); do
case $number in
1)COLOR[$COL]='\033[1;37m';;
2)COLOR[$COL]='\e[31m';;
3)COLOR[$COL]='\e[32m';;
4)COLOR[$COL]='\e[33m';;
5)COLOR[$COL]='\e[34m';;
6)COLOR[$COL]='\e[35m';;
7)COLOR[$COL]='\033[1;36m';;
8)COLOR[$COL]='\033[1;49;95m';;
9)COLOR[$COL]='\033[1;49;96m';;
esac
let COL++
done
fi
NEGRITO='\e[1m'
SEMCOR='\e[0m'
 case $1 in
  -ne)cor="${COLOR[1]}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}";;
  -ama)cor="${COLOR[3]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verm)cor="${COLOR[3]}${NEGRITO}[!] ${COLOR[1]}" && echo -e "${cor}${2}${SEMCOR}";;
  -verm2)cor="${COLOR[1]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -aqua)cor="${COLOR[8]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -azu)cor="${COLOR[6]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verd)cor="${COLOR[2]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -bra)cor="${COLOR[0]}${SEMCOR}" && echo -e "${cor}${2}${SEMCOR}";;
  "-bar2"|"-bar")cor="${COLOR[7]}=====================================================" && echo -e "${SEMCOR}${cor}${SEMCOR}";;
 esac
}

os_system () {
system=$(echo $(cat -n /etc/issue |grep 1 |cut -d' ' -f6,7,8 |sed 's/1//' |sed 's/      //'))
echo $system|awk '{print $1, $2}'
}

meu_ipe () {
#if [[ -e /etc/MEUIPADM ]]; then
#echo "$(cat /etc/MEUIPADM)"
#else
MEU_IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MEU_IP2=$(wget -qO- ipv4.icanhazip.com)
[[ -z "$MEU_IP2" ]] && MEU_IP2=127.0.0.1
[[ "$MEU_IP" != "$MEU_IP2" ]] && echo "$MEU_IP2" || echo "$MEU_IP"
echo "$MEU_IP2" > /etc/MEUIPADM
#fi
}

ofus () {
unset server
server=$(echo ${txt_ofuscatw}|cut -d':' -f1)
unset txtofus
number=$(expr length $1)
for((i=1; i<$number+1; i++)); do
txt[$i]=$(echo "$1" | cut -b $i)
case ${txt[$i]} in
".")txt[$i]="+";;
"+")txt[$i]=".";;
"1")txt[$i]="@";;
"@")txt[$i]="1";;
"2")txt[$i]="?";;
"?")txt[$i]="2";;
"3")txt[$i]="%";;
"%")txt[$i]="3";;
"/")txt[$i]="K";;
"K")txt[$i]="/";;
esac
txtofus+="${txt[$i]}"
done
echo "$txtofus" | rev
}


SCPT_DIR="/etc/SCRIPT"
[[ ! -e ${SCPT_DIR} ]] && mkdir ${SCPT_DIR}
INSTA_ARQUIVOS="ADMVPS.zip"
DIR="/etc/http-shell"
LIST="lista-arq"
P_SERVER="https://www.dropbox.com/s/blxo0jifysvyrey/"
v1=$(curl -sSL "${P_SERVER}/v-new.log")
v2=$(cat $SCPT_DIR/v-local.log)
txt[315]="💥 ChumoGH Keygen 💥 IS UPDATED!"
txt[316]="⚠️ ChumoGH Keygen ⚠️ NEEDS UPDATE!"
meu_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ -z "$MIP2" ]] && MIP2=127.0.0.1
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
}

mudar_instacao () {
while [[ ${var[$value]} != 0 ]]; do
#[[ -e /etc/newadm-instalacao ]] && BASICINST="$(cat /etc/newadm-instalacao)" || BASICINST="ADMbot.sh C-SSR.sh Crear-Demo.sh PDirect.py PGet.py POpen.py PPriv.py PPub.py Shadowsocks-R.sh Shadowsocks-libev.sh Unlock-Pass-VULTR.sh apacheon.sh blockBT.sh budp.sh dns-netflix.sh   dropbear.sh fai2ban.sh gestor.sh menu message.txt openvpn.sh ports.sh shadowsocks.sh sockspy.sh speed.sh speedtest.py squid.sh squidpass.sh ssl.sh tcp.sh ultrahost usercodes utils.sh v2ray.sh Proxy.sh"
[[ -e /etc/newadm-instalacao ]] &&  BASICINST="$(cat /etc/newadm-instalacao)" || BASICINST="ferramentas limitera menu_inst PPub.py speedtest.py usercodes ferramentascodes limiterb  menu-txt payloads ssl user-txt cabecalho ferramentas-txt limiter.sh trans verifica confdropbear get PDirect.py v-local.log idioma_geral MasterBin.sh PGet.py pwd.pwd ultrahost idioma_menuinst menu optimizador POpen.py shadowsocks.sh fai2ban menu_credito PPriv.py user"
msg -bar
echo -e "MENÚ SELECCIÓN DE INSTALACIÓN"
msg -bar
i=1
for arqx in `ls ${SCPT_DIR}`; do
[[ $arqx = @(gerar.sh|http-server.py) ]] && continue
[[ $(echo $BASICINST|grep -w "$arqx") ]] && echo -e "\033[1;32m[$i] \033[1;37m- [\033[1;31mX\033[1;37m] - \033[1;96m$arqx" || echo -e "\033[1;32m[$i] \033[1;37m- [ ] - \033[1;96m$arqx"
var[$i]="$arqx"
let i++
done
msg -bar
echo "[0] - FINALIZAR PROCEDIMIENTO"
msg -bar
echo -ne "Seleccione el archivo [Agregar / Eliminar]: "
read value
[[ -z ${var[$value]} ]] && return
if [[ $(echo $BASICINST|grep -w "${var[$value]}") ]]; then
rm /etc/newadm-instalacao
local BASIC=""
  for INSTS in $(echo $BASICINST); do
  [[ $INSTS = "${var[$value]}" ]] && continue
  BASIC+="$INSTS "
  done
echo $BASIC > /etc/newadm-instalacao
else
echo "$BASICINST ${var[$value]}" > /etc/newadm-instalacao
fi
done
}



gen_key_menu () {
if [[ $1 = 1 ]]; then
		#ADM BASIC
		[[ ! -e ${DIR}/${KEY} ]] && mkdir ${DIR}/${KEY}
		read -p "Nombre de usuario ( comprador de la key ): " nombrevalue
		[[ -z $nombrevalue ]] && nombrevalue="SIN NOMBRE"
 		arqslist="$BASICINST"
		 for arqx in `echo "${arqslist}"`; do
			[[ -e ${DIR}/${KEY}/$arqx ]] && continue #ANULA ARQUIVO CASO EXISTA
			cp ${SCPT_DIR}/$arqx ${DIR}/${KEY}/
			echo "$arqx" >> ${DIR}/${KEY}/${LIST}
		 done
		 echo "$nombrevalue" > ${DIR}/${KEY}.name
		 [[ -e /etc/gen_at.txt ]] && at now +$(cat /etc/gen_at.txt) <<< "rm -rf ${DIR}/${KEY}.name; rm -rf ${DIR}/${KEY}" &>/dev/null
		 tipo="ADM"
		 linck=1
		 key_ok
elif [[ $1 = 3 ]]; then
		# GERADOR KEYS
		[[ ! -e ${DIR}/${KEY} ]] && mkdir ${DIR}/${KEY}
		read -p "Nombre de usuario ( comprador de la key ): " nombrevalue
		[[ -z $nombrevalue ]] && nombrevalue="SIN NOMBRE"
		msg -bar
		read -p "autorizar a generar key para generador [Y/N]: " -e -i n gen_gen
		msg -bar
		read -p "KEY DE ACTUALIZACIÓN?: [Y/N]: " -e -i n attGEN
		[[ $(echo $nombrevalue|grep -w "FIXA") ]] && nombrevalue+=[GERADOR]
 		 for arqx in `ls $SCPT_DIR`; do
  			[[ -e ${DIR}/${KEY}/$arqx ]] && continue #ANULA ARQUIVO CASO EXISTA
  			cp ${SCPT_DIR}/$arqx ${DIR}/${KEY}/
 			echo "$arqx" >> ${DIR}/${KEY}/${LIST}
		 done

		if [[ $gen_gen = @(Y|y|S|s) ]]; then
			echo "generador autorizado para generar keys de generadores" > ${DIR}/${KEY}/autorizar &>/dev/null
			echo "autorizar" >> ${DIR}/${KEY}/${LIST}
		fi

		tipo="GEN"
		if [[ $attGEN = @(Y|y|S|s) ]]; then
			[[ -e ${DIR}/${KEY}/gerar.sh ]] && rm ${DIR}/${KEY}/gerar.sh
			[[ -e ${DIR}/${KEY}/http-server.py ]] && rm ${DIR}/${KEY}/http-server.py
			nombrevalue+="_ACT"
			tipo+="_ACTUALIZACION"
		fi
		nombrevalue+="_GEN"
		echo "$nombrevalue" > ${DIR}/${KEY}.name
		[[ -e /etc/gen_at.txt ]] && at now +$(cat /etc/gen_at.txt) <<< "rm -rf ${DIR}/${KEY}.name; rm -rf ${DIR}/${KEY}" &>/dev/null
		linck=2
		key_ok
elif [[ $1 = 2 ]]; then
		#ADM BASIC FIJA
		[[ ! -e ${DIR}/${KEY} ]] && mkdir ${DIR}/${KEY}
		read -p "Nombre de usuario ( comprador de la key ): " nombrevalue
		[[ -z $nombrevalue ]] && nombrevalue="SIN NOMBRE"
 		arqslist="$BASICINST"
		 for arqx in `echo "${arqslist}"`; do
			[[ -e ${DIR}/${KEY}/$arqx ]] && continue #ANULA ARQUIVO CASO EXISTA
			cp ${SCPT_DIR}/$arqx ${DIR}/${KEY}/
			echo "$arqx" >> ${DIR}/${KEY}/${LIST}
		 done
		 echo KEY_FIJA > ${DIR}/${KEY}/key.fija
		 echo "$nombrevalue" > ${DIR}/${KEY}.name
		 [[ -e /etc/gen_at.txt ]] && at now +$(cat /etc/gen_at.txt) <<< "rm -rf ${DIR}/${KEY}.name; rm -rf ${DIR}/${KEY}" &>/dev/null
		 tipo="FIJADA"
		 linck=1
		 key_ok
elif [[ $1 = 4 ]]; then
		unset time
		unset text
		unset num
		clear
		msg -bar
		echo -e "\033[7;49;35m      Configuracion de auto eliminacion de keys      \033[0m"
		msg -bar
		menu_func "MINUTOS" "HORAS" "DESACTIVAR $genat"
		msg -bar
		echo -ne "$(msg -verd "[0]") $(msg -aqua ">") "&& msg -bra "\033[7;49;35mAtras"
		msg -bar
		selection=$(selection_fun 3)
		case ${selection} in
			1)time=minutes && text=MINUTOS;;
			2)time=hours && text=HORAS;;
			3)[[ -e /etc/gen_at.txt ]] && rm /etc/gen_at.txt && registro auto_eliminar_fijado_en:OFF
			  return;;
			0)return;;
		esac
		echo -ne "ESCRIBA LA CATIDAD DE $text: " && read num	
		[[ ! -z $num ]] && echo $num $time > /etc/gen_at.txt && registro auto_eliminar_fijado_en:ACTIVO TIEMPO_DEFINIDO:$num$text
		gerar_key
fi
}

gerar_key () {
valuekey="$(date | md5sum | head -c10)"
valuekey+="$(echo $(($RANDOM*10))|head -c 5)"
unset KEY
KEY="$valuekey"
#CRIA DIR
[[ ! -e ${DIR} ]] && mkdir ${DIR}
#ENVIA ARQS
i=0
VALUE+="gerar.sh instgerador.sh http-server.py lista-arq $BASICINST"
for arqx in `ls ${SCPT_DIR}`; do
[[ $(echo $VALUE|grep -w "${arqx}") ]] && continue 
echo -e "[$i] -> ${arqx}"
arq_list[$i]="${arqx}"
let i++
done
[[ -e /etc/gen_at.txt ]] && genat="CADA: \033[1;32m$(cat /etc/gen_at.txt)" || genat="\033[1;31mOff"
clear
msg -bar
echo -e "\033[7;49;35m            Seleccione el tipo de Keys               \033[0m"
msg -bar

[[ -e /etc/SCRIPT/gerar.sh ]] && {

menu_func "GENERAR KEY DE INSTALACIÓN ChumoGH" "GENERAR KEY FIJA DE INSTALACIÓN VPS-MX" "GENERAR KEY DE GENERADOR DE KEYS" "AUTO ELIMINACION DE KEY $genat"
msg -bar
echo -ne "$(msg -verd "[0]") $(msg -aqua ">") "&& msg -bra "\033[7;49;35mAtras"
msg -bar
selection=$(selection_fun 4)
case ${selection} in
	1) gen_key_menu 1;;
	2) gen_key_menu 2;;
	3) gen_key_menu 3;;
	4) gen_key_menu 4;;
	0)return;;
esac
} || {
menu_func "GENERAR KEY DE INSTALACIÓN ChumoGH" "GENERAR KEY FIJA DE INSTALACIÓN VPS-MX" "AUTO ELIMINACION DE KEY $genat"
msg -bar
echo -ne "$(msg -verd "[0]") $(msg -aqua ">") "&& msg -bra "\033[7;49;35mAtras"
msg -bar
selection=$(selection_fun 3)
case ${selection} in
	1) gen_key_menu 1;;
