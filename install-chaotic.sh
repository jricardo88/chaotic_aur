#!/bin/bash

# Colores para una mejor interfaz
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Limpiar pantalla para la bienvenida
clear

echo -e "${CYAN}==========================================${NC}"
echo -e "${CYAN}    CHAOTIC-AUR AUTOMATED INSTALLER       ${NC}"
echo -e "${CYAN}==========================================${NC}"

# 1. Verificación si ya está instalado
if grep -q "\[chaotic-aur\]" /etc/pacman.conf && [ -f /etc/pacman.d/chaotic-mirrorlist ]; then
    echo -e "${YELLOW}Aviso:${NC} Parece que Chaotic-AUR ya está configurado en tu sistema."
    echo -e "¿Deseas intentar reinstalarlo de todas formas? (s/n)"
    read -r response
    if [[ ! "$response" =~ ^([sS][iI]|[sS])$ ]]; then
        echo -e "${RED}Instalación cancelada.${NC}"
        exit 0
    fi
else
    echo -e "${YELLOW}Este script añadirá el repositorio Chaotic-AUR a tu sistema.${NC}"
    echo -e "Esto permitirá instalar paquetes pre-compilados del AUR directamente."
    echo -e "\nPresiona ${GREEN}ENTER${NC} para continuar o ${RED}Ctrl+C${NC} para cancelar."
    read -r
fi

echo -e "${GREEN}Iniciando configuración...${NC}"

# 2. Recibir y firmar la llave primaria
echo -e "\n${CYAN}[1/4]${NC} Recibiendo y firmando llaves GPG..."
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB

# 3. Instalar el keyring y la mirrorlist
echo -e "\n${CYAN}[2/4]${NC} Instalando chaotic-keyring y mirrorlist..."
sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

# 4. Añadir al final de /etc/pacman.conf si no existe ya
echo -e "\n${CYAN}[3/4]${NC} Configurando /etc/pacman.conf..."
if ! grep -q "\[chaotic-aur\]" /etc/pacman.conf; then
    echo -e "\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf
    echo -e "${GREEN}Repositorio añadido correctamente.${NC}"
else
    echo -e "${YELLOW}El repositorio ya estaba en pacman.conf, saltando paso.${NC}"
fi

# 5. Actualizar bases de datos
echo -e "\n${CYAN}[4/4]${NC} Sincronizando bases de datos..."
sudo pacman -Sy

echo -e "\n${GREEN}==========================================${NC}"
echo -e "${GREEN}   ¡INSTALACIÓN COMPLETADA CON ÉXITO!     ${NC}"
echo -e "${GREEN}==========================================${NC}"
echo -e "${YELLOW}Recomendación:${NC} Es altamente aconsejable realizar una"
echo -e "actualización completa del sistema ahora ejecutando:"
echo -e "${CYAN}sudo pacman -Syu${NC}\n"
