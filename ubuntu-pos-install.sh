#!/usr/bin/env bash

#---------- Pos Instalação do Ubuntu 22.04.2 LTS ----------#
#
#
# Autor: Victor Andrade
# Github: https://github.com/Victor-M-Andrade
#
#
#----------------------------------------------------------#
#
# Como Usar?
#
#   $ ./pos_install_ubuntu.sh
#
#----------------------------------------------------------#



#CORES
AMARELO='\e[1;93m'
AZUL='\e[1;94m'
VERMELHO='\e[1;91m'
VERDE='\e[1;92m'
SEM_COR='\e[0m'


# Atualizando o sistema e o repositorio
apt_update(){
    sudo apt update && sudo apt dist-upgrade -y
}


#Removendo as travas do apt
travas_apt(){
  sudo rm /var/lib/dpkg/lock-frontend
  sudo rm /var/cache/apt/archives/lock
}


#Atualizando o repositorio
just_apt_update(){
    sudo apt update -y
}


#Adicionando a funcionalidade do flatpak e reiniciando a maquina
install_flatpak(){
    sudo apt install flatpak
    sudo apt install gnome-software-plugin-flatpak
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    shutdown -r now
}


#Programas para instalar via flatpak
PROGRAMAS_FLATPAKS=(
    com.google.Chrome
    com.discordapp.Discord
    com.opera.Opera
    com.visualstudio.code
    com.axosoft.GitKraken
    com.anydesk.Anydesk
    com.spotify.Client
    io.github.jorchube.monitorets
    com.valvesoftware.Steam
    io.github.jeffshee.Hidamari
    org.flameshot.Flameshot
    org.gimp.GIMP
    org.inkscape.Inkscape
    org.kde.krita
    org.libretro.RetroArch
)


#Instalando flatpaks
install_flatpaks_programs(){
    for programa in ${PROGRAMAS_FLATPAKS[@]};
        do
            sudo flatpak install flathub "$programa" -y
        done
}


#Menu
Menu() {

    clear

  echo -e "${VERDE}--------------------------------------------------------"

  echo -e "${AMARELO}#---------- SCRIPT PÓS INSTALANÇÃO DO UBUNTU ----------#"

  echo -e "\n${AZUL}                       INSTRUÇÕES"

  echo -e "${SEM_COR}   1) Faça a instalação do pacote de flatpak"

  echo -e "${SEM_COR}   2) Espere seu computador reiniciar"

    echo -e "${SEM_COR}   3) Abra novamente esse script"

    echo -e "${SEM_COR}   4) Escolha a opção 2 para finalizar"

  echo -e "${VERDE}--------------------------------------------------------"



  echo -e "${VERMELHO}Opções:\n${SEM_COR}"

  echo "1. Instalar pacote flatpak"

  echo "2. Iniciar instalação dos aplicativos"

  echo "3. Sair do script"


  echo -n -e "\nQual a opção desejada? "

  read opcao

  case $opcao in

    1) install_flatpak ;;

    2) travas_apt; apt_update; just_apt_update; install_flatpaks_programs; apt_update ;;

    3) exit ;;

    *) "Opção desconhecida." ; echo ; Menu ;;

  esac

}


Menu