#!/bin/bash

#### echo COLORS ####
GREEN='\e[92m'
YELLOW='\e[93m'
NC='\033[m'

#### CREATING A TIMESTAMP VARIABLE FOR THE NAME OF THE OUTPUT FILE ####
TIMESTAMP=`date +%F_%Hh-%Mm-%Ss`

#### RUNNING ANSIBLE - LOG OUTPUT TO FILE ####
echo -e "${YELLOW}Running Ansible with playbook $1 ... ${NC}"
ansible-playbook $1 -v > "logs/ansible-output_${TIMESTAMP}.log"
cat "logs/ansible-output_${TIMESTAMP}.log"
echo -e "${YELLOW}ANSIBLE OUTPUT: ${GREEN}logs/ansible-output_${TIMESTAMP}.log${NC}"

#### COMPRESSING THE LOGS ####
echo -e "${YELLOW}Compressing log files... ${NC}"
tar -cvf logs/ansible-output_${TIMESTAMP}.tar logs/ansible-output_${TIMESTAMP}.log

#### SEND LOGS TO REPO ####
echo -e "${YELLOW}Sending logs to repository... ${NC}"
git pull
git add logs/ansible-output_${TIMESTAMP}.tar
git commit -m "Ansible Output Logs from  ${TIMESTAMP}"
git push

#### DONE ####
echo -e "${GREEN}Done${NC}"
