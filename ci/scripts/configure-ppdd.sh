#!/bin/bash
set -eu
[[ "${DEBUG}" == "TRUE" ]] && set -x

echo "installing jq...."
DEBIAN_FRONTEND=noninteractive apt-get install -qq jq < /dev/null > /dev/null

echo "requesting API token"

source dps_modules/ci/functions/ppdd_functions.sh

export GOVC_VM_IPATH=${GOVC_DATACENTER}/${DDVE_FOLDER}/${DDVE_VMNAME}

export DDVE_DOMAIN=$(echo $DDVE_FQDN | cut -d'.' -f2-)
ddsh net config ethV1 dhcp no
ddsh net config ethV1 type fixed ${DDVE_ADDRESS} netmask ${DDVE_NETMASK}
ddsh net route add gateway ${DDVE_GATEWAY}
ddsh net set dns ${DDVE_DNS}
ddsh net set hostname ${DDVE_HOSTNAME}
ddsh net set searchdomain  ${DDVE_DOMAIN}
ddsh elicense reset restore-evaluation

