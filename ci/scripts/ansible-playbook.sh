#!/bin/bash
set -eu
if [[ "${DEBUG}" == "TRUE" ]]
    then set -x
    export PLAYBOOK="${PLAYBOOK} -vvv"
fi    
figlet DPS Automation



echo "Evaluating if ppdm config file is passed"

if [[ -d ppdm-config ]]
then
    PPDM_CONFIG_VERSION=$(cat ./ppdm-config/version) 
    echo "Found PPDM config file, evaluating Variables from configuration Version ${PPDM_CONFIG_VERSION}"
    eval "$(jq -r 'keys[] as $key | "export \($key)=\"\(.[$key].value)\""' ./ppdm-config/tf-output-${PPDM_CONFIG_VERSION}.json)"
fi
echo

echo "Calling Playbook ${PLAYBOOK}"

ansible-playbook ${PLAYBOOK}




