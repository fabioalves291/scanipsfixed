
 para extrair IPs fixos do arquivo de configuração do DHCP
 extrair_ips_fixos() {
	     grep -oP "fixed-address\s+\K(\d+\.\d+\.\d+\.\d+)" "$1" | sort -u
     }

# Função para extrair faixas de IPs do arquivo de configuração do DHCP
extrair_faixas_ips() {
	    grep -oP "range\s+\K(\d+\.\d+\.\d+\.\d+)\s+(\d+\.\d+\.\d+\.\d+)" "$1" | sort -u
    }

# Função para listar IPs disponíveis
listar_ips_disponiveis() {
	    faixa_ip_inicio="$1"
	        faixa_ip_fim="$2"
		    ips_fixos=("${@:3}")

		        inicio_octetos=($(echo "$faixa_ip_inicio" | tr '.' ' '))
			    fim_octetos=($(echo "$faixa_ip_fim" | tr '.' ' '))

			        ips_todos=()
				    for ((i = ${inicio_octetos[0]}; i <= ${fim_octetos[0]}; i++)); do
					            for ((j = ${inicio_octetos[1]}; j <= ${fim_octetos[1]}; j++)); do
							                for ((k = ${inicio_octetos[2]}; k <= ${fim_octetos[2]}; k++)); do
										                for ((l = ${inicio_octetos[3]}; l <= ${fim_octetos[3]}; l++)); do
													                    ip="$i.$j.$k.$l"
															                        if ! [[ " ${ips_fixos[@]} " =~ " $ip " ]]; then
																			                        ips_todos+=("$ip")
																						                    fi
																								                    done
																										                done
																												        done
																													    done

																													        echo "${ips_todos[@]}"
																													}

																												# Função principal
																												main() {
																													    nome_arquivo="dhcpd.conf"

																													        # Extrair IPs fixos e faixas de IPs
																														    ips_fixos=($(extrair_ips_fixos "$nome_arquivo"))
																														        faixas_ips=($(extrair_faixas_ips "$nome_arquivo"))

																															    # Mostrar IPs fixos
																															        echo "IPs fixos:"
																																    printf "%s\n" "${ips_fixos[@]}"

																																        # Mostrar faixas de IPs
																																	    echo -e "\nFaixas de IPs:"
																																	        printf "%s\n" "${faixas_ips[@]}"

																																		    # Para cada faixa de IPs, listar IPs disponíveis
																																		        for faixa in "${faixas_ips[@]}"; do
																																				        inicio=$(echo "$faixa" | cut -d' ' -f1)
																																					        fim=$(echo "$faixa" | cut -d' ' -f2)

																																						        # Listar IPs disponíveis na faixa
																																							        echo -e "\nFaixa de IPs configurada: $inicio - $fim"
																																								        echo "IPs disponíveis:"
																																									        listar_ips_disponiveis "$inicio" "$fim" "${ips_fixos[@]}"
																																										    done
																																									    }

																																								    # Executar a função principal
																																								    main#!/bin/bash

# Função para extrair IPs fixos do arquivo de configuração do DHCP
extrair_ips_fixos() {
    grep -oP "fixed-address\s+\K(\d+\.\d+\.\d+\.\d+)" "$1" | sort -u
}

# Função para extrair faixas de IPs do arquivo de configuração do DHCP
extrair_faixas_ips() {
    grep -oP "range\s+\K(\d+\.\d+\.\d+\.\d+)\s+(\d+\.\d+\.\d+\.\d+)" "$1" | sort -u
}

# Função para listar IPs disponíveis
listar_ips_disponiveis() {
    faixa_ip_inicio="$1"
    faixa_ip_fim="$2"
    ips_fixos=("${@:3}")

    inicio_octetos=($(echo "$faixa_ip_inicio" | tr '.' ' '))
    fim_octetos=($(echo "$faixa_ip_fim" | tr '.' ' '))

    ips_todos=()
    for ((i = ${inicio_octetos[0]}; i <= ${fim_octetos[0]}; i++)); do
        for ((j = ${inicio_octetos[1]}; j <= ${fim_octetos[1]}; j++)); do
            for ((k = ${inicio_octetos[2]}; k <= ${fim_octetos[2]}; k++)); do
                for ((l = ${inicio_octetos[3]}; l <= ${fim_octetos[3]}; l++)); do
                    ip="$i.$j.$k.$l"
                    if ! [[ " ${ips_fixos[@]} " =~ " $ip " ]]; then
                        ips_todos+=("$ip")
                    fi
                done
            done
        done
    done

    echo "${ips_todos[@]}"
}

# Função principal
main() {
    nome_arquivo="dhcpd.conf"

    # Extrair IPs fixos e faixas de IPs
    ips_fixos=($(extrair_ips_fixos "$nome_arquivo"))
    faixas_ips=($(extrair_faixas_ips "$nome_arquivo"))

    # Mostrar IPs fixos
    echo "IPs fixos:"
    printf "%s\n" "${ips_fixos[@]}"

    # Mostrar faixas de IPs
    echo -e "\nFaixas de IPs:"
    printf "%s\n" "${faixas_ips[@]}"

    # Para cada faixa de IPs, listar IPs disponíveis
    for faixa in "${faixas_ips[@]}"; do
        inicio=$(echo "$faixa" | cut -d' ' -f1)
        fim=$(echo "$faixa" | cut -d' ' -f2)

        # Listar IPs disponíveis na faixa
        echo -e "\nFaixa de IPs configurada: $inicio - $fim"
        echo "IPs disponíveis:"
        listar_ips_disponiveis "$inicio" "$fim" "${ips_fixos[@]}"
    done
}

# Executar a função principal
main
