#!/bin/bash


if [ "$EUID" -ne 0 ]; then 
  echo -e "\e[1;31m[!] ERROR: Este script debe ejecutarse con sudo.\e[0m"
  exit
fi

clear
echo "Iniciando Auto_OSINT por Richard-CyberSec..."
sleep 1


echo -e "\e[1;34m=======================================\e[0m"
echo -e "\e[1;32m   INVESTIGADOR DE PROPIETARIOS OSINT  \e[0m"
echo -e "\e[1;34m=======================================\e[0m"

echo -n "Introduce el NOMBRE COMPLETO: "
read nombre
echo -n "Introduce el DNI/NIE (si no tienes, Enter): "
read dni

echo "[+] Comprobando conexión a internet..."
if ping -c 1 google.com &> /dev/null; then
  echo "[OK] Conexión establecida."
else
  echo "[!] No tienes internet. Revisa tu conexión de Kali."
  exit
fi

echo -e "\n\e[1;33m[+] Paso 1: Abriendo búsquedas estratégicas...\e[0m"

xdg-open "https://www.google.com/search?q=site:linkedin.com+%22${nombre// /+}%22"
xdg-open "https://www.google.com/search?q=%22${nombre// /+}%22+email+OR+contacto+OR+telefono"

if [ ! -z "$dni" ]; then
    xdg-open "https://www.google.com/search?q=%22$dni%22+filetype:pdf"
    xdg-open "https://www.google.com/search?q=%22$dni%22"
fi

echo -e "\n\e[1;32m[!] Revisa las pestañas en el navegador.\e[0m"
echo -n "Introduce el ALIAS para Sherlock (o Enter para saltar): "
read alias

if [ ! -z "$alias" ]; then
    echo -e "\n\e[1;33m[+] Paso 2: Ejecutando Sherlock...\e[0m"
    cd ~/sherlock
    source venv/bin/activate
    python3 -m sherlock_project "$alias" --timeout 5
fi

echo -e "\n\e[1;34m=======================================\e[0m"
echo "Proceso terminado. Presiona Enter para cerrar esta ventana."
read
