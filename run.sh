#!/bin/bash

CHECK_NETWORK=1

# Check `nginx-proxy` network
if [ "${CHECK_NETWORK}" == "1" ] && [[ -z "$(sudo docker network ls -qf 'name=nginx-proxy')" ]]; then
    sudo docker network create nginx-proxy
fi

# Gather compose infos
compose_files=""

for dir in */; do
    #echo ${dir}
    if [[ -f "${dir}docker-compose.yml" ]]; then
        compose_files="$compose_files -f ${dir}docker-compose.yml"
    fi
done

echo ${compose_files}

sudo docker compose -p homelab_rpi ${compose_files} $@
