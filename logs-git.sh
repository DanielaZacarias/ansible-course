#!/bin/bash

#### echo COLORS ####
GREEN='\e[92m'
YELLOW='\e[93m'
NC='\033[m'

#### CREATING A TIMESTAMP VARIABLE FOR THE NAME OF THE OUTPUT FILE ####
TIMESTAMP=`date +%F-%H:%M:%S`

#### RUNNING ANSIBLE - LOG OUTPUT TO FILE ####
echo -e "${YELLOW}Running Ansible with playbook $1 ... ${NC}"

ansible-playbook $1

#### SEND LOGS TO REPO ####
echo -e "${YELLOW}Sending logs to repository... ${NC}"
git pull
git add logs/*
git commit -m "Ansible Output Logs from  ${TIMESTAMP}"
git push

#### DONE ####
echo -e "${GREEN}Done${NC}"
