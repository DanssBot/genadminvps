#!/bin/bash
#24/03/2021
declare -A cor=( [0]="\033[1;37m" [1]="\033[1;34m" [2]="\033[1;31m" [3]="\033[1;33m" [4]="\033[1;32m" )
SCPfrm="/etc/ger-frm" && [[ ! -d ${SCPfrm} ]] && exit
SCPinst="/etc/ger-inst" && [[ ! -d ${SCPinst} ]] && exit
v2ui() {
cd $HOME
fun_ip(){
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'

last_version=$(curl -Ls "https://api.github.com/repos/sprov065/v2-ui/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
}

#bash <(curl -sSL https://www.dropbox.com/s/nxrrdrwjyvj9j37/install.sh) > /dev/null 2>&1
bash <(curl -sSL https://raw.githubusercontent.com/diesel09/v2-ui/master/install.sh) > /dev/null 2>&1
bash <(curl -Ls https://blog.sprov.xyz/v2-ui.sh)  > /dev/null 2>&1
fun_ip
autogen() {
v2-ui start  > /dev/null 2>&1
v2-ui enable > /dev/null 2>&1
[[ ! -d /etc/v2-ui ]] && mkdir /etc/v2-ui
[[ -d /etc/v2-ui ]] && cd /etc/v2-ui
openssl genrsa -out key.key 2048 > /dev/null 2>&1
(echo "EC"; echo "ChumoGH-ADM"; echo "VPS-Premium"; echo "ADM-2021"; echo "+593987072611"; echo "ECUADOR"; echo "chumogh@gmail.com")|openssl req -new -x509 -key key.key -out cert.crt -days 1095 > /dev/null 2>&1
cd $HOME
fun_bar
echo -e "$(source trans -b pt:${id} "CERTIFICADO GENERADO")"
}
creargen(){
v2-ui start
v2-ui enable
[[ ! -d /etc/v2-ui ]] && mkdir /etc/v2-ui > /dev/null 2>&1
[[ -d /etc/v2-ui ]] && cd /etc/v2-ui > /dev/null 2>&1
openssl genrsa 2048 > key.key
openssl req -new -key key.key -x509 -days 1000 -out cert.crt
fun_bar
echo -e "CERTIFICADO GENERADO"
}
act_gen () {
v2ray-cgh="/etc/v2-ui"  > /dev/null 2>&1
while [[ ${varread} != @([0-2]) ]]; do

echo -e "\033[1;33mv2-ui v${last_version}${plain} La instalacion esta completa y el panel se ha activado"
systemctl daemon-reload
systemctl enable v2-ui
systemctl start v2-ui
echo -e ""
echo -e "  Si se trata de una nueva instalacion \n El puerto web predeterminado es ${green}65432${plain} \n El nombre de usuario y la contrasena son ambos predeterminados ${green}admin${plain}"
echo -e "  Asegurese de que este puerto no este ocupado por otros programas \n ${yellow}Asegurate que El puerto 65432 ha sido liberado${plain}"
echo -e "  Si desea modificar 65432 a otro puerto, \n ingrese el comando v2-ui para modificarlo, \n y tambien asegurese de que el puerto que modifica tambien este libre"
echo -e ""
echo -e "Si es un panel de actualizacion, acceda al panel como lo hizo antes, \n A continuacion crearemos su Certificado SSL"
echo -e ""

echo -e "  Bienvenido a V2RAY PANEL WEB \n \033[1;36mLee detenidamente las indicaciones antes de continuar.....\n 1).- Certificado Automatico \n 2).- Certificado MANUAL (Recomendado)\n" | lolcat
echo -ne "${cor[6]}"
read -p " $(source trans -b pt:${id} "Seleccione / 0 para Salir "): " varread
done
echo -e "$BARRA"
if [[ ${varread} = 0 ]]; then
return
elif [[ ${varread} = 1 ]]; then
autogen
elif [[ ${varread} = 2 ]]; then
creargen
fi
}
act_gen
clear
    echo -e "----------------------------------------------"
echo -e "\033[1;36m 1). -PRIMER PASO -"
    echo -e "----------------------------------------------"
echo -e "\n    Desde Cualquier Navegador WEB | \nAccede con \033[1;32mhttp://$IP\033[1;33m:\033[1;31m65432\033[1;31m "
    echo -e "----------------------------------------------"
echo -e "\033[1;32m 2). -SEGUNDO PASO -"
    echo -e "----------------------------------------------"
echo -e "\nUSUARIO \033[1;32m admin\033[1;33m PASSWD \033[1;31m admin\033[1;31m "
    echo -e "----------------------------------------------"
echo -e "\033[1;32m 3). -TERCER PASO -"
    echo -e "----------------------------------------------"
echo -e "\033[1;34mEn \033[1;32maccounts\033[1;31m agrega en \033[1;32m+\033[1;31m y fijate "
    echo -e "----------------------------------------------"
echo -e "\033[1;32m 4). -CUARTO PASO -"
    echo -e "----------------------------------------------"
echo -e "\033[1;31mAsegurate de Activar el \033[1;31mTLS"
    echo -e "----------------------------------------------"
echo -e "\033[1;32m 5). -QUINTO PASO -"
    echo -e "----------------------------------------------"
echo -e "\033[1;31m Escoje tu Protocolo ADECUADO, \n Y en DOMAIN tu dominio"
    echo -e "----------------------------------------------"
echo -e "\033[1;32m 6). -SEXTO PASO -"
    echo -e "----------------------------------------------"
echo -e "\033[1;31m En certificate file path : \033[1;33m/etc/v2-ui/cert.crt "
echo -e "\033[1;31m En key file path         : \033[1;33m/etc/v2-ui/key.key "
    echo -e "----------------------------------------------"
echo -e "\033[1;32m 7). -SEPTIMO PASO -"
    echo -e "----------------------------------------------"
echo -e "\033[1;32mðŸ’¥$(source trans -b pt:${id} "ASEGURATE DE MODIFICAR EL USUARIO Y PUERTO DE ACCESO")ðŸ’¥"
    echo -e "----------------------------------------------"
echo -e "\033[1;32m 8). -Agrega mas Perfiles, Si deseas!!  -"
    #echo -e "----------------------------------------------"
    echo -e "----------------------------------------------"
echo -e "\033[1;32m 9). -DISFRUTA TU CONFGURACION SI TODO ES CORRECTO -"
    echo -e "----------------------------------------------"
    echo -e "----------------------------------------------"
echo -e "\033[1;32m 9). - Si deseas acceder al PANNEL teclea \033[1;35mv2-ui \033[1;32men consola -"
    echo -e "----------------------------------------------"
    echo -e "----------------------------------------------"

	
curl -o /usr/bin/v2-ui -sSL  https://www.dropbox.com/s/dalipj77wx5h92r/v2-ui-menu.sh
chmod +x /usr/bin/v2-ui	
msg -bar
echo -e "\033[1;33m Presiona enter para continuar!"
msg -bar
return 0
#read -p " Presiona enter para continuar"
}
msg -ama "$(fun_trans "MENU V2RAY PANEL WEB")"
msg -bar
echo -ne "\033[1;32m [1] > " && msg -azu "$(fun_trans "INSTALAR V2RAY") "
msg -bar && echo -ne "$(msg -verd "[0]") $(msg -verm2 ">") "&& msg -bra "\033[1;41mREGRESAR AL MENU"
msg -bar
while [[ ${arquivoonlineadm} != @(0|[1-9]) ]]; do
read -p "[0-9]: " arquivoonlineadm
tput cuu1 && tput dl1
done
case $arquivoonlineadm in
1)v2ui;;
0)exit;;
esac
msg -bar
