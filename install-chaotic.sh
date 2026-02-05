#!/bin/bash

# Colores para la salida
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}Iniciando configuración de Chaotic-AUR...${NC}"

# 1. Recibir y firmar la llave primaria
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB

# 2. Instalar el keyring y la mirrorlist
sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

# 3. Añadir al final de /etc/pacman.conf si no existe ya
if ! grep -q "\[chaotic-aur\]" /etc/pacman.conf; then
    echo -e "${GREEN}Añadiendo repositorio a /etc/pacman.conf...${NC}"
    echo -e "\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf
else
    echo "El repositorio ya está configurado en /etc/pacman.conf."
fi

# 4. Actualizar bases de datos
sudo pacman -Sy

echo -e "${GREEN}¡Listo! Chaotic-AUR ha sido instalado correctamente.${NC}"
