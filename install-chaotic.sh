#!/bin/bash

# Función principal para evitar problemas de ejecución parcial
install_chaotic() {
    # Colores
    GREEN='\033[0;32m'
    CYAN='\033[0;36m'
    YELLOW='\033[1;33m'
    RED='\033[0;31m'
    NC='\033[0m'

    clear
    echo -e "${CYAN}==========================================${NC}"
    echo -e "${CYAN}    CHAOTIC-AUR AUTOMATED INSTALLER       ${NC}"
    echo -e "${CYAN}==========================================${NC}"

    # 1. Verificación de instalación previa
    if grep -q "\[chaotic-aur\]" /etc/pacman.conf && [ -f /etc/pacman.d/chaotic-mirrorlist ]; then
        echo -e "${YELLOW}Aviso:${NC} Chaotic-AUR ya está configurado en tu sistema."
        echo -n -e "¿Deseas reinstalarlo? (s/N): "
        # Forzamos la lectura desde la terminal actual
        read -r response < /dev/tty
        
        if [[ ! "$response" =~ ^([sS][iI]|[sS])$ ]]; then
            echo -e "${RED}Instalación cancelada.${NC}"
            return 0
        fi
    else
        echo -e "${YELLOW}Este script configurará Chaotic-AUR en tu sistema.${NC}"
        echo -e "Presiona ${GREEN}ENTER${NC} para continuar o ${RED}Ctrl+C${NC} para salir."
        read -r < /dev/tty
    fi

    # 2. Proceso de instalación
    echo -e "${GREEN}Iniciando...${NC}"

    echo -e "\n${CYAN}[1/4]${NC} Configurando llaves GPG..."
    sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com && \
    sudo pacman-key --lsign-key 3056513887B78AEB

    echo -e "\n${CYAN}[2/4]${NC} Descargando paquetes base..."
    sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

    echo -e "\n${CYAN}[3/4]${NC} Modificando /etc/pacman.conf..."
    if ! grep -q "\[chaotic-aur\]" /etc/pacman.conf; then
        echo -e "\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf
    fi

    echo -e "\n${CYAN}[4/4]${NC} Sincronizando bases de datos..."
    sudo pacman -Sy

    echo -e "\n${GREEN}==========================================${NC}"
    echo -e "${GREEN}   ¡INSTALACIÓN COMPLETADA!               ${NC}"
    echo -e "${GREEN}==========================================${NC}"
    echo -e "${YELLOW}Nota:${NC} Ejecuta ${CYAN}sudo pacman -Syu${NC} para finalizar."
}

# Ejecutar la función
install_chaotic
