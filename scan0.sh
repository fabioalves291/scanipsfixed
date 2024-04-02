#!/bin/bash

# Diretório onde o script Python está localizado
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Verifica se o arquivo dhcpd.conf existe no diretório padrão
if [ -f "/etc/dhcp/dhcpd.conf" ]; then
    # Copia o arquivo dhcpd.conf para o diretório do script Python
    cp "/etc/dhcp/dhcpd.conf" "$SCRIPT_DIR/dhcpd.conf"
    echo "Arquivo dhcpd.conf copiado para $SCRIPT_DIR."
else
    echo "Arquivo dhcpd.conf não encontrado no diretório padrão (/etc/dhcp/)."
fi

