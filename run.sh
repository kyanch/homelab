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
		compose_files="$compose_files --file ${dir}docker-compose.yml" 
	fi 
done

#echo ${compose_files}

sudo docker compose \
	--env-file "${PWD}/.env" \
	--project-directory "${PWD}" \
	-p homelab_rpi ${compose_files} \
	$@
